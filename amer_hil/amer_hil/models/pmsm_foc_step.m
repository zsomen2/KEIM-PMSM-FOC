function [control, debug] = pmsm_foc_step(sensor, par, reset, cfg)
%PMSM_FOC_STEP Torque-mode PMSM FOC controller core.
%
% This function is intended for a MATLAB Function block in pmsm_control.slx.
% It keeps the d/q PI integrator states internally and returns phase duty
% ratios in the 0..1 range.

%#codegen

persistent id_int iq_int speed_int latched_fault

if isempty(id_int)
    id_int = single(0);
    iq_int = single(0);
    speed_int = single(0);
    latched_fault = false;
end

if reset || par.fault_reset
    id_int = single(0);
    iq_int = single(0);
    speed_int = single(0);
    latched_fault = false;
end

ia = single(sensor.Iabc(1));
ib = single(sensor.Iabc(2));
ic = single(sensor.Iabc(3));
udc = single(sensor.Udc);
theta_m = single(sensor.theta);

% Clarke transform for a balanced three-phase system.
ialpha = ia;
ibeta = (ia + single(2)*ib)/single(sqrt(3));

theta_e = wrap_pi(single(cfg.pp) * theta_m);
c = single(cos(theta_e));
s = single(sin(theta_e));

% Park transform.
id =  c*ialpha + s*ibeta;
iq = -s*ialpha + c*ibeta;

fault_now = sensor.fault || udc < single(cfg.Udc_min) || ...
    abs(ia) > single(cfg.I_limit) || abs(ib) > single(cfg.I_limit) || abs(ic) > single(cfg.I_limit);
latched_fault = latched_fault || fault_now;

enable = par.Start && ~latched_fault;
speed_mode = uint8(par.ctrl_mode) == uint8(1);

id_ref = clamp_single(single(par.Id_ref), -single(cfg.I_limit), single(cfg.I_limit));
iq_ref = clamp_single(single(par.Iq_ref), -single(cfg.I_limit), single(cfg.I_limit));

if enable && speed_mode
    speed_err = single(par.speed_ref) - single(sensor.rpm);
    iq_speed_unsat = single(par.Iq_ref) + single(cfg.Speed_Kp)*speed_err + speed_int;
    iq_ref = clamp_single(iq_speed_unsat, -single(cfg.Speed_Iq_limit), single(cfg.Speed_Iq_limit));

    if iq_speed_unsat == iq_ref || sign_nozero(speed_err) ~= sign_nozero(iq_speed_unsat)
        speed_int = speed_int + single(cfg.Speed_Ki)*speed_err;
    end
else
    speed_int = single(0);
end

if enable
    ed = id_ref - id;
    eq = iq_ref - iq;

    vd_unsat = single(cfg.Id_Kp)*ed + id_int;
    vq_unsat = single(cfg.Iq_Kp)*eq + iq_int;

    vmax = single(cfg.modulation_limit) * udc;
    [vd, vq, saturated] = limit_vector(vd_unsat, vq_unsat, vmax);

    % Conditional integration anti-windup.
    if ~saturated || sign_nozero(ed) ~= sign_nozero(vd_unsat)
        id_int = id_int + single(cfg.Id_Ki)*ed;
    end
    if ~saturated || sign_nozero(eq) ~= sign_nozero(vq_unsat)
        iq_int = iq_int + single(cfg.Iq_Ki)*eq;
    end
else
    vd = single(0);
    vq = single(0);
    saturated = false;
    id_int = single(0);
    iq_int = single(0);
end

% Inverse Park transform.
valpha = c*vd - s*vq;
vbeta = s*vd + c*vq;

% Center-aligned space-vector style zero-sequence injection.
va = valpha;
vb = -single(0.5)*valpha + single(sqrt(3)/2)*vbeta;
vc = -single(0.5)*valpha - single(sqrt(3)/2)*vbeta;
vmax_phase = max(max(va, vb), vc);
vmin_phase = min(min(va, vb), vc);
vzero = -single(0.5)*(vmax_phase + vmin_phase);

if udc > single(0)
    da = single(0.5) + (va + vzero)/udc;
    db = single(0.5) + (vb + vzero)/udc;
    dc = single(0.5) + (vc + vzero)/udc;
else
    da = single(0.5);
    db = single(0.5);
    dc = single(0.5);
end

if ~enable
    da = single(0.5);
    db = single(0.5);
    dc = single(0.5);
end

control = struct( ...
    'Da', clamp_single(da, single(0), single(1)), ...
    'Db', clamp_single(db, single(0), single(1)), ...
    'Dc', clamp_single(dc, single(0), single(1)), ...
    'gate_en', logical(enable), ...
    'fault', logical(latched_fault));

debug = struct( ...
    'Ialpha', ialpha, ...
    'Ibeta', ibeta, ...
    'Id', id, ...
    'Iq', iq, ...
    'Vd', vd, ...
    'Vq', vq, ...
    'Valpha', valpha, ...
    'Vbeta', vbeta, ...
    'theta_e', theta_e, ...
    'sat', logical(saturated));
end

function y = clamp_single(x, lo, hi)
%#codegen
y = min(max(x, lo), hi);
end

function y = wrap_pi(x)
%#codegen
two_pi = single(2*pi);
y = x - two_pi*floor((x + single(pi))/two_pi);
end

function [x_lim, y_lim, saturated] = limit_vector(x, y, limit)
%#codegen
mag = single(sqrt(x*x + y*y));
if mag > limit && mag > single(0)
    scale = limit/mag;
    x_lim = x*scale;
    y_lim = y*scale;
    saturated = true;
else
    x_lim = x;
    y_lim = y;
    saturated = false;
end
end

function y = sign_nozero(x)
%#codegen
if x >= single(0)
    y = int8(1);
else
    y = int8(-1);
end
end
