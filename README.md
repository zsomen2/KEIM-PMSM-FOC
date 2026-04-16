# KEIM-PMSM-FOC

Simulation and **h**ardware-**i**n-**t**he-**l**oop (**HIL**) testing of **f**ield-**o**riented **c**ontrol (**FOC**) for a **p**ermanent **m**agnet **s**ynchronous **m**otor (**PMSM**) for *Modern Control Methods in Electronics BMEVIAUM035* course at *Budapest University of Technology and Econimics*

## Hardware

| Controller | |
|---|---|
| Manufacturer | **Texas Instruments** |
| Part number | **TMS320F28069** |
| Series | C2000 |


| FPGA | |
|---|---|
| Manufacturer | **AMD** |
| Part number | **XC7Z010-1CLG400C** |
| Board platform | Zybo |

## Software



### MATLAB [[link](https://www.mathworks.com/downloads/)]

A skeleton project was provided, which was created in `R2018b`, therefore the same version was used during development.

| Addon | Version | Description |
|---|---|---|
| **Simulink**                | `9.2`  |  |
| **Simulink Coder**          | `9.0`  |  |
| **MATLAB CODER**            | `4.1`  |  |
| **HDL Coder**               | `3.13` |  |
| **HDL Verifier**            | `5.5`  |  |
| **Simscape**                | `4.5`  |  |
| **Simscape Electrical**     | `7.0`  |  |
| **Stateflow**               | `9.2`  |  |
| **Fixed-Point Designer**    | `6.2`  |  |
| **Control System Toolbox**  | `10.5` |  |
| **Simulink Test**           | `2.5`  | Required for opening the embedded `RLUb_HIL` test harness used as the FPGA HDL top model. |
| **Embedded Coder**          | `7.1`  |  |
| **Embedded Coder Support Package for Texas Instruments C2000 Processors** | `18.2.5` |  |
| **MATLAB Support for MinGW-x64 C/C++ Compiler** | `18.2.0` |  |

## FPGA HDL generation

Before generating FPGA HDL, switch to the `RLUb_HIL` test harness. Do not use `Plant/RLUb_DTFX` or the inner `RLUb_DTFX` block directly as the DUT, because the R2018b workflow fails on the bus-element ports. Opening the `RLUb_HIL` harness requires the **Simulink Test** addon/license.

The FPGA plant/HIL top is not stored as a separate `RLUb_HIL.slx` model. It is an embedded Simulink Test harness inside `models/RLUb.slx`.

| Harness | Owner subsystem |
|---|---|
| `RLUb_HIL` | `RLUb/Plant/RLUb_DTFX/RLUb_DTFX` |

Because of this, the **Simulink Test** addon/license is required to open the harness before running HDL Coder. Without Simulink Test, the model may appear to have no `RLUb_HIL` model even though the harness data is present in the `.slx` file.

Use the GUI workflow below in MATLAB R2018b:

1. Open the project working folder `amer_hil/amer_hil`.
2. Run the project initialization used by the model, including `RLUb_init` and `xilinxpath`.
3. Open `models/RLUb.slx`.
4. Select the block `RLUb/Plant/RLUb_DTFX/RLUb_DTFX`.
5. Open the Simulink Test harness list from the block context menu or the Simulink Test toolbar.
6. Open the `RLUb_HIL` harness.
7. In the `RLUb_HIL` harness window, open **Code > HDL Code > HDL Workflow Advisor**.
8. Run the HDL Workflow Advisor tasks using the settings below.

In HDL Workflow Advisor, keep the top-level harness `RLUb_HIL` as the HDL DUT. Do not select the inner `RLUb/Plant/RLUb_DTFX/...` subsystem directly, because the inner plant block has bus-element ports and is not a valid standalone DUT for this R2018b workflow.

Use these HDL Workflow Advisor settings:

| Setting | Value |
|---|---|
| Workflow | `IP Core Generation` |
| Target platform | `AMER_HIL` |
| Reference design | `AMER design with HiTerm` |
| Synthesis tool | `Xilinx Vivado` |
| FPGA family | `Zynq` |
| Device | `xc7z010` |
| Package | `clg400` |
| Speed | `-1` |
| Target frequency | `20 MHz` |
| Target language | `VHDL` |

The generated bitstream is written under:

```text
work\hdl_prj\vivado_ip_prj\vivado_prj.runs\impl_1\design_1_wrapper.bit
```

### Code Composer Studio [[link](https://www.ti.com/tool/CCSTUDIO#downloads)]

TI IDE used for creating, building, downloading, and debugging the controller firmware running on the C2000 microcontroller. It is the main development environment for the controller side of the project.

### C2000Ware [[link](https://www.ti.com/tool/C2000WARE#downloads)]

TI software package providing device support, drivers, libraries, example projects, and documentation for C2000 microcontrollers. It is used as the main software support package for the controller side during development.

### controlSUITE [[link](https://www.ti.com/tool/CONTROLSUITE#downloads)]

Legacy TI software package for older C2000 devices. It is used mainly for compatibility with older MATLAB and C2000 support workflows, especially when the selected controller or support package still expects it during setup.

### Vivado [[link](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html)]

FPGA development environment used for synthesis, implementation, bitstream generation, and hardware programming of the Zybo FPGA design.

Version `2018.2.2`

- Vivado Design Suite - HLx Editions
- Vivado Design Suite - HLx Editions: Update 2

This version was chosen to match the older laboratory workflow and course skeleton as closely as possible.

### Digilent Adept [[link]()]

Utility used for programming the FPGA board with the generated bitstream outside Vivado. It is mainly used as a simple alternative to Vivado Hardware Manager for loading the final design onto the Zybo board.

### CCS compiler [[link]()]

TI C2000 code generation tools compiler used by Code Composer Studio to build the controller firmware for the target microcontroller. It is the compiler toolchain responsible for turning the generated or written C code into the final executable for the C2000 controller.
