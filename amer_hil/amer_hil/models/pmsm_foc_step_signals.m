function [Da, Db, Dc, gate_en, fault, Id, Iq, Vd, Vq, theta_e] = pmsm_foc_step_signals( ...
    Iabc, Udc, theta, rpm, sensor_fault, Start, Id_ref, Iq_ref, speed_ref, ctrl_mode, fault_reset, ...
    pp, Id_Kp, Id_Ki, Iq_Kp, Iq_Ki, Speed_Kp, Speed_Ki, Speed_Iq_limit, I_limit, Udc_min, modulation_limit)
%PMSM_FOC_STEP_SIGNALS Code-generation friendly scalar PMSM FOC core.
%
% This wrapper avoids bus and struct inference inside MATLAB Function blocks.

%#codegen

persistent id_int iq_int speed_int latched_fault

if isempty(id_int)
    id_int = single(0);
    iq_int = single(0);
    speed_int = single(0);
    latched_fault = false;
end

if fault_reset
    id_int = single(0);
    iq_int = single(0);
    speed_int = single(0);
    latched_fault = false;
end

ia = single(Iabc(1));
ib = single(Iabc(2));
ic = single(Iabc(3));
udc = single(Udc);
theta_m = single(theta);

ialpha = ia;
ibeta = (ia + single(2)*ib)/single(sqrt(3));

theta_e = wrap_pi(single(pp) * theta_m);
c = single(cos(theta_e));
s = single(sin(theta_e));

Id =  c*ialpha + s*ibeta;
Iq = -s*ialpha + c*ibeta;

fault_now = logical(sensor_fault) || udc < single(Udc_min) || ...
    abs(ia) > single(I_limit) || abs(ib) > single(I_limit) || abs(ic) > single(I_limit);
latched_fault = latched_fault || fault_now;

enable = logical(Start) && ~latched_fault;
speed_mode = uint8(ctrl_mode) == uint8(1);

id_ref_limited = clamp_single(single(Id_ref), -single(I_limit), single(I_limit));
iq_ref_limited = clamp_single(single(Iq_ref), -single(I_limit), single(I_limit));

if enable && speed_mode
    speed_err = single(speed_ref) - single(rpm);
    iq_speed_unsat = single(Iq_ref) + single(Speed_Kp)*speed_err + speed_int;
    iq_ref_limited = clamp_single(iq_speed_unsat, -single(Speed_Iq_limit), single(Speed_Iq_limit));

    if iq_speed_unsat == iq_ref_limited || sign_nozero(speed_err) ~= sign_nozero(iq_speed_unsat)
        speed_int = speed_int + single(Speed_Ki)*speed_err;
    end
else
    speed_int = single(0);
end

if enable
    ed = id_ref_limited - Id;
    eq = iq_ref_limited - Iq;

    vd_unsat = single(Id_Kp)*ed + id_int;
    vq_unsat = single(Iq_Kp)*eq + iq_int;

    vmax = single(modulation_limit) * udc;
    [Vd, Vq, saturated] = limit_vector(vd_unsat, vq_unsat, vmax);

    if ~saturated || sign_nozero(ed) ~= sign_nozero(vd_unsat)
        id_int = id_int + single(Id_Ki)*ed;
    end
    if ~saturated || sign_nozero(eq) ~= sign_nozero(vq_unsat)
        iq_int = iq_int + single(Iq_Ki)*eq;
    end
else
    Vd = single(0);
    Vq = single(0);
    id_int = single(0);
    iq_int = single(0);
end

valpha = c*Vd - s*Vq;
vbeta = s*Vd + c*Vq;

va = valpha;
vb = -single(0.5)*valpha + single(sqrt(3)/2)*vbeta;
vc = -single(0.5)*valpha - single(sqrt(3)/2)*vbeta;
vmax_phase = max(max(va, vb), vc);
vmin_phase = min(min(va, vb), vc);
vzero = -single(0.5)*(vmax_phase + vmin_phase);

if udc > single(0)
    Da = single(0.5) + (va + vzero)/udc;
    Db = single(0.5) + (vb + vzero)/udc;
    Dc = single(0.5) + (vc + vzero)/udc;
else
    Da = single(0.5);
    Db = single(0.5);
    Dc = single(0.5);
end

if ~enable
    Da = single(0.5);
    Db = single(0.5);
    Dc = single(0.5);
end

Da = clamp_single(Da, single(0), single(1));
Db = clamp_single(Db, single(0), single(1));
Dc = clamp_single(Dc, single(0), single(1));
gate_en = logical(enable);
fault = logical(latched_fault);
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
