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
| **Embedded Coder**          | `7.1`  |  |
| **Embedded Coder Support Package for Texas Instruments C2000 Processors** | `18.2.5` |  |
| **MATLAB Support for MinGW-x64 C/C++ Compiler** | `18.2.0` |  |

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
