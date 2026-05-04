# PMSM Control Bring-Up and Validation Guide

Ez az utmutato a `pmsm_control` workflow-hoz keszult, a jelenlegi repo-allapot alapjan.

Fontos egyszerusites:

- itt sem reszletezem a kulso hardveres bekotest
- a hangsuly a generalason, a feltoltesen, a monitorozason es a gyors validacion van
- ahol a repo allapota nem teljesen egyertelmu, azt kulon jelzem

## 1. Mi tartozik a `pmsm_control` workflow-hoz

A fontosabb modellek:

- `models/pmsm_control.slx` -> fo PMSM controller + plant integration modell
- `models/pmsm_hil.slx` -> PMSM FPGA/HIL oldalhoz hasznos kulon modell

A `pmsm_control.slx`-ben a repo szerint ket fontos embedded harness van:

- `Controller_DSP`
- `pmsm_FPGA_HIL`

Owner path-ok:

- `Controller_DSP` -> `pmsm_control/Controller`
- `pmsm_FPGA_HIL` -> `pmsm_control/Plant/Plant_PMSM_HIL`

Fontos gyakorlati kovetkezmeny:

- a DSP build ugyanarra a fajlnev-parra general, mint az `RLUb`: `Controller_DSP.out` es `Controller_DSP.mhx`
- az FPGA build ugyanarra a tipikus bitstream-nevre general: `design_1_wrapper.bit`

Ezert a PMSM build felul tudja irni az elozo `RLUb` build kimeneteit, ha ugyanazokat a target mappakat hasznalod.

## 2. Elofeltetelek

Szukseges szoftverek:

- `MATLAB/Simulink R2018b`
- `Simulink Test`
- `Embedded Coder`
- `HDL Coder`
- `Embedded Coder Support Package for Texas Instruments C2000 Processors`
- `Vivado 2018.2.x`
- `Code Composer Studio`
- opcionlisan `SW Downloader`

Projekt gyoker ebben az utmutatoban:

- `amer_hil/amer_hil`

Ajlott indulasi lepes:

```powershell
.\qra.bat
```

Ez felhuzza a `Q:` meghajtot, amit a meglevo `SW Downloader` es `HiTermD.ini` is hasznal.

## 3. Fontos kulonbseg az `RLUb`-hoz kepest

A `pmsm_control` top-level modell nem kuldheto kozvetlenul FPGA HDL generalasra.

A repo-ban levo HDL check report:

- `work/hdlsrc/pmsm_control/pmsm_control_report.html`

ennek a top-level modellnek tobb tucat HDL inkompatibilis hibat jelez, tipikusan:

- function-call trigger
- scheduler blokkok
- HDL altal nem tamogatott top-level struktura

Gyakorlati szabaly:

- DSP buildhez a `Controller_DSP` harness-t hasznald
- FPGA buildhez a `pmsm_FPGA_HIL` harness-t hasznald
- ne a fo `pmsm_control.slx` nezetre nyomj ra direkt HDL generalast

## 4. Altalanos MATLAB elokeszites

Ajlott indulasi szekvencia MATLAB-ban:

```matlab
cd('C:\Users\Marci\Downloads\KEIM-PMSM-FOC\amer_hil\amer_hil');
addpath(fullfile(pwd, 'models'));
pmsm_control_init;
load_system('pmsm_control');
```

A `pmsm_control_init.m` fo szerepe:

- betolti a PMSM parametereket a `pmsm_init`-en keresztul
- letrehozza a bus objecteket (`RLUb_data_types`, `pmsm_data_types`)
- beallitja a FOC idoziteset es PI parameteret
- exportalt runtime valtozokat hoz letre

A fontosabb exportalt runtime parancsok:

- `Start`
- `Id_ref`
- `Iq_ref`
- `speed_ref`
- `ctrl_mode`
- `fault_reset`

Sebessegszabalyozas:

- `ctrl_mode = uint8(0)` -> aramszabalyozas, az `Iq_ref` kozvetlenul megy az aramhurokba
- `ctrl_mode = uint8(1)` -> sebessegszabalyozas, a speed PI az `rpm` visszacsatolasbol `Iq_ref` parancsot kepez
- `speed_ref` mertekegysege rpm
- `Iq_ref` sebessegmodban eloretolas/offset marad, alapbol hagyd `0`-n

## 5. Szimulacios gyorsvalidacio build elott

Mielott hardverre generalnal, erdemes a ket meglevo ellenorzo futast lefuttatni.

### 5.1. Sanity check

Futtatas:

```matlab
addpath(fullfile(pwd, 'models'));
pmsm_control_init;
run_pmsm_control_sanity_check;
```

Mit csinal:

- betolti a `pmsm_control` modellt
- fixlepeses diszkret szimulatorra all
- ket tesztet fut:
  - `StartOff`
  - `StartOnIq5`

Pass feltetelek a script szerint:

- `StartOff`: a gate maradjon tiltva
- `StartOnIq5`: a gate kapcsoljon be
- ne legyen controller vagy sensor fault
- a duty maradjon `0..1` kozott
- aktiv tesztnel az `Iq` tenylegesen mozduljon

Sikeres futas vegi uzenet:

- `PMSM_CONTROL_SANITY_CHECK_OK`

### 5.2. Mechanical validation

Futtatas:

```matlab
addpath(fullfile(pwd, 'models'));
pmsm_control_init;
run_pmsm_mechanical_validation;
```

Mit figyel:

- `tau`
- `wm`
- `w`
- `rpm`
- `theta`

Sikeres kimenetek:

- `PMSM_MECH_VALIDATION_OK`

Specialis, de gyakran ertelmes eset:

- `PMSM_MECH_VALIDATION_LOCKED_ROTOR`

Ez azt jelenti:

- nyomatek keletkezett
- de a mechanikai allapot nem mozdult

Ez zart vagy lockolt rotoros laborhelyzetben lehet teljesen elfogadhato.

### 5.3. Milyen workspace logok keletkeznek

A top-level `pmsm_control` modellben ezek a `To Workspace` logok vannak:

- `pmsm_duty_log`
- `pmsm_id_iq_log`
- `pmsm_motion_log`
- `pmsm_status_log`
- `pmsm_vdq_log`

Gyors ertelmezes:

- `pmsm_duty_log` -> PWM duty-k
- `pmsm_id_iq_log` -> `Id`, `Iq`
- `pmsm_motion_log` -> `theta`, `w`, `rpm`
- `pmsm_status_log` -> `gate_en`, `fault`, kapcsolodo statuszok
- `pmsm_vdq_log` -> `Vd`, `Vq`

## 6. Mit erdemes latni a top-level modellen

A fo modell mar eleve ki van vezetve monitorokra es scope-okra.

Fontos controller monitor jelek:

- `Da`
- `Db`
- `Dc`
- `gate_en`
- `fault`
- `Id`
- `Iq`
- `Vd`
- `Vq`
- `theta_e`

Fontos sensor monitor jelek:

- `Iabc`
- `Udc`
- `theta`
- `w`
- `rpm`
- `status`
- `fault`

Fontos plant monitor jelek:

- `Iout`
- `Vout`
- `Udc`
- `Ub`
- `Iabc`
- `theta`
- `w`
- `rpm`
- `status`
- `fault`

Alap szimulacios ellenorzeshez ez jo kezdopont:

- `Start = 0`, `Id_ref = 0`, `Iq_ref = 0`
- utana `Start = 1`
- majd kis `Iq_ref` lepes, peldaul `5 A`

Elvart:

- `gate_en` 0-rol 1-re valthat
- `fault` maradjon 0
- `Iq` tenylegesen mozduljon
- a duty-k maradjanak `0..1` kozott

## 7. DSP binaris generalasa

Ez a helyes ut:

```matlab
load_system('pmsm_control');
Simulink.harness.open('pmsm_control/Controller', 'Controller_DSP');
```

Ezutan a megnyitott harness legyen az aktiv modell, es azon menj:

- `Ctrl+B`

vagy:

- `Build Model`

### 7.1. A tipikus outputok

Sikeres build utan elvart kimenetek:

- `work/codegen/Controller_DSP.out`
- `work/codegen/Controller_DSP.mhx`
- `work/codegen/Controller_DSP_ert_rtw/`
- `work/codegen/Controller_DSP_ert_rtw/CCS_Project`

Hasznalat:

- CCS / JTAG -> `Controller_DSP.out`
- HiTerm COFF -> `Controller_DSP.out`
- SW Downloader -> `Controller_DSP.mhx`

Nagyon fontos:

- ezek a fajlnevek azonosak az `RLUb` workflow fajlneveivel
- a PMSM build ezeket felulirhatja

Ha biztos akarsz lenni benne, hogy valoban PMSM builded van:

- nezd meg a build idejet
- vagy mentsd kulon masolatba a keletkezett `.out` / `.mhx` fajlokat

### 7.2. Ha a `Ctrl+B` mar az elejen megall

Tipikus ok:

- `slprj` / `codegen` / `CacheFolder` utkozes

Gyakorlati javitas:

```matlab
Simulink.fileGenControl('set', ...
    'CacheFolder', fullfile(pwd, 'work', 'cache'), ...
    'CodeGenFolder', fullfile(pwd, 'work', 'codegen'), ...
    'createDir', true);
```

Utana erdemes takaritani:

```matlab
if exist(fullfile(pwd, 'slprj'), 'dir')
    rmdir(fullfile(pwd, 'slprj'), 's');
end

if exist(fullfile(pwd, 'models', 'slprj'), 'dir')
    rmdir(fullfile(pwd, 'models', 'slprj'), 's');
end
```

Majd:

1. `bdclose('all')`
2. nyisd meg ujra a `Controller_DSP` harness-t
3. `Ctrl+B`

### 7.3. Ha `Multitask data store` hibaval megall

A fo modell configja jelenleg `MultiTaskDSMMsg = error`, tehat ez buildet is megakaszthat.

Ha kapsz ilyen hibat:

1. `Configuration Parameters`
2. `Diagnostics`
3. `Data Validity`
4. `Multitask data store`
5. allitsd `None`-ra

Utana probald ujra a buildet.

Ez nem elvi "szep" javitas, hanem gyakorlati workaround a legacy multitask C2000 skeleton miatt.

## 8. DSP feltoltes es monitorozas

### 8.1. SW Downloader

Ugyanaz a szabaly, mint az `RLUb`-nal:

- ide a `.mhx` kell

Hasznald:

- `Q:\work\codegen\Controller_DSP.mhx`

### 8.2. HiTerm

Ha a `Specify Coff file for DSP-0` ablak feljon, ezt nyisd meg:

- `Q:\work\codegen\Controller_DSP.out`

Ha a `Q:` nincs felhuzva:

- `amer_hil/amer_hil/work/codegen/Controller_DSP.out`

### 8.3. Mit mutat most a repo-ban a HiTerm config

A jelenlegi `HiTerm/HiTerm.ini` mar erosen PMSM-orientalt:

- `PORT=COM10`
- `Basic` recorder:
  - `CTRLvars.Iout.q`
  - `CTRLvars.rpm`
  - `CTRLvars.torque`
  - `limits.Torque`
- `Development` recorder:
  - `CTRLvars.rpm_ref`
  - `CTRLvars.rpm`
  - `CTRLvars.sramp`
  - `CTRLvars.sramp0`

Ugyanakkor a `HiTermD.ini` meg mindig reszben legacy valtozokat tartalmaz:

- `Iref`
- `Start`
- `CPLDIn.*`
- `AnalogChA.*`

Ez nem feltetlenul baj, mert a skeleton egy resze kozos, de PMSM bring-uphoz lehet, hogy at kell irnod a monitorlapokat, ha kifejezetten `Id_ref`, `Iq_ref`, `rpm`, `fault_reset` vagy hasonlo PMSM jeleket akarsz kenyelmesen nezni.

### 8.4. Excel-makros monitor definiciok

A PMSM monitor definicioknak is van Exceles forrasa. A fontos workbook:

- `config/pmsm_HIL.xls`

Ez VBA-s workbook, es a tablazatos lapokbol general monitor definiciot.

Fontos:

- a HiTerm futas kozben nem ezt az Excel fajlt olvassa
- az Excel a forras, a futaskori rendszer mar a generalt eredmenyt hasznalja

Hasznos lapok:

- `Tab-Read` -> FPGA-bol olvasott PMSM valtozok
- `Tab-Write` -> FPGA fele irhato PMSM parameterek
- `Tab-FPGA` -> monitor sajat rendszer valtozoi
- `Units` -> hasznalhato egysegek
- `cTerm_defs`, `hTerm_defs` -> a generalt definiciok szoveges nezetben

A jelenlegi `Tab-Read` sorai kozul nehany fontos pelda:

- `Ia`, `Ib`, `Ic`
- `Id`, `Iq`
- `rpm`, `wm`, `w`
- `theta`
- `tau`
- `Psix`, `Psiy`
- `EMFx`, `EMFy`

A `Tab-Write` fontosabb sorai:

- `CntLimit`
- `SlowOut`
- `Status`
- `Fail`
- `Encoder`
- `LEDs`
- `Udc`
- `tauL`
- `speed_en`, `speed0`
- `theta_en`, `theta0`
- `encoder_en`

Mit kell beleirni az oszlopokba:

- `Name of variable @ PC` -> ez lesz a HiTermben lathato nev
- `Unit` -> a `Units` lapon levo definiciok egyike
- `16bit` -> `x`, ha 16 bites
- `Signed` -> `x`, ha elojeles
- `IQ` -> fixpontos skala, peldaul `14`, `16`, `22`
- `Shift` -> megjelenitesi skalaeltolas
- `Float` -> `x`, ha lebegopontos
- `WR` -> `x`, ha a monitorbol irhato
- `HEXA` -> `x`, ha hexadecimalis megjelenites kell
- `FPGA Address` -> a monitor regisztercime
- `init_value` -> kezdo/default ertek
- `max_value` -> maximalis ertek

Gyakorlati szabaly:

- uj mert PMSM jel a `Tab-Read` lapra kerul
- uj irhato HIL parameter a `Tab-Write` lapra kerul
- a `FPGA Address`-t csak akkor modositsd, ha a HIL monitor terkepet is attervezed

Fontos korlat:

- a generalt header szerinti `MAX_CHAR_LEN` `11`
- a HiTermben hasznalt rovid neveket tartsd legfeljebb `11` karakter korul

Hasznalat:

1. Nyisd meg a `pmsm_HIL.xls` workbookot Excelben.
2. Engedelyezd a makrokat.
3. Szerkeszd a `Tab-Read` es `Tab-Write` sorokat.
4. Ellenorizd az `IQ`, `WR`, `Unit` es `FPGA Address` mezoket.
5. Futtasd a workbook export/generalas makrojat.
6. Ellenorizd, hogy a `cTerm_defs` es `hTerm_defs` lap frissult-e.
7. Frissitsd a projektben a generalt monitor fajlokat.

Ne itt szerkessz kezileg:

- `cTerm_defs`
- `hTerm_defs`

Ezek generalt lapok, nem primer forraslapok.

## 9. FPGA / HIL oldal generalasa

A helyes logika itt is harness-alapu.

Elsodleges embedded harness:

```matlab
load_system('pmsm_control');
Simulink.harness.open('pmsm_control/Plant/Plant_PMSM_HIL', 'pmsm_FPGA_HIL');
```

Ez az embedded harness a jelenlegi repo-ban javitva lett, es megnyithato a `pmsm_control` modellbol.

Ha valamiert megis kulon referenciat akarsz nezni, a repo-ban van egy kulon modell is:

- `models/pmsm_hil.slx`

Ez a fajl a metadata alapjan tartalmazza a PMSM FPGA/HIL workflow-hoz tartozo HDL beallitasokat.

### 9.1. A `pmsm_hil` metadata alapjan vart HDL workflow

A `pmsm_hil` harness metadata szerint:

- HDL subsystem: `pmsm_FPGA_HIL`
- Workflow: `IP Core Generation`
- Reference design: `AMER design with HiTerm`
- Synthesis tool: `Xilinx Vivado`
- Target platform: `AMER_HIL`
- Device family: `Zynq`
- Device: `xc7z010`
- Package: `clg400`
- Speed: `-1`
- Target frequency: `20 MHz`
- Target language: `Verilog`

Ez fontos elteres az `RLUb`-hoz kepest, ahol a jelenlegi buildfak inkabb `VHDL`-esek.

### 9.2. Hova kerulhet a PMSM FPGA output

Itt ket lehetseges helyet erdemes szamon tartani:

- `amer_hil/amer_hil/hdl_prj/...`
- `amer_hil/amer_hil/work/hdl_prj/...`

Miert ketto:

- a `pmsm_hil` metadata `hdl_prj\hdlsrc` target directoryt mutat
- a projektben kozben van `work` ala terelt file generation is

Gyakorlati keresesi helyek:

- `hdl_prj/vivado_ip_prj/vivado_prj.runs/impl_1/design_1_wrapper.bit`
- `work/hdl_prj/vivado_ip_prj/vivado_prj.runs/impl_1/design_1_wrapper.bit`

### 9.3. Van-e commitolt PMSM bitstream a repo-ban

A jelenlegi checkoutban kulon, egyertelmu `PMSM` nev alatt commitolt `.bit` fajlt nem talaltam.

Ezert PMSM hardveres kiprobalashoz:

- valoszinuleg magadnak kell ujrageneralni a bitstreamet

### 9.4. Mit lehet nezni a PMSM FPGA/HIL oldalon

A `pmsm_hil` belso jelcsoportjai alapjan a HIL oldal tobbek kozott ilyen jeleket kezel:

- `Iabc`
- `Idq`
- `Vxy`
- `rpm`
- `wm`
- `w`
- `theta`
- `tau`
- `SlowIn`
- `SlowOut`
- `Status`
- `Fail`
- `Encoder`

Ez hasznos hibakereseshez, de a tenyleges FPGA monitorlap attol fugg, mit exportal a te friss builded.

## 10. FPGA HiTerm megjegyzes

A jelenlegi `HiTerm_FPGA/HiTerm.ini` altalanos, nem egyertelmuen PMSM-specifikus.

Alapbol ezeket mutatja:

- `Iout`
- `Vout`
- `SlowIn`
- `Uga`
- `Ia`
- `Ib`
- `Ic`

Ez akkor jo, ha a friss PMSM FPGA build monitorjai ugyanigy vannak kivezetve.

Ha nem:

- a recorder tabokat es csatornaneveket a friss exporthoz kell igazitanod

## 11. Gyors bring-up sorrend PMSM-hez

Ajlott sorrend:

1. `.\qra.bat`
2. `pmsm_control_init`
3. `run_pmsm_control_sanity_check`
4. opcionlisan `run_pmsm_mechanical_validation`
5. `Controller_DSP` harness build
6. `pmsm_FPGA_HIL` harness build
7. FPGA programozasa a friss `design_1_wrapper.bit`-tel
8. DSP letoltese a friss `Controller_DSP.out` vagy `Controller_DSP.mhx` fajllal
9. DSP HiTerm inditasa
10. kisjelu inditas `Start=1`, kis `Iq_ref` lepessel

## 12. Tipikus hibak

### Direktben a `pmsm_control.slx`-re inditott HDL generalas hibazik

Ez varhato. A top-level modell function-call es scheduler szerkezete nem direkt HDL-celra valo.

Megoldas:

- `pmsm_FPGA_HIL` harness

### A friss PMSM DSP build "eltunt"

Valoszinuleg nem tunt el, hanem ugyanoda irt, ahova az `RLUb` is:

- `work/codegen/Controller_DSP.out`
- `work/codegen/Controller_DSP.mhx`

Megoldas:

- build utan mentsd kulon nevvel vagy kulon mappaba

### A HiTermben nem PMSM valtozokat latsz

Valoszinu ok:

- a `HiTermD.ini` reszben legacy monitorlapot tartalmaz

Megoldas:

- nyisd meg a jo COFF fajlt
- ellenorizd, hogy a futtato DSP build tenyleg a PMSM valtozat
- ha kell, szerkeszd a monitorlapokat PMSM-specifikus valtozokra

### Nincs kulon PMSM `.bit` a repo-ban

Ez jelenleg a repo allapota. PMSM FPGA buildhez uj generalas kell.

### A `vivado_ip_prj` mappa foglalt

Tipikus ok:

- fut a Vivado
- fut a kulso `cmd` konzol
- fut egy Xilinx segedfolyamat

Megoldas:

- zarj be minden Vivado/Xilinx folyamatot
- utana torolj vagy generalj ujra

## 13. Lezaras

Ha vegeztel:

```powershell
.\qrol.bat
```

Ez lekapcsolja a `Q:` meghajtot.
