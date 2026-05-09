# FPGA-DSP Signal Map

Ez a jegyzet a `pmsm_control.slx` / `pmsm_FPGA_HIL` FPGA oldali interfeszeket
es a `Controller_DSP` DSP oldali periferiakat/GPIO-kat rendezi egy helyre.

## Kozvetlen FPGA <-> DSP kapcsolatok

| FPGA jel / interface | FPGA irany | FPGA fizikai pin(ek) | DSP oldal | DSP GPIO / periferia | Megjegyzes |
|---|---|---|---|---|---|
| `CtrlH[0:3]` | bemenet az FPGA-n | `V12`, `W16`, `J15`, `H15` | PWM kimenetek a DSP-rol | `EPWM1A`, `EPWM2A`, `EPWM3A`, egy 4. csatorna/spare | A busz 4 bites, de a repo nem nevezi meg egyertelmuen bitenkent a PMSM fazis-hozzarendelest. |
| `CtrlL[0:3]` | bemenet az FPGA-n | `V13`, `U17`, `T17`, `Y17` | PWM kimenetek a DSP-rol | `EPWM1B`, `EPWM2B`, `EPWM3B`, egy 4. csatorna/spare | A busz 4 bites, de a repo nem nevezi meg egyertelmuen bitenkent a PMSM fazis-hozzarendelest. |
| `Status[0:3]` | kimenet az FPGA-rol | `T15`, `R14`, `U15`, `V18` | digitalis bemenetek a DSP-n | `GPIO56`, `GPIO57`, `GPIO55`, `GPIO54` -> osszefuzve `Status` | A bitosszerakas a DSP kodban fixen definiált. |
| `Fail[0:3]` | kimenet az FPGA-rol | `U20`, `W20`, `Y19`, `W19` | FPGA-bol jovo hibajelek | pontos DSP oldali bekotes nem latszik egyertelmuen a repobol | A `pmsm_FPGA_HIL` 4 bites `Fail` buszt exportal, de a DSP oldalon ettol fuggetlenul van egy kulon 1 bites `CPLDIn.FAIL` is SPI-n. |
| `QEP[0:3]` | kimenet az FPGA-rol | `T10`, `T12`, `U12`, `T11` | enkoder bemenet a DSP-n | `eQEP2A/B/I/S` = `GPIO24`, `GPIO25`, `GPIO26`, `GPIO27` | A board plugin szerint a sorrend `A, B, Z, I`; a DSP oldalon az eQEP2 hasznalt. |
| `IOextIn[7:0]` | bemenet az FPGA-n | soros SPI linken keresztul | lassu DSP -> FPGA I/O | `SPIB`: `GPIO12`, `GPIO13`, `GPIO14`, `GPIO15` | Nem 8 kulon vezetek, hanem SPI extension. |
| `IOextOut[7:0]` | kimenet az FPGA-rol | soros SPI linken keresztul | lassu FPGA -> DSP I/O | `SPIB`: `GPIO12`, `GPIO13`, `GPIO14`, `GPIO15` | A DSP oldalon `CPLDInput/CPLDOutput` strukturakon jon at. |

## DSP oldali SPI bekotes

| DSP GPIO | DSP funkcio | FPGA oldali SPI jel | FPGA pin |
|---|---|---|---|
| `GPIO12` | `SPISIMOB` | `ioext_spi_mosi` | `V17` |
| `GPIO13` | `SPISOMIB` | `ioext_spi_miso` | `U14` |
| `GPIO14` | `SPICLKB` | `ioext_spi_clk` | `T14` |
| `GPIO15` | chip select GPIO | `ioext_spi_cs` | `P14` |

## DSP oldali, kodban egyertelmuen latszo periferiak

| DSP funkcio | DSP GPIO / periferia | Megjegyzes |
|---|---|---|
| PWM high/low oldal | `EPWM1A/B`, `EPWM2A/B`, `EPWM3A/B` | A kod ezeket biztosan inicializalja es hajtja. |
| enkoder visszacsatolas | `eQEP2` on `GPIO24`, `GPIO25`, `GPIO26`, `GPIO27` | A generalt `MW_c28xx_qep.c` explicit modon beallitja. |
| statusz digitalis bemenet | `GPIO54`, `GPIO55`, `GPIO56`, `GPIO57` | Ezekbol all ossze a DSP oldali `Status`. |
| egyeb digitalis bemenet | `GPIO40`, `GPIO41`, `GPIO42`, `GPIO43` | Ezekbol all ossze a DSP oldali `Encoder` valtozo. |
| lassu I/O SPI | `SPIB` | `CPLD_DataExchange()` hasznalja. |

## PDF-bol megerositett hardveres kapcsolatok

Az `HIL.PDF` rajzlapjai megerositik a kovetkezoket:

- A lassu I/O SPI extender fizikailag a DSP `SPIB` periferiara van kotve:
  - `SPISIMOB -> ENCMOTA`
  - `SPISOMIB -> ENCMOTB`
  - `SPICLKB -> ENCMOTZ`
  - `SPISTEB -> ENCMOTI`
- Ugyanezek a netek mennek at a Zybo csatlakozora:
  - `ENCMOTA -> JC3`
  - `ENCMOTB -> JC9`
  - `ENCMOTZ -> JC10`
  - `ENCMOTI -> JC2`
- A reference design XDC-ben a tenyleges FPGA top-level SPI I/O jelek:
  - `ioext_spi_clk -> JD1 -> T14`
  - `ioext_spi_cs -> JD3 -> P14`
  - `ioext_spi_miso -> JD7 -> U14`
  - `ioext_spi_mosi -> JD9 -> V17`
- A `QEP` kimeneti busz a HIL oldalon a motor enkoder emulaciobol jon, a DSP oldalon az `eQEP2` periferia fogadja:
  - `eQEP2A -> GPIO24`
  - `eQEP2B -> GPIO25`
  - `eQEP2I -> GPIO26`
  - `eQEP2S -> GPIO27`
- A `Status[0:3]` es `Fail[0:3]` kulon dedikalt FPGA kimeneti buszok, nem ugyanazok, mint a lassu SPI extender bitjei.
- A sigma-delta DAC/HIL analog front-end jelek:
  - `SD[1..4]`
  - `SD_CLK_0`
  - `SD_CLK_90`
  ezekbol lesznek az analog HIL jelek `AN1..AN4`, majd a DSP ADC bemenetei (`ADCINAx`, `ADCINBx`).

## PDF alapjan pontositott tabla

| Funkcio | FPGA / HIL oldal | Zybo csatlakozo / pin | DSP oldal | Megjegyzes |
|---|---|---|---|---|
| lassu SPI adat DSP -> HIL | `SPISIMOB` | a PDF szerint `ENCMOTA -> JC3`, az FPGA designban `ioext_spi_mosi -> JD9/V17` | `GPIO12 / SPIB SIMO` | A PDF es a jelenlegi HDL design ugyanazt a funkciot ket kulon netnev-konvenciaval mutatja. |
| lassu SPI adat HIL -> DSP | `SPISOMIB` | a PDF szerint `ENCMOTB -> JC9`, az FPGA designban `ioext_spi_miso -> JD7/U14` | `GPIO13 / SPIB SOMI` | Ugyanaz a megjegyzes. |
| lassu SPI ora | `SPICLKB` | a PDF szerint `ENCMOTZ -> JC10`, az FPGA designban `ioext_spi_clk -> JD1/T14` | `GPIO14 / SPIB CLK` | Ugyanaz a megjegyzes. |
| lassu SPI chip select | `SPISTEB` | a PDF szerint `ENCMOTI -> JC2`, az FPGA designban `ioext_spi_cs -> JD3/P14` | `GPIO15 / SPIB CS` | Ugyanaz a megjegyzes. |
| enkoder emulacio | `QEP[0:3]` | `T10`, `T12`, `U12`, `T11` | `eQEP2A/B/I/S` | A board plugin sorrendje `A, B, Z, I`, a DSP kod eQEP2-t inicializal. |
| statusz busz | `Status[0:3]` | `T15`, `R14`, `U15`, `V18` | `GPIO56`, `GPIO57`, `GPIO55`, `GPIO54` | DSP oldalon ebbol all elo a `Status` szo. |
| hiba busz | `Fail[0:3]` | `U20`, `W20`, `Y19`, `W19` | FPGA/HIL -> DSP kulso hibajel ut | A 4 bites busz kulon van a lassu SPI-n levo 1 bites `CPLDIn.FAIL` jelhez kepest. |
| analog HIL kimenetek | `AN1..AN4` | DAC/sigma-delta front-end | `ADCINAx`, `ADCINBx` | A PDF ezt explicit rajzolja. |

## Vegleges egyoldalas megfeleltetesi tabla

| Funkcio | FPGA jel / interface | Zybo pin / csatlakozo | DSP GPIO / periferia | Forras |
|---|---|---|---|---|
| PWM high 0 | `CtrlH[0]` | `V12` | `EPWM1A` / `GPIO0` | `plugin_board.m`, `inic.c` |
| PWM low 0 | `CtrlL[0]` | `V13` | `EPWM1B` / `GPIO1` | `plugin_board.m`, `inic.c` |
| PWM high 1 | `CtrlH[1]` | `W16` | `EPWM2A` / `GPIO2` | `plugin_board.m`, `inic.c` |
| PWM low 1 | `CtrlL[1]` | `U17` | `EPWM2B` / `GPIO3` | `plugin_board.m`, `inic.c` |
| PWM high 2 | `CtrlH[2]` | `J15` | `EPWM3A` / `GPIO4` | `plugin_board.m`, `inic.c` |
| PWM low 2 | `CtrlL[2]` | `T17` | `EPWM3B` / `GPIO5` | `plugin_board.m`, `inic.c` |
| PWM high 3 | `CtrlH[3]` | `H15` | nincs egyertelmuen bizonyitva | `plugin_board.m` |
| PWM low 3 | `CtrlL[3]` | `Y17` | nincs egyertelmuen bizonyitva | `plugin_board.m` |
| Status bit 0 | `Status[0]` | `T15` | `GPIO54` | `plugin_board.m`, `Controller_DSP.c` |
| Status bit 1 | `Status[1]` | `R14` | `GPIO55` | `plugin_board.m`, `Controller_DSP.c` |
| Status bit 2 | `Status[2]` | `U15` | `GPIO57` | `plugin_board.m`, `Controller_DSP.c` |
| Status bit 3 | `Status[3]` | `V18` | `GPIO56` | `plugin_board.m`, `Controller_DSP.c` |
| Fail bit 0 | `Fail[0]` | `U20` | nincs egyertelmuen bizonyitva | `plugin_board.m`, `HIL.PDF` |
| Fail bit 1 | `Fail[1]` | `W20` | nincs egyertelmuen bizonyitva | `plugin_board.m`, `HIL.PDF` |
| Fail bit 2 | `Fail[2]` | `Y19` | nincs egyertelmuen bizonyitva | `plugin_board.m`, `HIL.PDF` |
| Fail bit 3 | `Fail[3]` | `W19` | nincs egyertelmuen bizonyitva | `plugin_board.m`, `HIL.PDF` |
| QEP A | `QEP[0]` | `T10` | `eQEP2A` / `GPIO24` | `plugin_board.m`, `MW_c28xx_qep.c` |
| QEP B | `QEP[1]` | `T12` | `eQEP2B` / `GPIO25` | `plugin_board.m`, `MW_c28xx_qep.c` |
| QEP Z | `QEP[2]` | `U12` | `eQEP2S` vagy index/marker ut | `plugin_board.m`, `HIL.PDF` |
| QEP I | `QEP[3]` | `T11` | `eQEP2I` / `GPIO26` | `plugin_board.m`, `MW_c28xx_qep.c` |
| lassu SPI MOSI | `ioext_spi_mosi` | `V17` / `JD9` | `SPISIMOB` / `GPIO12` | `amer_top_constraint.xdc`, `SPI.c` |
| lassu SPI MISO | `ioext_spi_miso` | `U14` / `JD7` | `SPISOMIB` / `GPIO13` | `amer_top_constraint.xdc`, `SPI.c` |
| lassu SPI CLK | `ioext_spi_clk` | `T14` / `JD1` | `SPICLKB` / `GPIO14` | `amer_top_constraint.xdc`, `SPI.c` |
| lassu SPI CS | `ioext_spi_cs` | `P14` / `JD3` | `SPI chip select` / `GPIO15` | `amer_top_constraint.xdc`, `SPI.c` |
| analog HIL adat 0 | `sd[0]` | `T20` / `JB1` | ADC analog ut | `amer_top_constraint.xdc`, `HIL.PDF` |
| analog HIL adat 1 | `sd[1]` | `V20` / `JB3` | ADC analog ut | `amer_top_constraint.xdc`, `HIL.PDF` |
| analog HIL adat 2 | `sd[2]` | `Y18` / `JB7` | ADC analog ut | `amer_top_constraint.xdc`, `HIL.PDF` |
| analog HIL adat 3 | `sd[3]` | `W18` / `JB9` | ADC analog ut | `amer_top_constraint.xdc`, `HIL.PDF` |
| analog HIL clk 0 | `sd_clk_0` | `V15` / `JC1` | DAC/sigma-delta analog ut | `amer_top_constraint.xdc`, `HIL.PDF` |
| analog HIL clk 90 | `sd_clk_90` | `W14` / `JC7` | DAC/sigma-delta analog ut | `amer_top_constraint.xdc`, `HIL.PDF` |

Megjegyzesek:

- A `Status` bitrend a DSP kod alapjan visszafejtett megfeleltetes, nem explicit feliratozas a schematikon.
- A `Fail[3:0]` fizikai FPGA kimeneti busz, de a DSP oldali negy kulon megfelelo GPIO nem azonosithato egyertelmuen a jelenlegi repobol.
- A `QEP[2]` es `QEP[3]` nevkonvencioja a board pluginban `Z` es `I`, mig a DSP oldali eQEP dokumentacioban `S` es `I`; ez klasszikus index/strobe jelnev-elteres.

## Forrasfajlok

- `plugins/+AMER_HIL/plugin_board.m`
- `plugins/+AMER_HIL/+AMER_HITERM/amer_top_constraint.xdc`
- `ext/Amer/SPI.c`
- `ext/Amer/inic.c`
- `ext/Amer/CPLDHandler.c`
- `work/codegen/Controller_DSP_ert_rtw/Controller_DSP.c`
- `work/codegen/Controller_DSP_ert_rtw/MW_c28xx_qep.c`
- `doc/HIL.PDF`
