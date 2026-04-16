MEMORY
{
PAGE 0:
 /*   BEGINRAM:	 origin=0x0, length=0x2 */
    PRAM:	 origin=0x8000, length=0x6000
    OTP:	 origin=0x3d7800, length=0x3fa
    BEGIN:	 origin=0x3d8000, length=0x2
    FLASH:	 origin=0x3d8002, length=0x18ffe
    BEGINFLASH:	 origin=0x3f7ff6, length=0x2
    CSM_PWL:	 origin=0x3f7ff8, length=0x8
    FPUTABLES:	 origin=0x3fd860, length=0x6a0
    IQTABLES:	 origin=0x3fdf00, length=0xb50
    IQTABLES2:	 origin=0x3fea50, length=0x8c
    IQTABLES3:	 origin=0x3feadc, length=0xaa
    BOOTROM:	 origin=0x3ff3b0, length=0xc10
    RESET:	 origin=0x3fffc0, length=0x2
    VECTORS:	 origin=0x3fffc2, length=0x3e
PAGE 1:
    BOOT_RSVD:   origin=0x0, length=0x50
    RAMM0M1:	 origin=0x50, length=0x7b0
    DRAM:	 origin=0xe000, length=0x6000
}
SECTIONS
{
    .vectors:	 load = 0x000000000
    .text:	 > FLASH, PAGE = 0
    .switch:	 > FLASH, PAGE = 0
    .bss:	 > DRAM, PAGE = 1
    .ebss:	 > DRAM, PAGE = 1
    .far:	 > DRAM, PAGE = 1
    .cinit:	 > FLASH, PAGE = 0
    .pinit:	 > FLASH, PAGE = 0
    .const:	 > FLASH, PAGE = 0
    .econst:	 > FLASH, PAGE = 0
    .reset:	 > RESET, PAGE = 0, TYPE = DSECT
    .data:	 > DRAM, PAGE = 1
    .cio:	 > DRAM, PAGE = 1
    .sysmem:	 > DRAM, PAGE = 1
    .esysmem:	 > DRAM, PAGE = 1
    .stack:	 > RAMM0M1, PAGE = 1
    .rtdx_text:	 > FLASH, PAGE = 0
    .rtdx_data:	 > DRAM, PAGE = 1
    IQmath:	 > FLASH, PAGE = 0
    codestart:	 > BEGIN, PAGE = 0
    csmpasswds:	 > CSM_PWL, PAGE = 0
    csm_rsvd:	 > PRAM, PAGE = 0
    ramfuncs:	 LOAD = FLASH,
		RUN = PRAM,
		LOAD_START(_RamfuncsLoadStart),
		LOAD_END(_RamfuncsLoadEnd),
		RUN_START(_RamfuncsRunStart),
		PAGE = 0
    IQmathTables:	 > IQTABLES, PAGE = 0 , TYPE = NOLOAD
    IQmathTables2:	 > IQTABLES2, PAGE = 0 , TYPE = NOLOAD
    IQmathTables3:	 > IQTABLES3, PAGE = 0 , TYPE = NOLOAD
    FPUmathTables:	 > FPUTABLES, PAGE = 0, TYPE = NOLOAD
}