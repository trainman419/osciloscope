
/*******************************************************************
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 9.1.02 EDK_J_SP2.4
* DO NOT EDIT.
*
* Copyright (c) 2005 Xilinx, Inc.  All rights reserved. 
* 
* Description: Driver parameters
*
*******************************************************************/


/******************************************************************/


/* Definitions for peripheral DLMB_CNTLR */
#define XPAR_DLMB_CNTLR_BASEADDR 0x00000000
#define XPAR_DLMB_CNTLR_HIGHADDR 0x00007FFF


/* Definitions for peripheral ILMB_CNTLR */
#define XPAR_ILMB_CNTLR_BASEADDR 0x00000000
#define XPAR_ILMB_CNTLR_HIGHADDR 0x00007FFF


/******************************************************************/

/* Definitions for driver GPIO */
#define XPAR_XGPIO_NUM_INSTANCES 6

/* Definitions for peripheral LEDS_8BIT */
#define XPAR_LEDS_8BIT_BASEADDR 0x40000000
#define XPAR_LEDS_8BIT_HIGHADDR 0x400001FF
#define XPAR_LEDS_8BIT_DEVICE_ID 0
#define XPAR_LEDS_8BIT_INTERRUPT_PRESENT 0
#define XPAR_LEDS_8BIT_IS_DUAL 0


/* Definitions for peripheral PUSH_BUTTONS_3BIT */
#define XPAR_PUSH_BUTTONS_3BIT_BASEADDR 0x40002000
#define XPAR_PUSH_BUTTONS_3BIT_HIGHADDR 0x400021FF
#define XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID 1
#define XPAR_PUSH_BUTTONS_3BIT_INTERRUPT_PRESENT 0
#define XPAR_PUSH_BUTTONS_3BIT_IS_DUAL 0


/* Definitions for peripheral SWITCHES_8BIT */
#define XPAR_SWITCHES_8BIT_BASEADDR 0x40004000
#define XPAR_SWITCHES_8BIT_HIGHADDR 0x400041FF
#define XPAR_SWITCHES_8BIT_DEVICE_ID 2
#define XPAR_SWITCHES_8BIT_INTERRUPT_PRESENT 0
#define XPAR_SWITCHES_8BIT_IS_DUAL 0


/* Definitions for peripheral SSEG */
#define XPAR_SSEG_BASEADDR 0x40008000
#define XPAR_SSEG_HIGHADDR 0x400081FF
#define XPAR_SSEG_DEVICE_ID 3
#define XPAR_SSEG_INTERRUPT_PRESENT 0
#define XPAR_SSEG_IS_DUAL 0


/* Definitions for peripheral SPI2_DATA */
#define XPAR_SPI2_DATA_BASEADDR 0x40016000
#define XPAR_SPI2_DATA_HIGHADDR 0x400161FF
#define XPAR_SPI2_DATA_DEVICE_ID 4
#define XPAR_SPI2_DATA_INTERRUPT_PRESENT 0
#define XPAR_SPI2_DATA_IS_DUAL 0


/* Definitions for peripheral GPIO */
#define XPAR_GPIO_BASEADDR 0x40018000
#define XPAR_GPIO_HIGHADDR 0x400181FF
#define XPAR_GPIO_DEVICE_ID 5
#define XPAR_GPIO_INTERRUPT_PRESENT 0
#define XPAR_GPIO_IS_DUAL 0


/******************************************************************/

/* Definitions for driver UARTLITE */
#define XPAR_XUARTLITE_NUM_INSTANCES 2

/* Definitions for peripheral RS232_PORT */
#define XPAR_RS232_PORT_BASEADDR 0x40006000
#define XPAR_RS232_PORT_HIGHADDR 0x400061FF
#define XPAR_RS232_PORT_DEVICE_ID 0
#define XPAR_RS232_PORT_BAUDRATE 9600
#define XPAR_RS232_PORT_USE_PARITY 0
#define XPAR_RS232_PORT_ODD_PARITY 0
#define XPAR_RS232_PORT_DATA_BITS 8


/* Definitions for peripheral LCD_UART */
#define XPAR_LCD_UART_BASEADDR 0x4001A000
#define XPAR_LCD_UART_HIGHADDR 0x4001A1FF
#define XPAR_LCD_UART_DEVICE_ID 1
#define XPAR_LCD_UART_BAUDRATE 520833
#define XPAR_LCD_UART_USE_PARITY 0
#define XPAR_LCD_UART_ODD_PARITY 1
#define XPAR_LCD_UART_DATA_BITS 8


/******************************************************************/


/* Definitions for peripheral MICRON_RAM */
#define XPAR_MICRON_RAM_NUM_BANKS_MEM 1


/******************************************************************/

/* Definitions for peripheral MICRON_RAM */
#define XPAR_MICRON_RAM_MEM0_BASEADDR 0x41000000
#define XPAR_MICRON_RAM_MEM0_HIGHADDR 0x41FFFFFF

/******************************************************************/

/* Definitions for driver TMRCTR */
#define XPAR_XTMRCTR_NUM_INSTANCES 4

/* Definitions for peripheral TIMER_0 */
#define XPAR_TIMER_0_BASEADDR 0x4000A000
#define XPAR_TIMER_0_HIGHADDR 0x4000A1FF
#define XPAR_TIMER_0_DEVICE_ID 0


/* Definitions for peripheral TIMER_1 */
#define XPAR_TIMER_1_BASEADDR 0x4000C000
#define XPAR_TIMER_1_HIGHADDR 0x4000C1FF
#define XPAR_TIMER_1_DEVICE_ID 1


/* Definitions for peripheral TIMER_2 */
#define XPAR_TIMER_2_BASEADDR 0x4000E000
#define XPAR_TIMER_2_HIGHADDR 0x4000E1FF
#define XPAR_TIMER_2_DEVICE_ID 2


/* Definitions for peripheral TIMER_3 */
#define XPAR_TIMER_3_BASEADDR 0x40010000
#define XPAR_TIMER_3_HIGHADDR 0x400101FF
#define XPAR_TIMER_3_DEVICE_ID 3


/******************************************************************/

#define XPAR_INTC_MAX_NUM_INTR_INPUTS 5
#define XPAR_XINTC_HAS_IPR 1
#define XPAR_XINTC_USE_DCR 0
/* Definitions for driver INTC */
#define XPAR_XINTC_NUM_INSTANCES 1

/* Definitions for peripheral OPB_INTC_0 */
#define XPAR_OPB_INTC_0_BASEADDR 0x40012000
#define XPAR_OPB_INTC_0_HIGHADDR 0x400121FF
#define XPAR_OPB_INTC_0_DEVICE_ID 0
#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000


/******************************************************************/

#define XPAR_INTC_SINGLE_BASEADDR 0x40012000
#define XPAR_INTC_SINGLE_HIGHADDR 0x400121FF
#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
#define XPAR_SPI_IP2INTC_IRPT_MASK 0X000001
#define XPAR_OPB_INTC_0_SPI_IP2INTC_IRPT_INTR 0
#define XPAR_TIMER_3_INTERRUPT_MASK 0X000002
#define XPAR_OPB_INTC_0_TIMER_3_INTERRUPT_INTR 1
#define XPAR_TIMER_2_INTERRUPT_MASK 0X000004
#define XPAR_OPB_INTC_0_TIMER_2_INTERRUPT_INTR 2
#define XPAR_TIMER_1_INTERRUPT_MASK 0X000008
#define XPAR_OPB_INTC_0_TIMER_1_INTERRUPT_INTR 3
#define XPAR_TIMER_0_INTERRUPT_MASK 0X000010
#define XPAR_OPB_INTC_0_TIMER_0_INTERRUPT_INTR 4

/******************************************************************/

/* Definitions for driver SPI */
#define XPAR_XSPI_NUM_INSTANCES 1

/* Definitions for peripheral SPI */
#define XPAR_SPI_BASEADDR 0x40014000
#define XPAR_SPI_HIGHADDR 0x400141FF
#define XPAR_SPI_DEVICE_ID 0
#define XPAR_SPI_FIFO_EXIST 1
#define XPAR_SPI_SPI_SLAVE_ONLY 0
#define XPAR_SPI_NUM_SS_BITS 1


/******************************************************************/

#define XPAR_FSL_LCD_FSL_0_INPUT_SLOT_ID  0

/******************************************************************/

#define XPAR_CPU_CORE_CLOCK_FREQ_HZ 100000000

/******************************************************************/


/* Definitions for peripheral MICROBLAZE_0 */
#define XPAR_MICROBLAZE_0_SCO 0
#define XPAR_MICROBLAZE_0_DATA_SIZE 32
#define XPAR_MICROBLAZE_0_DYNAMIC_BUS_SIZING 1
#define XPAR_MICROBLAZE_0_AREA_OPTIMIZED 1
#define XPAR_MICROBLAZE_0_D_OPB 1
#define XPAR_MICROBLAZE_0_D_LMB 1
#define XPAR_MICROBLAZE_0_I_OPB 0
#define XPAR_MICROBLAZE_0_I_LMB 1
#define XPAR_MICROBLAZE_0_USE_MSR_INSTR 1
#define XPAR_MICROBLAZE_0_USE_PCMP_INSTR 1
#define XPAR_MICROBLAZE_0_USE_BARREL 0
#define XPAR_MICROBLAZE_0_USE_DIV 1
#define XPAR_MICROBLAZE_0_USE_HW_MUL 1
#define XPAR_MICROBLAZE_0_USE_FPU 1
#define XPAR_MICROBLAZE_0_UNALIGNED_EXCEPTIONS 0
#define XPAR_MICROBLAZE_0_ILL_OPCODE_EXCEPTION 0
#define XPAR_MICROBLAZE_0_IOPB_BUS_EXCEPTION 0
#define XPAR_MICROBLAZE_0_DOPB_BUS_EXCEPTION 0
#define XPAR_MICROBLAZE_0_DIV_ZERO_EXCEPTION 0
#define XPAR_MICROBLAZE_0_FPU_EXCEPTION 0
#define XPAR_MICROBLAZE_0_PVR 0
#define XPAR_MICROBLAZE_0_PVR_USER1 0x00
#define XPAR_MICROBLAZE_0_PVR_USER2 0x00000000
#define XPAR_MICROBLAZE_0_DEBUG_ENABLED 0
#define XPAR_MICROBLAZE_0_NUMBER_OF_PC_BRK 1
#define XPAR_MICROBLAZE_0_NUMBER_OF_RD_ADDR_BRK 0
#define XPAR_MICROBLAZE_0_NUMBER_OF_WR_ADDR_BRK 0
#define XPAR_MICROBLAZE_0_INTERRUPT_IS_EDGE 0
#define XPAR_MICROBLAZE_0_EDGE_IS_POSITIVE 1
#define XPAR_MICROBLAZE_0_RESET_MSR 0x00000000
#define XPAR_MICROBLAZE_0_OPCODE_0X0_ILLEGAL 0
#define XPAR_MICROBLAZE_0_FSL_LINKS 1
#define XPAR_MICROBLAZE_0_FSL_DATA_SIZE 32
#define XPAR_MICROBLAZE_0_ICACHE_BASEADDR 0x00000000
#define XPAR_MICROBLAZE_0_ICACHE_HIGHADDR 0x3FFFFFFF
#define XPAR_MICROBLAZE_0_USE_ICACHE 0
#define XPAR_MICROBLAZE_0_ALLOW_ICACHE_WR 1
#define XPAR_MICROBLAZE_0_ADDR_TAG_BITS 0
#define XPAR_MICROBLAZE_0_CACHE_BYTE_SIZE 8192
#define XPAR_MICROBLAZE_0_ICACHE_USE_FSL 1
#define XPAR_MICROBLAZE_0_ICACHE_LINE_LEN 4
#define XPAR_MICROBLAZE_0_DCACHE_BASEADDR 0x00000000
#define XPAR_MICROBLAZE_0_DCACHE_HIGHADDR 0x3FFFFFFF
#define XPAR_MICROBLAZE_0_USE_DCACHE 0
#define XPAR_MICROBLAZE_0_ALLOW_DCACHE_WR 1
#define XPAR_MICROBLAZE_0_DCACHE_ADDR_TAG 0
#define XPAR_MICROBLAZE_0_DCACHE_BYTE_SIZE 8192
#define XPAR_MICROBLAZE_0_DCACHE_USE_FSL 1
#define XPAR_MICROBLAZE_0_DCACHE_LINE_LEN 4

/******************************************************************/

#define XPAR_CPU_ID 0
#define XPAR_MICROBLAZE_ID 0
#define XPAR_MICROBLAZE_CORE_CLOCK_FREQ_HZ 100000000
#define XPAR_MICROBLAZE_SCO 0
#define XPAR_MICROBLAZE_DATA_SIZE 32
#define XPAR_MICROBLAZE_DYNAMIC_BUS_SIZING 1
#define XPAR_MICROBLAZE_AREA_OPTIMIZED 1
#define XPAR_MICROBLAZE_D_OPB 1
#define XPAR_MICROBLAZE_D_LMB 1
#define XPAR_MICROBLAZE_I_OPB 0
#define XPAR_MICROBLAZE_I_LMB 1
#define XPAR_MICROBLAZE_USE_MSR_INSTR 1
#define XPAR_MICROBLAZE_USE_PCMP_INSTR 1
#define XPAR_MICROBLAZE_USE_BARREL 0
#define XPAR_MICROBLAZE_USE_DIV 1
#define XPAR_MICROBLAZE_USE_HW_MUL 1
#define XPAR_MICROBLAZE_USE_FPU 1
#define XPAR_MICROBLAZE_UNALIGNED_EXCEPTIONS 0
#define XPAR_MICROBLAZE_ILL_OPCODE_EXCEPTION 0
#define XPAR_MICROBLAZE_IOPB_BUS_EXCEPTION 0
#define XPAR_MICROBLAZE_DOPB_BUS_EXCEPTION 0
#define XPAR_MICROBLAZE_DIV_ZERO_EXCEPTION 0
#define XPAR_MICROBLAZE_FPU_EXCEPTION 0
#define XPAR_MICROBLAZE_PVR 0
#define XPAR_MICROBLAZE_PVR_USER1 0x00
#define XPAR_MICROBLAZE_PVR_USER2 0x00000000
#define XPAR_MICROBLAZE_DEBUG_ENABLED 0
#define XPAR_MICROBLAZE_NUMBER_OF_PC_BRK 1
#define XPAR_MICROBLAZE_NUMBER_OF_RD_ADDR_BRK 0
#define XPAR_MICROBLAZE_NUMBER_OF_WR_ADDR_BRK 0
#define XPAR_MICROBLAZE_INTERRUPT_IS_EDGE 0
#define XPAR_MICROBLAZE_EDGE_IS_POSITIVE 1
#define XPAR_MICROBLAZE_RESET_MSR 0x00000000
#define XPAR_MICROBLAZE_OPCODE_0X0_ILLEGAL 0
#define XPAR_MICROBLAZE_FSL_LINKS 1
#define XPAR_MICROBLAZE_FSL_DATA_SIZE 32
#define XPAR_MICROBLAZE_ICACHE_BASEADDR 0x00000000
#define XPAR_MICROBLAZE_ICACHE_HIGHADDR 0x3FFFFFFF
#define XPAR_MICROBLAZE_USE_ICACHE 0
#define XPAR_MICROBLAZE_ALLOW_ICACHE_WR 1
#define XPAR_MICROBLAZE_ADDR_TAG_BITS 0
#define XPAR_MICROBLAZE_CACHE_BYTE_SIZE 8192
#define XPAR_MICROBLAZE_ICACHE_USE_FSL 1
#define XPAR_MICROBLAZE_ICACHE_LINE_LEN 4
#define XPAR_MICROBLAZE_DCACHE_BASEADDR 0x00000000
#define XPAR_MICROBLAZE_DCACHE_HIGHADDR 0x3FFFFFFF
#define XPAR_MICROBLAZE_USE_DCACHE 0
#define XPAR_MICROBLAZE_ALLOW_DCACHE_WR 1
#define XPAR_MICROBLAZE_DCACHE_ADDR_TAG 0
#define XPAR_MICROBLAZE_DCACHE_BYTE_SIZE 8192
#define XPAR_MICROBLAZE_DCACHE_USE_FSL 1
#define XPAR_MICROBLAZE_DCACHE_LINE_LEN 4
#define XPAR_MICROBLAZE_HW_VER "6.00.b"

/******************************************************************/

