# RLUb Hardware Bring-Up and Validation Guide

## 1. Mihez van ez a projekt

A repo alapjan a rendszer ket fo reszbol all:

- FPGA oldal: `Zybo`, `XC7Z010`
- DSP oldal: `TMS320F28069`

A hasznalt fajlok:

- FPGA bitstream: `bin/RLUb/design_1_wrapper.bit`
- DSP program CCS-hez / HiTermhez: `work/codegen/Controller_DSP.out`
- DSP program SW Downloaderhez: `work/codegen/Controller_DSP.mhx`

## 2. Elofeltetelek

Szukseges szoftverek:

- `Vivado 2018.2.x`
- `Code Composer Studio`

Szukseges helyi elokeszites:

1. Nyiss egy PowerShellt az `amer_hil/amer_hil` mappaban.
2. Futtasd:

```powershell
.\qra.bat
```

Ez letrehozza a `Q:` meghajtot az aktualis projektmappra.

Ellenorzes:

```powershell
Get-ChildItem Q:\work\codegen
```

Elvart eredmeny:

- `Q:\work\codegen\Controller_DSP.out`
- `Q:\work\codegen\Controller_DSP.mhx`

Ha vegeztel:

```powershell
.\qrol.bat
```

## 3. FPGA programozasa

Hasznald ezt a fajlt:

- `bin/RLUb/design_1_wrapper.bit`

Vivado Hardware Manager ut:

1. `Open Hardware Manager`
2. `Open Target -> Auto Connect`
3. valaszd ki az `xc7z010` eszkozt
4. `Program Device`
5. tallozd be a `design_1_wrapper.bit` fajlt
6. inditsd el a programozast

### 3.1. Mit jelent ez a Vivado uzenet

Ha ezt latod:

- `Device ... is programmed with a design that has no supported debug core(s) in it`
- `The debug hub core was not detected`

akkor ez ebben a projektben jellemzoen **nem programozasi hiba**.

Jelentese:

- a bitstream nagy valoszinuseggel felment
- a Vivado csak azt kozli, hogy a designban nincs beepitett `ILA` vagy `dbg_hub`
- emiatt belso Vivado debugot nem fogsz latni

Ez onmagaban nem gond, ha:

- a programozas nem allt meg hibaval
- a monitor kommunikacio kesobb mukodik
- a rendszer funkcionalisan reagal

Csak akkor gond, ha:

- kifejezetten `ILA` debugot vartal volna
- maga a design sem indul el
- a feltoltes kozben tenyleges programozasi hiba jott

## 4. DSP programozasa

Ket tipikus ut van.

### 4.1. CCS / JTAG ut

Ez a stabilabb ut, ha van JTAG debugger.

Hasznald:

- `work/codegen/Controller_DSP_ert_rtw/CCS_Project`
- vagy kozvetlenul a `work/codegen/Controller_DSP.out` fajlt

Lepesek:

1. nyisd meg CCS-ben a projektet
2. ellenorizd a target configot
3. build, ha szukseges
4. toltsd le a `Controller_DSP.out` allomanyt
5. inditsd el a CPU-t

### 4.2. SW Downloader ut

Ez a loader a `.mhx` fajlt varja.

Hasznald:

- `Q:\work\codegen\Controller_DSP.mhx`

Nem ezt kell hasznalni:

- `Controller_DSP.out`

#### Mit kell beallitani az SW Downloaderben

1. `Port`: valaszd ki azt a COM portot, amin a DSP van
2. `DSP nr.`: maradjon `0`
3. `Program with BOOT Jumper`: elso probara ne legyen bepipalva
4. `Program file`: tallozd be a `Q:\work\codegen\Controller_DSP.mhx` fajlt
5. nyomd meg a `Start` gombot

Rovid szabaly:

- `SW Downloader` -> `.mhx`
- `HiTerm COFF` -> `.out`

#### Honnan tudod, melyik COM port kell

Windows alatt:

1. nyisd meg az `Eszkozkezelot`
2. nyisd le a `Portok (COM es LPT)` reszt
3. nezd meg, melyik `USB Serial Port (COMx)` jelenik meg, amikor bedugod a hasznalt eszkozt

Biztos mod:

1. huzd ki az USB-s kapcsolatot
2. nezd meg melyik `USB Serial Port` tunik el
3. dugd vissza
4. amelyik visszajon, az a jo COM port

Ha tobb USB serial port van, ne a Bluetooth-os portokat probald eloszor, hanem azokat, amik `USB Serial Port (COMx)` neven jelennek meg.

#### Ha nem megy az SW Downloader

Probald sorban:

1. masik `USB Serial Port`
2. csak ezutan probald a `Program with BOOT Jumper` opciot
3. ha ez sem megy, valts vissza `CCS/JTAG` letoltesre

## 5. HiTerm hasznalata

Ket monitor konfiguracio van a repo-ban.

### 5.1. DSP HiTerm

Fajlok:

- `HiTerm/HiTERM.exe`
- `HiTerm/HiTerm.ini`
- `HiTerm/HiTermD.ini`

Alapertelmezett port a config szerint:

- `COM9`

Ha a program `Specify Coff file for DSP-0` ablakot nyit, akkor ezt kell megnyitni:

- `Q:\work\codegen\Controller_DSP.out`

Ha a `Q:` nincs felhuzva, akkor jo a lokal masolat is:

- `amer_hil/amer_hil/work/codegen/Controller_DSP.out`
- vagy `amer_hil/amer_hil/bin/RLUb/Controller_DSP.out`

Mit ne nyiss meg:

- ne a `.mhx` fajlt
- ne az `.ini` fajlt
- ne a `Sym.txt` fajlt

Miert kell az `.out`:

- a HiTerm ebbol olvassa ki a DSP valtozok szimbolumait
- igy tud nev szerint valtozokat megjeleniteni es irni

### 5.2. FPGA HiTerm

Fajlok:

- `HiTerm_FPGA/HiTERM.exe`
- `HiTerm_FPGA/HiTerm.ini`

Alapertelmezett port a config szerint:

- `COM3`

Megfigyelheto jelek a config szerint:

- `Iout`
- `Vout`
- `SlowIn`
- `Uga`
- `Ia`
- `Ib`
- `Ic`

## 6. Recorder hasznalata

A HiTerm recorder egy triggerelt jelrogzito. Nem csak "elo" adatot mutat, hanem trigger alapjan rogzitett ablakkent is tudsz jeleket nezni.

Az FPGA recorderben a projektben elore beallitott tabok vannak:

- `Basic`: `Iout`, `Vout`, `SlowIn`
- `Development`: `Uga`, `Ia`, `Ib`, `Ic`

A jobb oldali vezerles lenyege:

- `Source`: melyik csatorna triggereljen, pl. `CH1`, `CH2`, `CH3`
- `Level`: milyen jelszintnel induljon a rogzites
- `Sampling`: mintaveteli suruseg
- `Position [%]`: hol legyen a triggerpont a rogzitett ablakban
- `Single`: egyetlen merest rogzit
- `Start`: folyamatosan ujratriggerel

Javasolt elso beallitas:

1. nyisd meg a `Basic` tabot
2. valaszd a `Source = CH3` beallitast, ha a `SlowIn` valtozasara akarsz triggerelni
3. `Level = 1`
4. `Position = 50%`
5. `Single`

Ez jo kezdes, ha egy 0/1 jel valtozasat akarod elkapni.

Ha analog jelre akarsz triggerelni:

1. `Source = CH1`, ha az `Iout`-ot nezed
2. a `Level` legyen egy kicsi, de nem nulla ertek
3. `Single`
4. indits egy kis `Start=1`, `Iref` lepcsot

Ha nem tortenik semmi, tipikus okok:

- rossz `Source` van kivalasztva
- rossz a `Level`
- a jel nem lep at a trigger szinten
- a recorder nincs `Single` vagy `Start` modban

## 7. Mit jelentenek a fontos FPGA oldali jelek

### 7.1. `Iout`

Az `Iout` a kimeneti aramhoz kapcsolodo jel. Ezt erdemes a szabalyzas szempontjabol nezni.

Ha a recorderben az `Iout` "teli piros falnak" vagy suru csikozasnak latszik, az sokszor nem jelhiba, hanem megjelenitesi problema.

Tipikus rossz beallitas:

- `ac/dc = ac`
- tul kicsi `Division`, pl. `0.0001`

Ilyenkor:

- az `AC` coupling kiveszi a DC komponenst
- a maradek hullamossag nagyon fel van nagyitva
- a jel teljesen szetzumoltnak tunik

Mit allits:

1. kattints az `Iout` sorra
2. `ac/dc = dc`
3. `Division = 1`, `2` vagy `5`
4. ha kell, csokkentsd a `Sampling` erteket

Elvart viselkedes:

- nem teljesen teli piros fal
- lathato atlagos aram plusz hullamossag
- a `Mean` ertek jobban ertelmezheto lesz

### 7.2. `Vout`

Ebben a projektben a `Vout` nagy valoszinuseggel a nyers PWM jelhez vagy kapcsolo csomoponthoz kotheto, nem pedig egy kisimitott atlagfeszultseg.

Ezert az teljesen normalis lehet, ha:

- `Vout` gyorsan `0` es `100` kozott valtakozik

Miert logikus ez:

- a projektben a felso tartomany `Udc = 100`
- a felhid kimenet nyersen `0` es `Udc` kozott kapcsol

Tehat a nyers `Vout` varhato alakja:

- gyors `0/100` PWM-szeru valtakozas

Amit erdemes nezni:

- a `Mean` erteket
- a kitoltes valtozasat

Alaphelyzetben sokszor az atlag kb. `50` korul lesz. Ez normalis.

Gyanus inkabb ez lenne:

- `Vout` mindig csak `0`
- `Vout` mindig csak `100`
- nincs valtozas akkor sem, amikor a rendszernek reagalnia kellene

## 8. Gyors bring-up sorrend

Javasolt sorrend:

1. `.\qra.bat`
2. FPGA programozasa a `design_1_wrapper.bit` fajllal
3. DSP programozasa
4. DSP HiTerm inditasa
5. FPGA HiTerm inditasa
6. kommunikacio ellenorzese
7. kisjelu funkcioellenorzes

## 9. Funkcionalis ellenorzes

### 9.1. Alap kommunikacios ellenorzes

Elvart:

- a DSP HiTerm csatlakozik
- az FPGA HiTerm csatlakozik
- nincs folyamatos timeout
- olvashatoak valtozok

### 9.2. Nyugalmi allapot

Allitsd:

- `Start = 0`
- `Iref = 0`

Elvart:

- nincs nem vart aktiv PWM
- nincs indokolatlan fault
- a jelek nyugalmi allapotban maradnak

### 9.3. Kisjelu inditas

Lepesek:

1. `Start = 1`
2. adj kis pozitiv `Iref` lepcsot
3. figyeld a DSP es FPGA monitorokat

Elvart:

- a PWM-hez tartozo DSP valtozok reagalnak
- az `Iout` reagal
- a `Vout` nem szalad irrealis tartomanyba
- nincs azonnali `FAIL`

Ezutan erdemes kis negativ `Iref`-fel is megismetelni.

### 9.4. Muszeres ellenorzes

Ha van szkop vagy logikai analizator:

- ellenorizd a PWM jelek jelenletet
- ellenorizd a kb. `10 kHz` kapcsolasi frekvenciat
- nezd meg, hogy `Start=0` es `Start=1` kozott egyertelmu kulonbseg van-e

## 10. Mi szamit sikeres bring-upnak

A bring-up sikeresnek tekintheto, ha:

1. az FPGA programozasa lefut
2. a DSP program letoltodik es elindul
3. a Vivado debug-hub warning ellenere a design funkcionalisan mukodik
4. a DSP HiTerm es az FPGA HiTerm is csatlakozik
5. `Start=0` mellett nyugalmi viselkedest latsz
6. `Start=1` es kis `Iref` mellett ertelmes reakcio van

## 11. Tipikus hibak

### FPGA felprogramozodik, de jon a debug hub warning

Ez altalaban nem hiba, csak azt jelenti, hogy nincs beepitett Vivado debug core.

### SW Downloader nem tud programozni

Valoszinu okok:

- rossz COM port
- rossz boot mod
- nem a `.mhx` fajlt valasztottad

### HiTerm nem mutat ertelmes DSP valtozokat

Valoszinu okok:

- rossz COM port
- nem a `Controller_DSP.out` lett megnyitva COFF fajlkent
- nem a megfelelo DSP fut

### Recorderben az `Iout` teljesen szet van csikozva

Valoszinu okok:

- `ac/dc = ac`
- tul kicsi `Division`
- tul agressziv mintaveteli beallitas

Megoldas:

- `ac/dc = dc`
- `Division = 1`, `2` vagy `5`
- ne a pillanatnyi hullamossagot, hanem a `Mean` es a trend alakulast nezd

### `Vout` gyorsan `0` es `100` kozott valtakozik

Ez ebben a projektben altalaban normalis, mert a nyers PWM-szeru kapcsolasi jelet latod.

Ilyenkor:

- ne a pillanatnyi szintet nezd
- a `Mean` erteket es a kitoltes valtozasat figyeld
- a szabalyzas allapotat inkabb `Iout`-on es a lassabb valtozokon ertelmezd

### Van kommunikacio, de nincs funkcio

Valoszinu okok:

- `Start = 0`
- `Iref = 0`
- fault aktiv
- a DSP oldal fut, de a HIL viselkedes nem jon at

## 12. Binarisok ujrageneralasa az `RLUb.slx`-bol

Fontos: a ket feltoltheto oldal nem ugyanabbol a top-level nezetbol generalodik, hanem az `RLUb.slx`-be agyazott kulon harness-ekbol.

Az `RLUb.slx` belsejeben a repo szerint legalabb ez a ket fontos harness van:

- `RLUb_HIL`
- `Controller_DSP`

Mit generalnak:

- `RLUb_HIL` -> FPGA bitstream
- `Controller_DSP` -> DSP binarisok (`.out`, `.mhx`)

### 12.1. Altalanos elokeszites MATLAB-ban

Javasolt kornyezet:

- `MATLAB R2018b`
- `Simulink Test`
- `HDL Coder`
- `Embedded Coder`
- `Embedded Coder Support Package for Texas Instruments C2000 Processors`
- a C2000 toolchain es support package helyesen telepitve

Lepesek:

1. nyisd meg az `amer_hil/amer_hil` mappat
2. shellbol vagy MATLAB `system(...)` hivassal futtasd:

```powershell
.\qra.bat
```

vagy MATLAB-bol:

```matlab
system('qra.bat');
```

3. MATLAB-ban allj a projekt gyokerere
4. futtasd az inicializalast:

```matlab
RLUb_init;
xilinxpath;
load_system('RLUb');
```

Megjegyzes:

- az `open_rlub_hil_harness.m` helper ezt az elokeszitest nagyreszt elvegzi az FPGA-s utvonalhoz
- a project eredeti workflow-ja `Q:` meghajtot var

### 12.2. FPGA bitstream generalasa az `RLUb.slx`-bol

Az FPGA build nem a fo `RLUb` modellen fut kozvetlenul, hanem az `RLUb_HIL` beagyazott harness-en.

Az owner path:

- `RLUb/Plant/RLUb_DTFX/RLUb_DTFX`

#### GUI utvonal

1. nyisd meg a `models/RLUb.slx` modellt
2. valaszd ki a `RLUb/Plant/RLUb_DTFX/RLUb_DTFX` blokkot
3. nyisd meg a blokkhoz tartozo harness listat
4. nyisd meg az `RLUb_HIL` harness-t
5. a harness ablakban nyisd meg:
   `Code -> HDL Code -> HDL Workflow Advisor`
6. a harness legyen a DUT, ne a belso plant blokkot valaszd kozvetlenul

#### MATLAB parancssoros utvonal

```matlab
open_rlub_hil_harness
```

Ez a helper:

- felhuzza a `Q:` meghajtot, ha kell
- betolti az `RLUb` modellt
- megnyitja az `RLUb_HIL` harness-t
- megprobalja elinditani a HDL Workflow Advisort

#### Javasolt HDL Workflow beallitasok

- Workflow: `IP Core Generation`
- Target platform: `AMER_HIL`
- Reference design: `AMER design with HiTerm`
- Synthesis tool: `Xilinx Vivado`
- FPGA family: `Zynq`
- Device: `xc7z010`
- Package: `clg400`
- Speed: `-1`
- Target frequency: `20 MHz`
- Target language: `VHDL`

#### Eredmeny

A generalt FPGA artefaktumok jellemzo helye:

- `work/hdl_prj/...`

A vegso bitstream tipikusan itt jelenik meg:

- `work/hdl_prj/vivado_ip_prj/vivado_prj.runs/impl_1/design_1_wrapper.bit`

A repo-ban egy ismert, mar letezo masolat is van:

- `bin/RLUb/design_1_wrapper.bit`

#### Mit general a HDL Workflow Advisor

A `work/hdl_prj` alatt a fontosabb kimenetek:

- `hdlsrc/RLUb_HIL/` -> a generalt VHDL forrasok es workflow logok
- `ipcore/RLUb_HIL_ip_v1_0/` -> a becsomagolt custom IP
- `vivado_ip_prj/` -> a teljes generalt Vivado projekt

Gyakorlatban neked altalaban ez a lenyeg:

- a programozashoz a kesz `.bit`
- hibakereseshez a `vivado_ip_prj`
- HDL diffhez vagy ellenorzeshez a `hdlsrc/RLUb_HIL/*.vhd`

Ha csak a deploy artefakt kell, a legfontosabb fajl tovabbra is:

- `bin/RLUb/design_1_wrapper.bit`

#### Ugyanez fut-e, mint Vivadobol

Igen. A `HDL Workflow Advisor` ugyanazt a Vivado synthesis / implementation / bitstream folyamatot inditja el, csak scriptelt formaban.

A generalt build script:

- `work/hdl_prj/vivado_ip_prj/vivado_build.tcl`

Ebben a lenyegi lepesek:

- `open_project vivado_prj.xpr`
- `launch_runs synth_1`
- `launch_runs impl_1 -to_step write_bitstream`

Tehat ha a Workflow Advisor kulso konzolt nyit, az lenyegeben ugyanaz, mintha a generalt `vivado_prj.xpr` projektet nyitnad meg es ott futtatnad a buildet.

#### Hogyan inditsd el ugyanezt kezzel Vivadoban

Ha a generalt Vivado projektet kezzel nyitod meg:

1. `Run Synthesis`
2. `Run Implementation`
3. `Generate Bitstream`

Vagy a `Design Runs` nezetben:

1. jobb klikk `impl_1`
2. `Launch Runs...`
3. futtasd `write_bitstream` lepesig

Ez felel meg legjobban a Workflow Advisor altal inditott buildnek.

#### Meddig kell varni a Workflow Advisor buildnel

Ha a `4.2 Build FPGA Bitstream` feladaton ezt latod:

- `Result: Passed`
- `Passed Build Embedded System`

akkor a MATLAB oldal mar sikeresen elinditotta a buildet, de a tenyleges Vivado futas meg mehet tovabb a kulso konzolban.

Ilyenkor:

- nem kell ujra nyomogatni a `Run This Task` gombot
- a kulso Vivado / konzol ablak veget kell megvarni
- csak utana erdemes a `.bit` fajlt keresni

#### Mi van, ha timing hiba van

Ha a Vivado logban negativ `WNS` latszik, akkor timing problema van.

Ebben az esetben a build script a bitstreamet atnevezheti erre:

- `design_1_wrapper_timingfailure.bit`

Ez azt jelenti, hogy keszult bitstream, de az idozitesi kovetelmenyek nem teljesultek. Bring-up kiprobalasra ezt csak tudatosan hasznald, es ne tekintsd vegleges, megbizhato release-nek.

### 12.3. DSP binarisok generalasa az `RLUb.slx`-bol

Fontos: a DSP binarisok sem a fo `RLUb` nezetbol generalodnak kozvetlenul, hanem az `RLUb.slx`-be agyazott `Controller_DSP` harness-bol.

A harness owner path:

- `RLUb/Controller`

A repo-ban talalt kodgenerator beallitasok alapjan ez a harness:

- `SystemTargetFile = ert.tlc`
- `HardwareBoard = TI Piccolo F2806x`
- `ProdHWDeviceType = Texas Instruments->C2000`

Tehat ez a helyes mikroprocesszoros build ut.

#### GUI utvonal

1. nyisd meg a `models/RLUb.slx` modellt
2. valaszd ki a `RLUb/Controller` blokkot
3. nyisd meg a harness listat
4. nyisd meg a `Controller_DSP` harness-t
5. a harness ablakban ellenorizd, hogy a C2000 target beallitas aktiv
6. indits buildet:
   `Ctrl+B`
   vagy `Build Model`

#### MATLAB parancssoros megnyitas

```matlab
load_system('RLUb');
Simulink.harness.open('RLUb/Controller','Controller_DSP');
```

Ezutan a megnyitott harness legyen az aktiv modell, es azon induljon a build.

#### Ha a `Ctrl+B` mar a build elejen megall

Tipikus hiba:

- a jelenlegi munkakonyvtarban mar van `slprj`
- a Simulink kozben masik `CacheFolder` / `CodeGenFolder` beallitast is hasznalna

Ez ilyenkor olyan hibakent jelenhet meg, hogy a build folder mar letezik, vagy a `pwd` alatt talalt `slprj` osszeakadhat a beallitott build root-tal.

Gyakorlati javitas MATLAB-ban:

```matlab
Simulink.fileGenControl('set', ...
    'CacheFolder', fullfile(pwd, 'work', 'cache'), ...
    'CodeGenFolder', fullfile(pwd, 'work', 'codegen'), ...
    'createDir', true);
```

Utana erdemes torolni a szetszorodott generalt mappakat:

```matlab
if exist(fullfile(pwd, 'slprj'), 'dir')
    rmdir(fullfile(pwd, 'slprj'), 's');
end

if exist(fullfile(pwd, 'models', 'slprj'), 'dir')
    rmdir(fullfile(pwd, 'models', 'slprj'), 's');
end
```

Ezutan:

1. `bdclose('all')`
2. nyisd meg ujra a `Controller_DSP` harness-t
3. `Ctrl+B`

Ezzel a build a dokumentumban is hasznalt helyre fog dolgozni:

- `work/codegen/Controller_DSP.out`
- `work/codegen/Controller_DSP.mhx`

#### Model Advisor multitask data store figyelmeztetes

Build kozben feljohet a `Multitask data store` figyelmeztetes. Ha a `Change` gombot nyomod, a Simulink a diagnosztikat `error` szintre teheti, es a build megallhat.

Ebben a projektben a konkret utkozes a `CPLDOut` Data Store korul van:

- a `Task_1s_post` a `CPLDOut.GreenLED` mezot irja
- a `Task_1ms_post` a teljes `CPLDOut` buszt olvassa

Ez a modellben egy konzervativ multitask riasztas, ami a buildet meg tudja akasztani.

Ha most a binaris generalas a cel, allitsd vissza ezt:

1. `Configuration Parameters`
2. `Diagnostics`
3. `Data Validity`
4. `Multitask data store`
5. `None`

Ezutan futtasd ujra a buildet.

Megjegyzes:

- ez nem azt jelenti, hogy a jelenseg elmeletileg mindig veszelytelen
- csak azt, hogy a jelenlegi `Controller_DSP` workflow-ban ez a beallitas szukseges lehet a build vegigvitelehez

#### Elvart eredmeny

Sikeres build utan tipikusan ezek a fajlok jonnek letre:

- `work/codegen/Controller_DSP.out`
- `work/codegen/Controller_DSP.mhx`
- `work/codegen/Controller_DSP_ert_rtw/`
- `work/codegen/Controller_DSP_ert_rtw/CCS_Project`

Rovid ertelmezes:

- `.out` -> CCS es HiTerm COFF fajl
- `.mhx` -> SW Downloaderhez hasznalt fajl

A repo-ban ezekbol mar van ismert masolat:

- `bin/RLUb/Controller_DSP.out`
- `bin/RLUb/Controller_DSP.mhx`

#### Ha a generalt Vivado mappa nem torolheto

Tisztitas vagy ujrageneralas kozben elofordulhat, hogy a `vivado_ip_prj` mappa "hasznalatban van".

Tipikus okok:

- a `Vivado` meg nyitva van
- a kulso buildet futtato `cmd` konzol meg nyitva van
- valamelyik Xilinx folyamat meg fogja a projektet

Ilyenkor:

1. zard be a `Vivado`-t
2. zard be a kulso build konzolt
3. ha kell, lodd ki a maradek folyamatokat a Feladatkezeloben:
   - `vivado.exe`
   - `vivado_lab.exe`
   - `xelab.exe`
   - `xsim.exe`
   - a buildet futtato `cmd.exe`
4. ezutan probald ujra a torlest vagy a buildet

### 12.4. Melyik fajlt mire hasznald a generalas utan

FPGA:

- feltolteshez: `design_1_wrapper.bit`

DSP:

- CCS / JTAG: `Controller_DSP.out`
- HiTerm COFF: `Controller_DSP.out`
- SW Downloader: `Controller_DSP.mhx`

### 12.5. Gyors osszefoglalo

Ha ujra akarod generalni a teljes deploy csomagot az `RLUb.slx`-bol:

1. `RLUb_init`
2. `xilinxpath`
3. `RLUb.slx` megnyitasa
4. `RLUb_HIL` harness megnyitasa
5. HDL Workflow lefuttatasa
6. `Controller_DSP` harness megnyitasa
7. `Build Model`
8. a keletkezett `.bit`, `.out`, `.mhx` fajlok ellenorzese

### 12.6. Fontos megjegyzes

Az FPGA es a DSP build egyarant az `RLUb.slx`-hez tartozik, de ket kulon harness-on keresztul.

Ezert:

- az FPGA buildhez ne a fo `RLUb` modellt hasznald kozvetlen DUT-kent
- a DSP buildhez ne a `pmsm_control.slx`-et tekintsd elsodleges deploy-forrasnak, ha kifejezetten az eredeti `RLUb` workflow-t akarod kovetni

### 12.7. Git szempontbol mi generalt es mi erdekes

Az FPGA build soran a legfontosabb generalt fa:

- `work/hdl_prj/`

Ennek fo reszei:

- `hdlsrc/` -> generalt HDL
- `ipcore/` -> csomagolt IP
- `vivado_ip_prj/` -> teljes generalt Vivado projekt

Altalaban erdemes ignore-ban tartani:

- `work/`
- `hdl_prj/`
- `slprj/`
- `*.slxc`
- Vivado logok, `.Xil`, `.jou`, `.log`, `.wdb`, `.wdf`

A repo jelenlegi `.gitignore`-ja ezt mar nagyreszt lefedi.

Ha valamit tenyleg erdemes verziokezelni a generalas utan, az inkabb ez:

- `bin/RLUb/design_1_wrapper.bit`
- `bin/RLUb/Controller_DSP.out`
- `bin/RLUb/Controller_DSP.mhx`

## 13. Lezaras

Ha vegeztel:

```powershell
.\qrol.bat
```

Ez megszunteti a `Q:` meghajto-hozzarendelest.
