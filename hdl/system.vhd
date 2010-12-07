-------------------------------------------------------------------------------
-- system.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system is
  port (
    fpga_0_RS232_PORT_RX_pin : in std_logic;
    fpga_0_RS232_PORT_TX_pin : out std_logic;
    fpga_0_LEDs_8Bit_GPIO_d_out_pin : out std_logic_vector(0 to 7);
    fpga_0_Push_Buttons_3Bit_GPIO_in_pin : in std_logic_vector(0 to 4);
    fpga_0_Switches_8Bit_GPIO_in_pin : in std_logic_vector(0 to 7);
    fpga_0_Micron_RAM_Mem_A_pin : out std_logic_vector(9 to 31);
    fpga_0_Micron_RAM_Mem_DQ_pin : inout std_logic_vector(0 to 15);
    fpga_0_Micron_RAM_Mem_OEN_pin : out std_logic;
    fpga_0_Micron_RAM_Mem_WEN_pin : out std_logic;
    fpga_0_Micron_RAM_Mem_BEN_pin : out std_logic_vector(0 to 1);
    fpga_0_net_gnd_pin : out std_logic;
    fpga_0_net_gnd_1_pin : out std_logic;
    fpga_0_net_gnd_2_pin : out std_logic;
    sys_clk_pin : in std_logic;
    sys_rst_pin : in std_logic;
    segs : out std_logic_vector(7 downto 0);
    seg_en : out std_logic_vector(3 downto 0);
    timer_0_PWM0_pin : out std_logic;
    timer_1_PWM0_pin : out std_logic;
    sck : out std_logic;
    miso : in std_logic;
    ss : out std_logic_vector(0 to 0);
    timer_2_PWM0_pin : out std_logic;
    LCD_sck : out std_logic;
    LCD_dio : out std_logic;
    LCD_cs : out std_logic;
    spi2_MISO_pin : in std_logic;
    gpio_out : out std_logic_vector(0 to 31);
    lcd_uart_RX_pin : in std_logic;
    lcd_uart_TX_pin : out std_logic
  );
end system;

architecture STRUCTURE of system is

  component microblaze_0_wrapper is
    port (
      CLK : in std_logic;
      RESET : in std_logic;
      INTERRUPT : in std_logic;
      DEBUG_RST : in std_logic;
      EXT_BRK : in std_logic;
      EXT_NM_BRK : in std_logic;
      DBG_STOP : in std_logic;
      MB_Halted : out std_logic;
      INSTR : in std_logic_vector(0 to 31);
      I_ADDRTAG : out std_logic_vector(0 to 3);
      IREADY : in std_logic;
      IWAIT : in std_logic;
      INSTR_ADDR : out std_logic_vector(0 to 31);
      IFETCH : out std_logic;
      I_AS : out std_logic;
      DATA_READ : in std_logic_vector(0 to 31);
      DREADY : in std_logic;
      DWAIT : in std_logic;
      DATA_WRITE : out std_logic_vector(0 to 31);
      DATA_ADDR : out std_logic_vector(0 to 31);
      D_ADDRTAG : out std_logic_vector(0 to 3);
      D_AS : out std_logic;
      READ_STROBE : out std_logic;
      WRITE_STROBE : out std_logic;
      BYTE_ENABLE : out std_logic_vector(0 to 3);
      DM_ABUS : out std_logic_vector(0 to 31);
      DM_BE : out std_logic_vector(0 to 3);
      DM_BUSLOCK : out std_logic;
      DM_DBUS : out std_logic_vector(0 to 31);
      DM_REQUEST : out std_logic;
      DM_RNW : out std_logic;
      DM_SELECT : out std_logic;
      DM_SEQADDR : out std_logic;
      DOPB_DBUS : in std_logic_vector(0 to 31);
      DOPB_ERRACK : in std_logic;
      DOPB_MGRANT : in std_logic;
      DOPB_RETRY : in std_logic;
      DOPB_TIMEOUT : in std_logic;
      DOPB_XFERACK : in std_logic;
      IM_ABUS : out std_logic_vector(0 to 31);
      IM_BE : out std_logic_vector(0 to 3);
      IM_BUSLOCK : out std_logic;
      IM_DBUS : out std_logic_vector(0 to 31);
      IM_REQUEST : out std_logic;
      IM_RNW : out std_logic;
      IM_SELECT : out std_logic;
      IM_SEQADDR : out std_logic;
      IOPB_DBUS : in std_logic_vector(0 to 31);
      IOPB_ERRACK : in std_logic;
      IOPB_MGRANT : in std_logic;
      IOPB_RETRY : in std_logic;
      IOPB_TIMEOUT : in std_logic;
      IOPB_XFERACK : in std_logic;
      DBG_CLK : in std_logic;
      DBG_TDI : in std_logic;
      DBG_TDO : out std_logic;
      DBG_REG_EN : in std_logic_vector(0 to 4);
      DBG_CAPTURE : in std_logic;
      DBG_UPDATE : in std_logic;
      Trace_Instruction : out std_logic_vector(0 to 31);
      Trace_Valid_Instr : out std_logic;
      Trace_PC : out std_logic_vector(0 to 31);
      Trace_Reg_Write : out std_logic;
      Trace_Reg_Addr : out std_logic_vector(0 to 4);
      Trace_MSR_Reg : out std_logic_vector(0 to 10);
      Trace_New_Reg_Value : out std_logic_vector(0 to 31);
      Trace_Exception_Taken : out std_logic;
      Trace_Exception_Kind : out std_logic_vector(0 to 3);
      Trace_Jump_Taken : out std_logic;
      Trace_Delay_Slot : out std_logic;
      Trace_Data_Address : out std_logic_vector(0 to 31);
      Trace_Data_Access : out std_logic;
      Trace_Data_Read : out std_logic;
      Trace_Data_Write : out std_logic;
      Trace_Data_Write_Value : out std_logic_vector(0 to 31);
      Trace_Data_Byte_Enable : out std_logic_vector(0 to 3);
      Trace_DCache_Req : out std_logic;
      Trace_DCache_Hit : out std_logic;
      Trace_ICache_Req : out std_logic;
      Trace_ICache_Hit : out std_logic;
      Trace_OF_PipeRun : out std_logic;
      Trace_EX_PipeRun : out std_logic;
      Trace_MEM_PipeRun : out std_logic;
      FSL0_S_CLK : out std_logic;
      FSL0_S_READ : out std_logic;
      FSL0_S_DATA : in std_logic_vector(0 to 31);
      FSL0_S_CONTROL : in std_logic;
      FSL0_S_EXISTS : in std_logic;
      FSL0_M_CLK : out std_logic;
      FSL0_M_WRITE : out std_logic;
      FSL0_M_DATA : out std_logic_vector(0 to 31);
      FSL0_M_CONTROL : out std_logic;
      FSL0_M_FULL : in std_logic;
      FSL1_S_CLK : out std_logic;
      FSL1_S_READ : out std_logic;
      FSL1_S_DATA : in std_logic_vector(0 to 31);
      FSL1_S_CONTROL : in std_logic;
      FSL1_S_EXISTS : in std_logic;
      FSL1_M_CLK : out std_logic;
      FSL1_M_WRITE : out std_logic;
      FSL1_M_DATA : out std_logic_vector(0 to 31);
      FSL1_M_CONTROL : out std_logic;
      FSL1_M_FULL : in std_logic;
      FSL2_S_CLK : out std_logic;
      FSL2_S_READ : out std_logic;
      FSL2_S_DATA : in std_logic_vector(0 to 31);
      FSL2_S_CONTROL : in std_logic;
      FSL2_S_EXISTS : in std_logic;
      FSL2_M_CLK : out std_logic;
      FSL2_M_WRITE : out std_logic;
      FSL2_M_DATA : out std_logic_vector(0 to 31);
      FSL2_M_CONTROL : out std_logic;
      FSL2_M_FULL : in std_logic;
      FSL3_S_CLK : out std_logic;
      FSL3_S_READ : out std_logic;
      FSL3_S_DATA : in std_logic_vector(0 to 31);
      FSL3_S_CONTROL : in std_logic;
      FSL3_S_EXISTS : in std_logic;
      FSL3_M_CLK : out std_logic;
      FSL3_M_WRITE : out std_logic;
      FSL3_M_DATA : out std_logic_vector(0 to 31);
      FSL3_M_CONTROL : out std_logic;
      FSL3_M_FULL : in std_logic;
      FSL4_S_CLK : out std_logic;
      FSL4_S_READ : out std_logic;
      FSL4_S_DATA : in std_logic_vector(0 to 31);
      FSL4_S_CONTROL : in std_logic;
      FSL4_S_EXISTS : in std_logic;
      FSL4_M_CLK : out std_logic;
      FSL4_M_WRITE : out std_logic;
      FSL4_M_DATA : out std_logic_vector(0 to 31);
      FSL4_M_CONTROL : out std_logic;
      FSL4_M_FULL : in std_logic;
      FSL5_S_CLK : out std_logic;
      FSL5_S_READ : out std_logic;
      FSL5_S_DATA : in std_logic_vector(0 to 31);
      FSL5_S_CONTROL : in std_logic;
      FSL5_S_EXISTS : in std_logic;
      FSL5_M_CLK : out std_logic;
      FSL5_M_WRITE : out std_logic;
      FSL5_M_DATA : out std_logic_vector(0 to 31);
      FSL5_M_CONTROL : out std_logic;
      FSL5_M_FULL : in std_logic;
      FSL6_S_CLK : out std_logic;
      FSL6_S_READ : out std_logic;
      FSL6_S_DATA : in std_logic_vector(0 to 31);
      FSL6_S_CONTROL : in std_logic;
      FSL6_S_EXISTS : in std_logic;
      FSL6_M_CLK : out std_logic;
      FSL6_M_WRITE : out std_logic;
      FSL6_M_DATA : out std_logic_vector(0 to 31);
      FSL6_M_CONTROL : out std_logic;
      FSL6_M_FULL : in std_logic;
      FSL7_S_CLK : out std_logic;
      FSL7_S_READ : out std_logic;
      FSL7_S_DATA : in std_logic_vector(0 to 31);
      FSL7_S_CONTROL : in std_logic;
      FSL7_S_EXISTS : in std_logic;
      FSL7_M_CLK : out std_logic;
      FSL7_M_WRITE : out std_logic;
      FSL7_M_DATA : out std_logic_vector(0 to 31);
      FSL7_M_CONTROL : out std_logic;
      FSL7_M_FULL : in std_logic;
      ICACHE_FSL_IN_CLK : out std_logic;
      ICACHE_FSL_IN_READ : out std_logic;
      ICACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
      ICACHE_FSL_IN_CONTROL : in std_logic;
      ICACHE_FSL_IN_EXISTS : in std_logic;
      ICACHE_FSL_OUT_CLK : out std_logic;
      ICACHE_FSL_OUT_WRITE : out std_logic;
      ICACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
      ICACHE_FSL_OUT_CONTROL : out std_logic;
      ICACHE_FSL_OUT_FULL : in std_logic;
      DCACHE_FSL_IN_CLK : out std_logic;
      DCACHE_FSL_IN_READ : out std_logic;
      DCACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
      DCACHE_FSL_IN_CONTROL : in std_logic;
      DCACHE_FSL_IN_EXISTS : in std_logic;
      DCACHE_FSL_OUT_CLK : out std_logic;
      DCACHE_FSL_OUT_WRITE : out std_logic;
      DCACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
      DCACHE_FSL_OUT_CONTROL : out std_logic;
      DCACHE_FSL_OUT_FULL : in std_logic
    );
  end component;

  component ilmb_wrapper is
    port (
      LMB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      LMB_Rst : out std_logic;
      M_ABus : in std_logic_vector(0 to 31);
      M_ReadStrobe : in std_logic;
      M_WriteStrobe : in std_logic;
      M_AddrStrobe : in std_logic;
      M_DBus : in std_logic_vector(0 to 31);
      M_BE : in std_logic_vector(0 to 3);
      Sl_DBus : in std_logic_vector(0 to 31);
      Sl_Ready : in std_logic_vector(0 to 0);
      LMB_ABus : out std_logic_vector(0 to 31);
      LMB_ReadStrobe : out std_logic;
      LMB_WriteStrobe : out std_logic;
      LMB_AddrStrobe : out std_logic;
      LMB_ReadDBus : out std_logic_vector(0 to 31);
      LMB_WriteDBus : out std_logic_vector(0 to 31);
      LMB_Ready : out std_logic;
      LMB_BE : out std_logic_vector(0 to 3)
    );
  end component;

  component dlmb_wrapper is
    port (
      LMB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      LMB_Rst : out std_logic;
      M_ABus : in std_logic_vector(0 to 31);
      M_ReadStrobe : in std_logic;
      M_WriteStrobe : in std_logic;
      M_AddrStrobe : in std_logic;
      M_DBus : in std_logic_vector(0 to 31);
      M_BE : in std_logic_vector(0 to 3);
      Sl_DBus : in std_logic_vector(0 to 31);
      Sl_Ready : in std_logic_vector(0 to 0);
      LMB_ABus : out std_logic_vector(0 to 31);
      LMB_ReadStrobe : out std_logic;
      LMB_WriteStrobe : out std_logic;
      LMB_AddrStrobe : out std_logic;
      LMB_ReadDBus : out std_logic_vector(0 to 31);
      LMB_WriteDBus : out std_logic_vector(0 to 31);
      LMB_Ready : out std_logic;
      LMB_BE : out std_logic_vector(0 to 3)
    );
  end component;

  component dlmb_cntlr_wrapper is
    port (
      LMB_Clk : in std_logic;
      LMB_Rst : in std_logic;
      LMB_ABus : in std_logic_vector(0 to 31);
      LMB_WriteDBus : in std_logic_vector(0 to 31);
      LMB_AddrStrobe : in std_logic;
      LMB_ReadStrobe : in std_logic;
      LMB_WriteStrobe : in std_logic;
      LMB_BE : in std_logic_vector(0 to 3);
      Sl_DBus : out std_logic_vector(0 to 31);
      Sl_Ready : out std_logic;
      BRAM_Rst_A : out std_logic;
      BRAM_Clk_A : out std_logic;
      BRAM_EN_A : out std_logic;
      BRAM_WEN_A : out std_logic_vector(0 to 3);
      BRAM_Addr_A : out std_logic_vector(0 to 31);
      BRAM_Din_A : in std_logic_vector(0 to 31);
      BRAM_Dout_A : out std_logic_vector(0 to 31)
    );
  end component;

  component ilmb_cntlr_wrapper is
    port (
      LMB_Clk : in std_logic;
      LMB_Rst : in std_logic;
      LMB_ABus : in std_logic_vector(0 to 31);
      LMB_WriteDBus : in std_logic_vector(0 to 31);
      LMB_AddrStrobe : in std_logic;
      LMB_ReadStrobe : in std_logic;
      LMB_WriteStrobe : in std_logic;
      LMB_BE : in std_logic_vector(0 to 3);
      Sl_DBus : out std_logic_vector(0 to 31);
      Sl_Ready : out std_logic;
      BRAM_Rst_A : out std_logic;
      BRAM_Clk_A : out std_logic;
      BRAM_EN_A : out std_logic;
      BRAM_WEN_A : out std_logic_vector(0 to 3);
      BRAM_Addr_A : out std_logic_vector(0 to 31);
      BRAM_Din_A : in std_logic_vector(0 to 31);
      BRAM_Dout_A : out std_logic_vector(0 to 31)
    );
  end component;

  component lmb_bram_wrapper is
    port (
      BRAM_Rst_A : in std_logic;
      BRAM_Clk_A : in std_logic;
      BRAM_EN_A : in std_logic;
      BRAM_WEN_A : in std_logic_vector(0 to 3);
      BRAM_Addr_A : in std_logic_vector(0 to 31);
      BRAM_Din_A : out std_logic_vector(0 to 31);
      BRAM_Dout_A : in std_logic_vector(0 to 31);
      BRAM_Rst_B : in std_logic;
      BRAM_Clk_B : in std_logic;
      BRAM_EN_B : in std_logic;
      BRAM_WEN_B : in std_logic_vector(0 to 3);
      BRAM_Addr_B : in std_logic_vector(0 to 31);
      BRAM_Din_B : out std_logic_vector(0 to 31);
      BRAM_Dout_B : in std_logic_vector(0 to 31)
    );
  end component;

  component mb_opb_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : out std_logic;
      SYS_Rst : in std_logic;
      Debug_SYS_Rst : in std_logic;
      WDT_Rst : in std_logic;
      M_ABus : in std_logic_vector(0 to 31);
      M_BE : in std_logic_vector(0 to 3);
      M_beXfer : in std_logic_vector(0 to 0);
      M_busLock : in std_logic_vector(0 to 0);
      M_DBus : in std_logic_vector(0 to 31);
      M_DBusEn : in std_logic_vector(0 to 0);
      M_DBusEn32_63 : in std_logic_vector(0 to 0);
      M_dwXfer : in std_logic_vector(0 to 0);
      M_fwXfer : in std_logic_vector(0 to 0);
      M_hwXfer : in std_logic_vector(0 to 0);
      M_request : in std_logic_vector(0 to 0);
      M_RNW : in std_logic_vector(0 to 0);
      M_select : in std_logic_vector(0 to 0);
      M_seqAddr : in std_logic_vector(0 to 0);
      Sl_beAck : in std_logic_vector(0 to 14);
      Sl_DBus : in std_logic_vector(0 to 479);
      Sl_DBusEn : in std_logic_vector(0 to 14);
      Sl_DBusEn32_63 : in std_logic_vector(0 to 14);
      Sl_errAck : in std_logic_vector(0 to 14);
      Sl_dwAck : in std_logic_vector(0 to 14);
      Sl_fwAck : in std_logic_vector(0 to 14);
      Sl_hwAck : in std_logic_vector(0 to 14);
      Sl_retry : in std_logic_vector(0 to 14);
      Sl_toutSup : in std_logic_vector(0 to 14);
      Sl_xferAck : in std_logic_vector(0 to 14);
      OPB_MRequest : out std_logic_vector(0 to 0);
      OPB_ABus : out std_logic_vector(0 to 31);
      OPB_BE : out std_logic_vector(0 to 3);
      OPB_beXfer : out std_logic;
      OPB_beAck : out std_logic;
      OPB_busLock : out std_logic;
      OPB_rdDBus : out std_logic_vector(0 to 31);
      OPB_wrDBus : out std_logic_vector(0 to 31);
      OPB_DBus : out std_logic_vector(0 to 31);
      OPB_errAck : out std_logic;
      OPB_dwAck : out std_logic;
      OPB_dwXfer : out std_logic;
      OPB_fwAck : out std_logic;
      OPB_fwXfer : out std_logic;
      OPB_hwAck : out std_logic;
      OPB_hwXfer : out std_logic;
      OPB_MGrant : out std_logic_vector(0 to 0);
      OPB_pendReq : out std_logic_vector(0 to 0);
      OPB_retry : out std_logic;
      OPB_RNW : out std_logic;
      OPB_select : out std_logic;
      OPB_seqAddr : out std_logic;
      OPB_timeout : out std_logic;
      OPB_toutSup : out std_logic;
      OPB_xferAck : out std_logic
    );
  end component;

  component leds_8bit_wrapper is
    port (
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_Clk : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_Rst : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      Sln_DBus : out std_logic_vector(0 to 31);
      Sln_errAck : out std_logic;
      Sln_retry : out std_logic;
      Sln_toutSup : out std_logic;
      Sln_xferAck : out std_logic;
      IP2INTC_Irpt : out std_logic;
      GPIO_in : in std_logic_vector(0 to 7);
      GPIO_d_out : out std_logic_vector(0 to 7);
      GPIO_t_out : out std_logic_vector(0 to 7);
      GPIO2_in : in std_logic_vector(0 to 7);
      GPIO2_d_out : out std_logic_vector(0 to 7);
      GPIO2_t_out : out std_logic_vector(0 to 7);
      GPIO_IO_I : in std_logic_vector(0 to 7);
      GPIO_IO_O : out std_logic_vector(0 to 7);
      GPIO_IO_T : out std_logic_vector(0 to 7);
      GPIO2_IO_I : in std_logic_vector(0 to 7);
      GPIO2_IO_O : out std_logic_vector(0 to 7);
      GPIO2_IO_T : out std_logic_vector(0 to 7)
    );
  end component;

  component push_buttons_3bit_wrapper is
    port (
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_Clk : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_Rst : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      Sln_DBus : out std_logic_vector(0 to 31);
      Sln_errAck : out std_logic;
      Sln_retry : out std_logic;
      Sln_toutSup : out std_logic;
      Sln_xferAck : out std_logic;
      IP2INTC_Irpt : out std_logic;
      GPIO_in : in std_logic_vector(0 to 4);
      GPIO_d_out : out std_logic_vector(0 to 4);
      GPIO_t_out : out std_logic_vector(0 to 4);
      GPIO2_in : in std_logic_vector(0 to 4);
      GPIO2_d_out : out std_logic_vector(0 to 4);
      GPIO2_t_out : out std_logic_vector(0 to 4);
      GPIO_IO_I : in std_logic_vector(0 to 4);
      GPIO_IO_O : out std_logic_vector(0 to 4);
      GPIO_IO_T : out std_logic_vector(0 to 4);
      GPIO2_IO_I : in std_logic_vector(0 to 4);
      GPIO2_IO_O : out std_logic_vector(0 to 4);
      GPIO2_IO_T : out std_logic_vector(0 to 4)
    );
  end component;

  component switches_8bit_wrapper is
    port (
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_Clk : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_Rst : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      Sln_DBus : out std_logic_vector(0 to 31);
      Sln_errAck : out std_logic;
      Sln_retry : out std_logic;
      Sln_toutSup : out std_logic;
      Sln_xferAck : out std_logic;
      IP2INTC_Irpt : out std_logic;
      GPIO_in : in std_logic_vector(0 to 7);
      GPIO_d_out : out std_logic_vector(0 to 7);
      GPIO_t_out : out std_logic_vector(0 to 7);
      GPIO2_in : in std_logic_vector(0 to 7);
      GPIO2_d_out : out std_logic_vector(0 to 7);
      GPIO2_t_out : out std_logic_vector(0 to 7);
      GPIO_IO_I : in std_logic_vector(0 to 7);
      GPIO_IO_O : out std_logic_vector(0 to 7);
      GPIO_IO_T : out std_logic_vector(0 to 7);
      GPIO2_IO_I : in std_logic_vector(0 to 7);
      GPIO2_IO_O : out std_logic_vector(0 to 7);
      GPIO2_IO_T : out std_logic_vector(0 to 7)
    );
  end component;

  component rs232_port_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : in std_logic;
      Interrupt : out std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_RNW : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      UART_DBus : out std_logic_vector(0 to 31);
      UART_errAck : out std_logic;
      UART_retry : out std_logic;
      UART_toutSup : out std_logic;
      UART_xferAck : out std_logic;
      RX : in std_logic;
      TX : out std_logic
    );
  end component;

  component micron_ram_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : in std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_DBus : in std_logic_vector(0 to 31);
      Sln_DBus : out std_logic_vector(0 to 31);
      OPB_select : in std_logic;
      OPB_RNW : in std_logic;
      OPB_seqAddr : in std_logic;
      OPB_BE : in std_logic_vector(0 to 3);
      Sln_xferAck : out std_logic;
      Sln_errAck : out std_logic;
      Sln_toutSup : out std_logic;
      Sln_retry : out std_logic;
      Mem_A : out std_logic_vector(0 to 31);
      Mem_DQ_I : in std_logic_vector(0 to 15);
      Mem_DQ_O : out std_logic_vector(0 to 15);
      Mem_DQ_T : out std_logic_vector(0 to 15);
      Mem_CEN : out std_logic_vector(0 to 0);
      Mem_OEN : out std_logic_vector(0 to 0);
      Mem_WEN : out std_logic;
      Mem_QWEN : out std_logic_vector(0 to 1);
      Mem_BEN : out std_logic_vector(0 to 1);
      Mem_RPN : out std_logic;
      Mem_CE : out std_logic_vector(0 to 0);
      Mem_ADV_LDN : out std_logic;
      Mem_LBON : out std_logic;
      Mem_CKEN : out std_logic;
      Mem_RNW : out std_logic
    );
  end component;

  component micron_ram_util_bus_split_0_wrapper is
    port (
      Sig : in std_logic_vector(0 to 31);
      Out1 : out std_logic_vector(0 to 8);
      Out2 : out std_logic_vector(9 to 31)
    );
  end component;

  component dcm_0_wrapper is
    port (
      RST : in std_logic;
      CLKIN : in std_logic;
      CLKFB : in std_logic;
      PSEN : in std_logic;
      PSINCDEC : in std_logic;
      PSCLK : in std_logic;
      DSSEN : in std_logic;
      CLK0 : out std_logic;
      CLK90 : out std_logic;
      CLK180 : out std_logic;
      CLK270 : out std_logic;
      CLKDV : out std_logic;
      CLK2X : out std_logic;
      CLK2X180 : out std_logic;
      CLKFX : out std_logic;
      CLKFX180 : out std_logic;
      STATUS : out std_logic_vector(7 downto 0);
      LOCKED : out std_logic;
      PSDONE : out std_logic
    );
  end component;

  component sseg_wrapper is
    port (
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_Clk : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_Rst : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      Sln_DBus : out std_logic_vector(0 to 31);
      Sln_errAck : out std_logic;
      Sln_retry : out std_logic;
      Sln_toutSup : out std_logic;
      Sln_xferAck : out std_logic;
      IP2INTC_Irpt : out std_logic;
      GPIO_in : in std_logic_vector(0 to 15);
      GPIO_d_out : out std_logic_vector(0 to 15);
      GPIO_t_out : out std_logic_vector(0 to 15);
      GPIO2_in : in std_logic_vector(0 to 15);
      GPIO2_d_out : out std_logic_vector(0 to 15);
      GPIO2_t_out : out std_logic_vector(0 to 15);
      GPIO_IO_I : in std_logic_vector(0 to 15);
      GPIO_IO_O : out std_logic_vector(0 to 15);
      GPIO_IO_T : out std_logic_vector(0 to 15);
      GPIO2_IO_I : in std_logic_vector(0 to 15);
      GPIO2_IO_O : out std_logic_vector(0 to 15);
      GPIO2_IO_T : out std_logic_vector(0 to 15)
    );
  end component;

  component timer_0_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : in std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      TC_DBus : out std_logic_vector(0 to 31);
      TC_errAck : out std_logic;
      TC_retry : out std_logic;
      TC_toutSup : out std_logic;
      TC_xferAck : out std_logic;
      CaptureTrig0 : in std_logic;
      CaptureTrig1 : in std_logic;
      GenerateOut0 : out std_logic;
      GenerateOut1 : out std_logic;
      PWM0 : out std_logic;
      Interrupt : out std_logic;
      Freeze : in std_logic
    );
  end component;

  component timer_1_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : in std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      TC_DBus : out std_logic_vector(0 to 31);
      TC_errAck : out std_logic;
      TC_retry : out std_logic;
      TC_toutSup : out std_logic;
      TC_xferAck : out std_logic;
      CaptureTrig0 : in std_logic;
      CaptureTrig1 : in std_logic;
      GenerateOut0 : out std_logic;
      GenerateOut1 : out std_logic;
      PWM0 : out std_logic;
      Interrupt : out std_logic;
      Freeze : in std_logic
    );
  end component;

  component sseg_d_wrapper is
    port (
      data : in std_logic_vector(15 downto 0);
      segs : out std_logic_vector(7 downto 0);
      seg_en : out std_logic_vector(3 downto 0);
      clk : in std_logic
    );
  end component;

  component opb_intc_0_wrapper is
    port (
      OPB_Clk : in std_logic;
      Intr : in std_logic_vector(4 downto 0);
      OPB_Rst : in std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_RNW : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      IntC_DBus : out std_logic_vector(0 to 31);
      IntC_errAck : out std_logic;
      IntC_retry : out std_logic;
      IntC_toutSup : out std_logic;
      IntC_xferAck : out std_logic;
      Irq : out std_logic
    );
  end component;

  component timer_2_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : in std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      TC_DBus : out std_logic_vector(0 to 31);
      TC_errAck : out std_logic;
      TC_retry : out std_logic;
      TC_toutSup : out std_logic;
      TC_xferAck : out std_logic;
      CaptureTrig0 : in std_logic;
      CaptureTrig1 : in std_logic;
      GenerateOut0 : out std_logic;
      GenerateOut1 : out std_logic;
      PWM0 : out std_logic;
      Interrupt : out std_logic;
      Freeze : in std_logic
    );
  end component;

  component timer_3_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : in std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      TC_DBus : out std_logic_vector(0 to 31);
      TC_errAck : out std_logic;
      TC_retry : out std_logic;
      TC_toutSup : out std_logic;
      TC_xferAck : out std_logic;
      CaptureTrig0 : in std_logic;
      CaptureTrig1 : in std_logic;
      GenerateOut0 : out std_logic;
      GenerateOut1 : out std_logic;
      PWM0 : out std_logic;
      Interrupt : out std_logic;
      Freeze : in std_logic
    );
  end component;

  component spi_wrapper is
    port (
      SCK_I : in std_logic;
      SCK_O : out std_logic;
      SCK_T : out std_logic;
      MISO_I : in std_logic;
      MISO_O : out std_logic;
      MISO_T : out std_logic;
      MOSI_I : in std_logic;
      MOSI_O : out std_logic;
      MOSI_T : out std_logic;
      SPISEL : in std_logic;
      SS_I : in std_logic_vector(0 to 0);
      SS_O : out std_logic_vector(0 to 0);
      SS_T : out std_logic;
      OPB_Rst : in std_logic;
      IP2INTC_Irpt : out std_logic;
      Freeze : in std_logic;
      OPB_Clk : in std_logic;
      OPB_select : in std_logic;
      OPB_RNW : in std_logic;
      OPB_seqAddr : in std_logic;
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_DBus : in std_logic_vector(0 to 31);
      SPI_DBus : out std_logic_vector(0 to 31);
      SPI_xferAck : out std_logic;
      SPI_errAck : out std_logic;
      SPI_toutSup : out std_logic;
      SPI_retry : out std_logic
    );
  end component;

  component lcd_fsl_0_wrapper is
    port (
      FSL_Clk : in std_logic;
      FSL_Rst : in std_logic;
      FSL_S_Clk : out std_logic;
      FSL_S_Read : out std_logic;
      FSL_S_Data : in std_logic_vector(0 to 31);
      FSL_S_Control : in std_logic;
      FSL_S_Exists : in std_logic;
      LCD_dio : out std_logic;
      LCD_sck : out std_logic;
      LCD_cs : out std_logic
    );
  end component;

  component fsl_v20_0_wrapper is
    port (
      FSL_Clk : in std_logic;
      SYS_Rst : in std_logic;
      FSL_Rst : out std_logic;
      FSL_M_Clk : in std_logic;
      FSL_M_Data : in std_logic_vector(0 to 31);
      FSL_M_Control : in std_logic;
      FSL_M_Write : in std_logic;
      FSL_M_Full : out std_logic;
      FSL_S_Clk : in std_logic;
      FSL_S_Data : out std_logic_vector(0 to 31);
      FSL_S_Control : out std_logic;
      FSL_S_Read : in std_logic;
      FSL_S_Exists : out std_logic;
      FSL_Full : out std_logic;
      FSL_Has_Data : out std_logic;
      FSL_Control_IRQ : out std_logic
    );
  end component;

  component spi2_wrapper is
    port (
      D : out std_logic_vector(0 to 15);
      SCK : in std_logic;
      SS : in std_logic_vector(0 to 0);
      MISO : in std_logic
    );
  end component;

  component spi2_data_wrapper is
    port (
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_Clk : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_Rst : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      Sln_DBus : out std_logic_vector(0 to 31);
      Sln_errAck : out std_logic;
      Sln_retry : out std_logic;
      Sln_toutSup : out std_logic;
      Sln_xferAck : out std_logic;
      IP2INTC_Irpt : out std_logic;
      GPIO_in : in std_logic_vector(0 to 15);
      GPIO_d_out : out std_logic_vector(0 to 15);
      GPIO_t_out : out std_logic_vector(0 to 15);
      GPIO2_in : in std_logic_vector(0 to 15);
      GPIO2_d_out : out std_logic_vector(0 to 15);
      GPIO2_t_out : out std_logic_vector(0 to 15);
      GPIO_IO_I : in std_logic_vector(0 to 15);
      GPIO_IO_O : out std_logic_vector(0 to 15);
      GPIO_IO_T : out std_logic_vector(0 to 15);
      GPIO2_IO_I : in std_logic_vector(0 to 15);
      GPIO2_IO_O : out std_logic_vector(0 to 15);
      GPIO2_IO_T : out std_logic_vector(0 to 15)
    );
  end component;

  component gpio_wrapper is
    port (
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_Clk : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      OPB_RNW : in std_logic;
      OPB_Rst : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      Sln_DBus : out std_logic_vector(0 to 31);
      Sln_errAck : out std_logic;
      Sln_retry : out std_logic;
      Sln_toutSup : out std_logic;
      Sln_xferAck : out std_logic;
      IP2INTC_Irpt : out std_logic;
      GPIO_in : in std_logic_vector(0 to 31);
      GPIO_d_out : out std_logic_vector(0 to 31);
      GPIO_t_out : out std_logic_vector(0 to 31);
      GPIO2_in : in std_logic_vector(0 to 31);
      GPIO2_d_out : out std_logic_vector(0 to 31);
      GPIO2_t_out : out std_logic_vector(0 to 31);
      GPIO_IO_I : in std_logic_vector(0 to 31);
      GPIO_IO_O : out std_logic_vector(0 to 31);
      GPIO_IO_T : out std_logic_vector(0 to 31);
      GPIO2_IO_I : in std_logic_vector(0 to 31);
      GPIO2_IO_O : out std_logic_vector(0 to 31);
      GPIO2_IO_T : out std_logic_vector(0 to 31)
    );
  end component;

  component lcd_uart_wrapper is
    port (
      OPB_Clk : in std_logic;
      OPB_Rst : in std_logic;
      Interrupt : out std_logic;
      OPB_ABus : in std_logic_vector(0 to 31);
      OPB_BE : in std_logic_vector(0 to 3);
      OPB_RNW : in std_logic;
      OPB_select : in std_logic;
      OPB_seqAddr : in std_logic;
      OPB_DBus : in std_logic_vector(0 to 31);
      UART_DBus : out std_logic_vector(0 to 31);
      UART_errAck : out std_logic;
      UART_retry : out std_logic;
      UART_toutSup : out std_logic;
      UART_xferAck : out std_logic;
      RX : in std_logic;
      TX : out std_logic
    );
  end component;

  component IOBUF is
    port (
      I : in std_logic;
      IO : inout std_logic;
      O : out std_logic;
      T : in std_logic
    );
  end component;

  -- Internal signals

  signal dcm_clk_s : std_logic;
  signal dlmb_LMB_ABus : std_logic_vector(0 to 31);
  signal dlmb_LMB_AddrStrobe : std_logic;
  signal dlmb_LMB_BE : std_logic_vector(0 to 3);
  signal dlmb_LMB_ReadDBus : std_logic_vector(0 to 31);
  signal dlmb_LMB_ReadStrobe : std_logic;
  signal dlmb_LMB_Ready : std_logic;
  signal dlmb_LMB_WriteDBus : std_logic_vector(0 to 31);
  signal dlmb_LMB_WriteStrobe : std_logic;
  signal dlmb_M_ABus : std_logic_vector(0 to 31);
  signal dlmb_M_AddrStrobe : std_logic;
  signal dlmb_M_BE : std_logic_vector(0 to 3);
  signal dlmb_M_DBus : std_logic_vector(0 to 31);
  signal dlmb_M_ReadStrobe : std_logic;
  signal dlmb_M_WriteStrobe : std_logic;
  signal dlmb_OPB_Rst : std_logic;
  signal dlmb_Sl_DBus : std_logic_vector(0 to 31);
  signal dlmb_Sl_Ready : std_logic_vector(0 to 0);
  signal dlmb_port_BRAM_Addr : std_logic_vector(0 to 31);
  signal dlmb_port_BRAM_Clk : std_logic;
  signal dlmb_port_BRAM_Din : std_logic_vector(0 to 31);
  signal dlmb_port_BRAM_Dout : std_logic_vector(0 to 31);
  signal dlmb_port_BRAM_EN : std_logic;
  signal dlmb_port_BRAM_Rst : std_logic;
  signal dlmb_port_BRAM_WEN : std_logic_vector(0 to 3);
  signal fpga_0_LEDs_8Bit_GPIO_d_out : std_logic_vector(0 to 7);
  signal fpga_0_Micron_RAM_Mem_A : std_logic_vector(9 to 31);
  signal fpga_0_Micron_RAM_Mem_A_split : std_logic_vector(0 to 31);
  signal fpga_0_Micron_RAM_Mem_BEN : std_logic_vector(0 to 1);
  signal fpga_0_Micron_RAM_Mem_DQ_I : std_logic_vector(0 to 15);
  signal fpga_0_Micron_RAM_Mem_DQ_O : std_logic_vector(0 to 15);
  signal fpga_0_Micron_RAM_Mem_DQ_T : std_logic_vector(0 to 15);
  signal fpga_0_Micron_RAM_Mem_OEN : std_logic_vector(0 to 0);
  signal fpga_0_Micron_RAM_Mem_WEN : std_logic;
  signal fpga_0_Push_Buttons_3Bit_GPIO_in : std_logic_vector(0 to 4);
  signal fpga_0_RS232_PORT_RX : std_logic;
  signal fpga_0_RS232_PORT_TX : std_logic;
  signal fpga_0_Switches_8Bit_GPIO_in : std_logic_vector(0 to 7);
  signal fsl_v20_0_FSL_M_Control : std_logic;
  signal fsl_v20_0_FSL_M_Data : std_logic_vector(0 to 31);
  signal fsl_v20_0_FSL_M_Full : std_logic;
  signal fsl_v20_0_FSL_M_Write : std_logic;
  signal fsl_v20_0_FSL_S_Control : std_logic;
  signal fsl_v20_0_FSL_S_Data : std_logic_vector(0 to 31);
  signal fsl_v20_0_FSL_S_Exists : std_logic;
  signal fsl_v20_0_FSL_S_Read : std_logic;
  signal fsl_v20_0_OPB_Rst : std_logic;
  signal gpio_GPIO_d_out : std_logic_vector(0 to 31);
  signal ilmb_LMB_ABus : std_logic_vector(0 to 31);
  signal ilmb_LMB_AddrStrobe : std_logic;
  signal ilmb_LMB_BE : std_logic_vector(0 to 3);
  signal ilmb_LMB_ReadDBus : std_logic_vector(0 to 31);
  signal ilmb_LMB_ReadStrobe : std_logic;
  signal ilmb_LMB_Ready : std_logic;
  signal ilmb_LMB_WriteDBus : std_logic_vector(0 to 31);
  signal ilmb_LMB_WriteStrobe : std_logic;
  signal ilmb_M_ABus : std_logic_vector(0 to 31);
  signal ilmb_M_AddrStrobe : std_logic;
  signal ilmb_M_ReadStrobe : std_logic;
  signal ilmb_OPB_Rst : std_logic;
  signal ilmb_Sl_DBus : std_logic_vector(0 to 31);
  signal ilmb_Sl_Ready : std_logic_vector(0 to 0);
  signal ilmb_port_BRAM_Addr : std_logic_vector(0 to 31);
  signal ilmb_port_BRAM_Clk : std_logic;
  signal ilmb_port_BRAM_Din : std_logic_vector(0 to 31);
  signal ilmb_port_BRAM_Dout : std_logic_vector(0 to 31);
  signal ilmb_port_BRAM_EN : std_logic;
  signal ilmb_port_BRAM_Rst : std_logic;
  signal ilmb_port_BRAM_WEN : std_logic_vector(0 to 3);
  signal lcd_fsl_0_LCD_cs : std_logic;
  signal lcd_fsl_0_LCD_dio : std_logic;
  signal lcd_fsl_0_LCD_sck : std_logic;
  signal lcd_uart_RX : std_logic;
  signal lcd_uart_TX : std_logic;
  signal mb_opb_M_ABus : std_logic_vector(0 to 31);
  signal mb_opb_M_BE : std_logic_vector(0 to 3);
  signal mb_opb_M_DBus : std_logic_vector(0 to 31);
  signal mb_opb_M_RNW : std_logic_vector(0 to 0);
  signal mb_opb_M_busLock : std_logic_vector(0 to 0);
  signal mb_opb_M_request : std_logic_vector(0 to 0);
  signal mb_opb_M_select : std_logic_vector(0 to 0);
  signal mb_opb_M_seqAddr : std_logic_vector(0 to 0);
  signal mb_opb_OPB_ABus : std_logic_vector(0 to 31);
  signal mb_opb_OPB_BE : std_logic_vector(0 to 3);
  signal mb_opb_OPB_DBus : std_logic_vector(0 to 31);
  signal mb_opb_OPB_MGrant : std_logic_vector(0 to 0);
  signal mb_opb_OPB_RNW : std_logic;
  signal mb_opb_OPB_Rst : std_logic;
  signal mb_opb_OPB_errAck : std_logic;
  signal mb_opb_OPB_retry : std_logic;
  signal mb_opb_OPB_select : std_logic;
  signal mb_opb_OPB_seqAddr : std_logic;
  signal mb_opb_OPB_timeout : std_logic;
  signal mb_opb_OPB_xferAck : std_logic;
  signal mb_opb_Sl_DBus : std_logic_vector(0 to 479);
  signal mb_opb_Sl_errAck : std_logic_vector(0 to 14);
  signal mb_opb_Sl_retry : std_logic_vector(0 to 14);
  signal mb_opb_Sl_toutSup : std_logic_vector(0 to 14);
  signal mb_opb_Sl_xferAck : std_logic_vector(0 to 14);
  signal net_gnd0 : std_logic;
  signal net_gnd1 : std_logic_vector(0 to 0);
  signal net_gnd4 : std_logic_vector(0 to 3);
  signal net_gnd5 : std_logic_vector(0 to 4);
  signal net_gnd8 : std_logic_vector(0 to 7);
  signal net_gnd15 : std_logic_vector(0 to 14);
  signal net_gnd16 : std_logic_vector(0 to 15);
  signal net_gnd32 : std_logic_vector(0 to 31);
  signal net_vcc0 : std_logic;
  signal net_vcc1 : std_logic_vector(0 to 0);
  signal net_vcc15 : std_logic_vector(0 to 14);
  signal opb_intc_0_Irq : std_logic;
  signal opb_spi_0_IP2INTC_Irpt : std_logic;
  signal opb_spi_0_MISO_I : std_logic;
  signal opb_spi_0_SCK_O : std_logic;
  signal opb_spi_0_SS_O : std_logic_vector(0 to 0);
  signal pgassign1 : std_logic_vector(4 downto 0);
  signal spi2_D : std_logic_vector(0 to 15);
  signal spi2_MISO : std_logic;
  signal sseg_GPIO_d_out : std_logic_vector(15 downto 0);
  signal sseg_d_seg_en : std_logic_vector(3 downto 0);
  signal sseg_d_segs : std_logic_vector(7 downto 0);
  signal sys_clk_s : std_logic;
  signal sys_rst_s : std_logic;
  signal timer_0_Interrupt : std_logic;
  signal timer_0_PWM0 : std_logic;
  signal timer_1_Interrupt : std_logic;
  signal timer_1_PWM0 : std_logic;
  signal timer_2_Interrupt : std_logic;
  signal timer_2_PWM0 : std_logic;
  signal timer_3_Interrupt : std_logic;

  attribute box_type : STRING;
  attribute box_type of microblaze_0_wrapper : component is "black_box";
  attribute box_type of ilmb_wrapper : component is "black_box";
  attribute box_type of dlmb_wrapper : component is "black_box";
  attribute box_type of dlmb_cntlr_wrapper : component is "black_box";
  attribute box_type of ilmb_cntlr_wrapper : component is "black_box";
  attribute box_type of lmb_bram_wrapper : component is "black_box";
  attribute box_type of mb_opb_wrapper : component is "black_box";
  attribute box_type of leds_8bit_wrapper : component is "black_box";
  attribute box_type of push_buttons_3bit_wrapper : component is "black_box";
  attribute box_type of switches_8bit_wrapper : component is "black_box";
  attribute box_type of rs232_port_wrapper : component is "black_box";
  attribute box_type of micron_ram_wrapper : component is "black_box";
  attribute box_type of micron_ram_util_bus_split_0_wrapper : component is "black_box";
  attribute box_type of dcm_0_wrapper : component is "black_box";
  attribute box_type of sseg_wrapper : component is "black_box";
  attribute box_type of timer_0_wrapper : component is "black_box";
  attribute box_type of timer_1_wrapper : component is "black_box";
  attribute box_type of sseg_d_wrapper : component is "black_box";
  attribute box_type of opb_intc_0_wrapper : component is "black_box";
  attribute box_type of timer_2_wrapper : component is "black_box";
  attribute box_type of timer_3_wrapper : component is "black_box";
  attribute box_type of spi_wrapper : component is "black_box";
  attribute box_type of lcd_fsl_0_wrapper : component is "black_box";
  attribute box_type of fsl_v20_0_wrapper : component is "black_box";
  attribute box_type of spi2_wrapper : component is "black_box";
  attribute box_type of spi2_data_wrapper : component is "black_box";
  attribute box_type of gpio_wrapper : component is "black_box";
  attribute box_type of lcd_uart_wrapper : component is "black_box";

begin

  -- Internal assignments

  fpga_0_RS232_PORT_RX <= fpga_0_RS232_PORT_RX_pin;
  fpga_0_RS232_PORT_TX_pin <= fpga_0_RS232_PORT_TX;
  fpga_0_LEDs_8Bit_GPIO_d_out_pin <= fpga_0_LEDs_8Bit_GPIO_d_out;
  fpga_0_Push_Buttons_3Bit_GPIO_in <= fpga_0_Push_Buttons_3Bit_GPIO_in_pin;
  fpga_0_Switches_8Bit_GPIO_in <= fpga_0_Switches_8Bit_GPIO_in_pin;
  fpga_0_Micron_RAM_Mem_A_pin <= fpga_0_Micron_RAM_Mem_A;
  fpga_0_Micron_RAM_Mem_OEN_pin <= fpga_0_Micron_RAM_Mem_OEN(0);
  fpga_0_Micron_RAM_Mem_WEN_pin <= fpga_0_Micron_RAM_Mem_WEN;
  fpga_0_Micron_RAM_Mem_BEN_pin <= fpga_0_Micron_RAM_Mem_BEN;
  dcm_clk_s <= sys_clk_pin;
  sys_rst_s <= sys_rst_pin;
  segs <= sseg_d_segs;
  seg_en <= sseg_d_seg_en;
  timer_0_PWM0_pin <= timer_0_PWM0;
  timer_1_PWM0_pin <= timer_1_PWM0;
  sck <= opb_spi_0_SCK_O;
  opb_spi_0_MISO_I <= miso;
  ss(0 to 0) <= opb_spi_0_SS_O(0 to 0);
  timer_2_PWM0_pin <= timer_2_PWM0;
  LCD_sck <= lcd_fsl_0_LCD_sck;
  LCD_dio <= lcd_fsl_0_LCD_dio;
  LCD_cs <= lcd_fsl_0_LCD_cs;
  spi2_MISO <= spi2_MISO_pin;
  gpio_out <= gpio_GPIO_d_out;
  lcd_uart_RX <= lcd_uart_RX_pin;
  lcd_uart_TX_pin <= lcd_uart_TX;
  pgassign1(4) <= timer_0_Interrupt;
  pgassign1(3) <= timer_1_Interrupt;
  pgassign1(2) <= timer_2_Interrupt;
  pgassign1(1) <= timer_3_Interrupt;
  pgassign1(0) <= opb_spi_0_IP2INTC_Irpt;
  net_gnd0 <= '0';
  fpga_0_net_gnd_pin <= net_gnd0;
  fpga_0_net_gnd_1_pin <= net_gnd0;
  fpga_0_net_gnd_2_pin <= net_gnd0;
  net_gnd1(0 to 0) <= B"0";
  net_gnd15(0 to 14) <= B"000000000000000";
  net_gnd16(0 to 15) <= B"0000000000000000";
  net_gnd32(0 to 31) <= B"00000000000000000000000000000000";
  net_gnd4(0 to 3) <= B"0000";
  net_gnd5(0 to 4) <= B"00000";
  net_gnd8(0 to 7) <= B"00000000";
  net_vcc0 <= '1';
  net_vcc1(0 to 0) <= B"1";
  net_vcc15(0 to 14) <= B"111111111111111";

  microblaze_0 : microblaze_0_wrapper
    port map (
      CLK => sys_clk_s,
      RESET => mb_opb_OPB_Rst,
      INTERRUPT => opb_intc_0_Irq,
      DEBUG_RST => net_gnd0,
      EXT_BRK => net_gnd0,
      EXT_NM_BRK => net_gnd0,
      DBG_STOP => net_gnd0,
      MB_Halted => open,
      INSTR => ilmb_LMB_ReadDBus,
      I_ADDRTAG => open,
      IREADY => ilmb_LMB_Ready,
      IWAIT => net_gnd0,
      INSTR_ADDR => ilmb_M_ABus,
      IFETCH => ilmb_M_ReadStrobe,
      I_AS => ilmb_M_AddrStrobe,
      DATA_READ => dlmb_LMB_ReadDBus,
      DREADY => dlmb_LMB_Ready,
      DWAIT => net_gnd0,
      DATA_WRITE => dlmb_M_DBus,
      DATA_ADDR => dlmb_M_ABus,
      D_ADDRTAG => open,
      D_AS => dlmb_M_AddrStrobe,
      READ_STROBE => dlmb_M_ReadStrobe,
      WRITE_STROBE => dlmb_M_WriteStrobe,
      BYTE_ENABLE => dlmb_M_BE,
      DM_ABUS => mb_opb_M_ABus,
      DM_BE => mb_opb_M_BE,
      DM_BUSLOCK => mb_opb_M_busLock(0),
      DM_DBUS => mb_opb_M_DBus,
      DM_REQUEST => mb_opb_M_request(0),
      DM_RNW => mb_opb_M_RNW(0),
      DM_SELECT => mb_opb_M_select(0),
      DM_SEQADDR => mb_opb_M_seqAddr(0),
      DOPB_DBUS => mb_opb_OPB_DBus,
      DOPB_ERRACK => mb_opb_OPB_errAck,
      DOPB_MGRANT => mb_opb_OPB_MGrant(0),
      DOPB_RETRY => mb_opb_OPB_retry,
      DOPB_TIMEOUT => mb_opb_OPB_timeout,
      DOPB_XFERACK => mb_opb_OPB_xferAck,
      IM_ABUS => open,
      IM_BE => open,
      IM_BUSLOCK => open,
      IM_DBUS => open,
      IM_REQUEST => open,
      IM_RNW => open,
      IM_SELECT => open,
      IM_SEQADDR => open,
      IOPB_DBUS => net_gnd32,
      IOPB_ERRACK => net_gnd0,
      IOPB_MGRANT => net_gnd0,
      IOPB_RETRY => net_gnd0,
      IOPB_TIMEOUT => net_gnd0,
      IOPB_XFERACK => net_gnd0,
      DBG_CLK => net_gnd0,
      DBG_TDI => net_gnd0,
      DBG_TDO => open,
      DBG_REG_EN => net_gnd5,
      DBG_CAPTURE => net_gnd0,
      DBG_UPDATE => net_gnd0,
      Trace_Instruction => open,
      Trace_Valid_Instr => open,
      Trace_PC => open,
      Trace_Reg_Write => open,
      Trace_Reg_Addr => open,
      Trace_MSR_Reg => open,
      Trace_New_Reg_Value => open,
      Trace_Exception_Taken => open,
      Trace_Exception_Kind => open,
      Trace_Jump_Taken => open,
      Trace_Delay_Slot => open,
      Trace_Data_Address => open,
      Trace_Data_Access => open,
      Trace_Data_Read => open,
      Trace_Data_Write => open,
      Trace_Data_Write_Value => open,
      Trace_Data_Byte_Enable => open,
      Trace_DCache_Req => open,
      Trace_DCache_Hit => open,
      Trace_ICache_Req => open,
      Trace_ICache_Hit => open,
      Trace_OF_PipeRun => open,
      Trace_EX_PipeRun => open,
      Trace_MEM_PipeRun => open,
      FSL0_S_CLK => open,
      FSL0_S_READ => open,
      FSL0_S_DATA => net_gnd32,
      FSL0_S_CONTROL => net_gnd0,
      FSL0_S_EXISTS => net_gnd0,
      FSL0_M_CLK => open,
      FSL0_M_WRITE => fsl_v20_0_FSL_M_Write,
      FSL0_M_DATA => fsl_v20_0_FSL_M_Data,
      FSL0_M_CONTROL => fsl_v20_0_FSL_M_Control,
      FSL0_M_FULL => fsl_v20_0_FSL_M_Full,
      FSL1_S_CLK => open,
      FSL1_S_READ => open,
      FSL1_S_DATA => net_gnd32,
      FSL1_S_CONTROL => net_gnd0,
      FSL1_S_EXISTS => net_gnd0,
      FSL1_M_CLK => open,
      FSL1_M_WRITE => open,
      FSL1_M_DATA => open,
      FSL1_M_CONTROL => open,
      FSL1_M_FULL => net_gnd0,
      FSL2_S_CLK => open,
      FSL2_S_READ => open,
      FSL2_S_DATA => net_gnd32,
      FSL2_S_CONTROL => net_gnd0,
      FSL2_S_EXISTS => net_gnd0,
      FSL2_M_CLK => open,
      FSL2_M_WRITE => open,
      FSL2_M_DATA => open,
      FSL2_M_CONTROL => open,
      FSL2_M_FULL => net_gnd0,
      FSL3_S_CLK => open,
      FSL3_S_READ => open,
      FSL3_S_DATA => net_gnd32,
      FSL3_S_CONTROL => net_gnd0,
      FSL3_S_EXISTS => net_gnd0,
      FSL3_M_CLK => open,
      FSL3_M_WRITE => open,
      FSL3_M_DATA => open,
      FSL3_M_CONTROL => open,
      FSL3_M_FULL => net_gnd0,
      FSL4_S_CLK => open,
      FSL4_S_READ => open,
      FSL4_S_DATA => net_gnd32,
      FSL4_S_CONTROL => net_gnd0,
      FSL4_S_EXISTS => net_gnd0,
      FSL4_M_CLK => open,
      FSL4_M_WRITE => open,
      FSL4_M_DATA => open,
      FSL4_M_CONTROL => open,
      FSL4_M_FULL => net_gnd0,
      FSL5_S_CLK => open,
      FSL5_S_READ => open,
      FSL5_S_DATA => net_gnd32,
      FSL5_S_CONTROL => net_gnd0,
      FSL5_S_EXISTS => net_gnd0,
      FSL5_M_CLK => open,
      FSL5_M_WRITE => open,
      FSL5_M_DATA => open,
      FSL5_M_CONTROL => open,
      FSL5_M_FULL => net_gnd0,
      FSL6_S_CLK => open,
      FSL6_S_READ => open,
      FSL6_S_DATA => net_gnd32,
      FSL6_S_CONTROL => net_gnd0,
      FSL6_S_EXISTS => net_gnd0,
      FSL6_M_CLK => open,
      FSL6_M_WRITE => open,
      FSL6_M_DATA => open,
      FSL6_M_CONTROL => open,
      FSL6_M_FULL => net_gnd0,
      FSL7_S_CLK => open,
      FSL7_S_READ => open,
      FSL7_S_DATA => net_gnd32,
      FSL7_S_CONTROL => net_gnd0,
      FSL7_S_EXISTS => net_gnd0,
      FSL7_M_CLK => open,
      FSL7_M_WRITE => open,
      FSL7_M_DATA => open,
      FSL7_M_CONTROL => open,
      FSL7_M_FULL => net_gnd0,
      ICACHE_FSL_IN_CLK => open,
      ICACHE_FSL_IN_READ => open,
      ICACHE_FSL_IN_DATA => net_gnd32,
      ICACHE_FSL_IN_CONTROL => net_gnd0,
      ICACHE_FSL_IN_EXISTS => net_gnd0,
      ICACHE_FSL_OUT_CLK => open,
      ICACHE_FSL_OUT_WRITE => open,
      ICACHE_FSL_OUT_DATA => open,
      ICACHE_FSL_OUT_CONTROL => open,
      ICACHE_FSL_OUT_FULL => net_gnd0,
      DCACHE_FSL_IN_CLK => open,
      DCACHE_FSL_IN_READ => open,
      DCACHE_FSL_IN_DATA => net_gnd32,
      DCACHE_FSL_IN_CONTROL => net_gnd0,
      DCACHE_FSL_IN_EXISTS => net_gnd0,
      DCACHE_FSL_OUT_CLK => open,
      DCACHE_FSL_OUT_WRITE => open,
      DCACHE_FSL_OUT_DATA => open,
      DCACHE_FSL_OUT_CONTROL => open,
      DCACHE_FSL_OUT_FULL => net_gnd0
    );

  ilmb : ilmb_wrapper
    port map (
      LMB_Clk => sys_clk_s,
      SYS_Rst => sys_rst_s,
      LMB_Rst => ilmb_OPB_Rst,
      M_ABus => ilmb_M_ABus,
      M_ReadStrobe => ilmb_M_ReadStrobe,
      M_WriteStrobe => net_gnd0,
      M_AddrStrobe => ilmb_M_AddrStrobe,
      M_DBus => net_gnd32,
      M_BE => net_gnd4,
      Sl_DBus => ilmb_Sl_DBus,
      Sl_Ready => ilmb_Sl_Ready(0 to 0),
      LMB_ABus => ilmb_LMB_ABus,
      LMB_ReadStrobe => ilmb_LMB_ReadStrobe,
      LMB_WriteStrobe => ilmb_LMB_WriteStrobe,
      LMB_AddrStrobe => ilmb_LMB_AddrStrobe,
      LMB_ReadDBus => ilmb_LMB_ReadDBus,
      LMB_WriteDBus => ilmb_LMB_WriteDBus,
      LMB_Ready => ilmb_LMB_Ready,
      LMB_BE => ilmb_LMB_BE
    );

  dlmb : dlmb_wrapper
    port map (
      LMB_Clk => sys_clk_s,
      SYS_Rst => sys_rst_s,
      LMB_Rst => dlmb_OPB_Rst,
      M_ABus => dlmb_M_ABus,
      M_ReadStrobe => dlmb_M_ReadStrobe,
      M_WriteStrobe => dlmb_M_WriteStrobe,
      M_AddrStrobe => dlmb_M_AddrStrobe,
      M_DBus => dlmb_M_DBus,
      M_BE => dlmb_M_BE,
      Sl_DBus => dlmb_Sl_DBus,
      Sl_Ready => dlmb_Sl_Ready(0 to 0),
      LMB_ABus => dlmb_LMB_ABus,
      LMB_ReadStrobe => dlmb_LMB_ReadStrobe,
      LMB_WriteStrobe => dlmb_LMB_WriteStrobe,
      LMB_AddrStrobe => dlmb_LMB_AddrStrobe,
      LMB_ReadDBus => dlmb_LMB_ReadDBus,
      LMB_WriteDBus => dlmb_LMB_WriteDBus,
      LMB_Ready => dlmb_LMB_Ready,
      LMB_BE => dlmb_LMB_BE
    );

  dlmb_cntlr : dlmb_cntlr_wrapper
    port map (
      LMB_Clk => sys_clk_s,
      LMB_Rst => dlmb_OPB_Rst,
      LMB_ABus => dlmb_LMB_ABus,
      LMB_WriteDBus => dlmb_LMB_WriteDBus,
      LMB_AddrStrobe => dlmb_LMB_AddrStrobe,
      LMB_ReadStrobe => dlmb_LMB_ReadStrobe,
      LMB_WriteStrobe => dlmb_LMB_WriteStrobe,
      LMB_BE => dlmb_LMB_BE,
      Sl_DBus => dlmb_Sl_DBus,
      Sl_Ready => dlmb_Sl_Ready(0),
      BRAM_Rst_A => dlmb_port_BRAM_Rst,
      BRAM_Clk_A => dlmb_port_BRAM_Clk,
      BRAM_EN_A => dlmb_port_BRAM_EN,
      BRAM_WEN_A => dlmb_port_BRAM_WEN,
      BRAM_Addr_A => dlmb_port_BRAM_Addr,
      BRAM_Din_A => dlmb_port_BRAM_Din,
      BRAM_Dout_A => dlmb_port_BRAM_Dout
    );

  ilmb_cntlr : ilmb_cntlr_wrapper
    port map (
      LMB_Clk => sys_clk_s,
      LMB_Rst => ilmb_OPB_Rst,
      LMB_ABus => ilmb_LMB_ABus,
      LMB_WriteDBus => ilmb_LMB_WriteDBus,
      LMB_AddrStrobe => ilmb_LMB_AddrStrobe,
      LMB_ReadStrobe => ilmb_LMB_ReadStrobe,
      LMB_WriteStrobe => ilmb_LMB_WriteStrobe,
      LMB_BE => ilmb_LMB_BE,
      Sl_DBus => ilmb_Sl_DBus,
      Sl_Ready => ilmb_Sl_Ready(0),
      BRAM_Rst_A => ilmb_port_BRAM_Rst,
      BRAM_Clk_A => ilmb_port_BRAM_Clk,
      BRAM_EN_A => ilmb_port_BRAM_EN,
      BRAM_WEN_A => ilmb_port_BRAM_WEN,
      BRAM_Addr_A => ilmb_port_BRAM_Addr,
      BRAM_Din_A => ilmb_port_BRAM_Din,
      BRAM_Dout_A => ilmb_port_BRAM_Dout
    );

  lmb_bram : lmb_bram_wrapper
    port map (
      BRAM_Rst_A => ilmb_port_BRAM_Rst,
      BRAM_Clk_A => ilmb_port_BRAM_Clk,
      BRAM_EN_A => ilmb_port_BRAM_EN,
      BRAM_WEN_A => ilmb_port_BRAM_WEN,
      BRAM_Addr_A => ilmb_port_BRAM_Addr,
      BRAM_Din_A => ilmb_port_BRAM_Din,
      BRAM_Dout_A => ilmb_port_BRAM_Dout,
      BRAM_Rst_B => dlmb_port_BRAM_Rst,
      BRAM_Clk_B => dlmb_port_BRAM_Clk,
      BRAM_EN_B => dlmb_port_BRAM_EN,
      BRAM_WEN_B => dlmb_port_BRAM_WEN,
      BRAM_Addr_B => dlmb_port_BRAM_Addr,
      BRAM_Din_B => dlmb_port_BRAM_Din,
      BRAM_Dout_B => dlmb_port_BRAM_Dout
    );

  mb_opb : mb_opb_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      SYS_Rst => sys_rst_s,
      Debug_SYS_Rst => net_gnd0,
      WDT_Rst => net_gnd0,
      M_ABus => mb_opb_M_ABus,
      M_BE => mb_opb_M_BE,
      M_beXfer => net_gnd1(0 to 0),
      M_busLock => mb_opb_M_busLock(0 to 0),
      M_DBus => mb_opb_M_DBus,
      M_DBusEn => net_gnd1(0 to 0),
      M_DBusEn32_63 => net_vcc1(0 to 0),
      M_dwXfer => net_gnd1(0 to 0),
      M_fwXfer => net_gnd1(0 to 0),
      M_hwXfer => net_gnd1(0 to 0),
      M_request => mb_opb_M_request(0 to 0),
      M_RNW => mb_opb_M_RNW(0 to 0),
      M_select => mb_opb_M_select(0 to 0),
      M_seqAddr => mb_opb_M_seqAddr(0 to 0),
      Sl_beAck => net_gnd15,
      Sl_DBus => mb_opb_Sl_DBus,
      Sl_DBusEn => net_vcc15,
      Sl_DBusEn32_63 => net_vcc15,
      Sl_errAck => mb_opb_Sl_errAck,
      Sl_dwAck => net_gnd15,
      Sl_fwAck => net_gnd15,
      Sl_hwAck => net_gnd15,
      Sl_retry => mb_opb_Sl_retry,
      Sl_toutSup => mb_opb_Sl_toutSup,
      Sl_xferAck => mb_opb_Sl_xferAck,
      OPB_MRequest => open,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_beXfer => open,
      OPB_beAck => open,
      OPB_busLock => open,
      OPB_rdDBus => open,
      OPB_wrDBus => open,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_errAck => mb_opb_OPB_errAck,
      OPB_dwAck => open,
      OPB_dwXfer => open,
      OPB_fwAck => open,
      OPB_fwXfer => open,
      OPB_hwAck => open,
      OPB_hwXfer => open,
      OPB_MGrant => mb_opb_OPB_MGrant(0 to 0),
      OPB_pendReq => open,
      OPB_retry => mb_opb_OPB_retry,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      OPB_timeout => mb_opb_OPB_timeout,
      OPB_toutSup => open,
      OPB_xferAck => mb_opb_OPB_xferAck
    );

  leds_8bit : leds_8bit_wrapper
    port map (
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_Clk => sys_clk_s,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      Sln_DBus => mb_opb_Sl_DBus(0 to 31),
      Sln_errAck => mb_opb_Sl_errAck(0),
      Sln_retry => mb_opb_Sl_retry(0),
      Sln_toutSup => mb_opb_Sl_toutSup(0),
      Sln_xferAck => mb_opb_Sl_xferAck(0),
      IP2INTC_Irpt => open,
      GPIO_in => net_gnd8,
      GPIO_d_out => fpga_0_LEDs_8Bit_GPIO_d_out,
      GPIO_t_out => open,
      GPIO2_in => net_gnd8,
      GPIO2_d_out => open,
      GPIO2_t_out => open,
      GPIO_IO_I => net_gnd8,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd8,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  push_buttons_3bit : push_buttons_3bit_wrapper
    port map (
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_Clk => sys_clk_s,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      Sln_DBus => mb_opb_Sl_DBus(32 to 63),
      Sln_errAck => mb_opb_Sl_errAck(1),
      Sln_retry => mb_opb_Sl_retry(1),
      Sln_toutSup => mb_opb_Sl_toutSup(1),
      Sln_xferAck => mb_opb_Sl_xferAck(1),
      IP2INTC_Irpt => open,
      GPIO_in => fpga_0_Push_Buttons_3Bit_GPIO_in,
      GPIO_d_out => open,
      GPIO_t_out => open,
      GPIO2_in => net_gnd5,
      GPIO2_d_out => open,
      GPIO2_t_out => open,
      GPIO_IO_I => net_gnd5,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd5,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  switches_8bit : switches_8bit_wrapper
    port map (
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_Clk => sys_clk_s,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      Sln_DBus => mb_opb_Sl_DBus(64 to 95),
      Sln_errAck => mb_opb_Sl_errAck(2),
      Sln_retry => mb_opb_Sl_retry(2),
      Sln_toutSup => mb_opb_Sl_toutSup(2),
      Sln_xferAck => mb_opb_Sl_xferAck(2),
      IP2INTC_Irpt => open,
      GPIO_in => fpga_0_Switches_8Bit_GPIO_in,
      GPIO_d_out => open,
      GPIO_t_out => open,
      GPIO2_in => net_gnd8,
      GPIO2_d_out => open,
      GPIO2_t_out => open,
      GPIO_IO_I => net_gnd8,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd8,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  rs232_port : rs232_port_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      Interrupt => open,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      OPB_DBus => mb_opb_OPB_DBus,
      UART_DBus => mb_opb_Sl_DBus(96 to 127),
      UART_errAck => mb_opb_Sl_errAck(3),
      UART_retry => mb_opb_Sl_retry(3),
      UART_toutSup => mb_opb_Sl_toutSup(3),
      UART_xferAck => mb_opb_Sl_xferAck(3),
      RX => fpga_0_RS232_PORT_RX,
      TX => fpga_0_RS232_PORT_TX
    );

  micron_ram : micron_ram_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_DBus => mb_opb_OPB_DBus,
      Sln_DBus => mb_opb_Sl_DBus(128 to 159),
      OPB_select => mb_opb_OPB_select,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      OPB_BE => mb_opb_OPB_BE,
      Sln_xferAck => mb_opb_Sl_xferAck(4),
      Sln_errAck => mb_opb_Sl_errAck(4),
      Sln_toutSup => mb_opb_Sl_toutSup(4),
      Sln_retry => mb_opb_Sl_retry(4),
      Mem_A => fpga_0_Micron_RAM_Mem_A_split,
      Mem_DQ_I => fpga_0_Micron_RAM_Mem_DQ_I,
      Mem_DQ_O => fpga_0_Micron_RAM_Mem_DQ_O,
      Mem_DQ_T => fpga_0_Micron_RAM_Mem_DQ_T,
      Mem_CEN => open,
      Mem_OEN => fpga_0_Micron_RAM_Mem_OEN(0 to 0),
      Mem_WEN => fpga_0_Micron_RAM_Mem_WEN,
      Mem_QWEN => open,
      Mem_BEN => fpga_0_Micron_RAM_Mem_BEN,
      Mem_RPN => open,
      Mem_CE => open,
      Mem_ADV_LDN => open,
      Mem_LBON => open,
      Mem_CKEN => open,
      Mem_RNW => open
    );

  micron_ram_util_bus_split_0 : micron_ram_util_bus_split_0_wrapper
    port map (
      Sig => fpga_0_Micron_RAM_Mem_A_split,
      Out1 => open,
      Out2 => fpga_0_Micron_RAM_Mem_A
    );

  dcm_0 : dcm_0_wrapper
    port map (
      RST => net_gnd0,
      CLKIN => dcm_clk_s,
      CLKFB => sys_clk_s,
      PSEN => net_gnd0,
      PSINCDEC => net_gnd0,
      PSCLK => net_gnd0,
      DSSEN => net_gnd0,
      CLK0 => sys_clk_s,
      CLK90 => open,
      CLK180 => open,
      CLK270 => open,
      CLKDV => open,
      CLK2X => open,
      CLK2X180 => open,
      CLKFX => open,
      CLKFX180 => open,
      STATUS => open,
      LOCKED => open,
      PSDONE => open
    );

  sseg : sseg_wrapper
    port map (
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_Clk => sys_clk_s,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      Sln_DBus => mb_opb_Sl_DBus(160 to 191),
      Sln_errAck => mb_opb_Sl_errAck(5),
      Sln_retry => mb_opb_Sl_retry(5),
      Sln_toutSup => mb_opb_Sl_toutSup(5),
      Sln_xferAck => mb_opb_Sl_xferAck(5),
      IP2INTC_Irpt => open,
      GPIO_in => net_gnd16,
      GPIO_d_out => sseg_GPIO_d_out(15 downto 0),
      GPIO_t_out => open,
      GPIO2_in => net_gnd16,
      GPIO2_d_out => open,
      GPIO2_t_out => open,
      GPIO_IO_I => net_gnd16,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd16,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  timer_0 : timer_0_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      TC_DBus => mb_opb_Sl_DBus(192 to 223),
      TC_errAck => mb_opb_Sl_errAck(6),
      TC_retry => mb_opb_Sl_retry(6),
      TC_toutSup => mb_opb_Sl_toutSup(6),
      TC_xferAck => mb_opb_Sl_xferAck(6),
      CaptureTrig0 => net_gnd0,
      CaptureTrig1 => net_gnd0,
      GenerateOut0 => open,
      GenerateOut1 => open,
      PWM0 => timer_0_PWM0,
      Interrupt => timer_0_Interrupt,
      Freeze => net_gnd0
    );

  timer_1 : timer_1_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      TC_DBus => mb_opb_Sl_DBus(224 to 255),
      TC_errAck => mb_opb_Sl_errAck(7),
      TC_retry => mb_opb_Sl_retry(7),
      TC_toutSup => mb_opb_Sl_toutSup(7),
      TC_xferAck => mb_opb_Sl_xferAck(7),
      CaptureTrig0 => net_gnd0,
      CaptureTrig1 => net_gnd0,
      GenerateOut0 => open,
      GenerateOut1 => open,
      PWM0 => timer_1_PWM0,
      Interrupt => timer_1_Interrupt,
      Freeze => net_gnd0
    );

  sseg_d : sseg_d_wrapper
    port map (
      data => sseg_GPIO_d_out,
      segs => sseg_d_segs,
      seg_en => sseg_d_seg_en,
      clk => sys_clk_s
    );

  opb_intc_0 : opb_intc_0_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      Intr => pgassign1,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      OPB_DBus => mb_opb_OPB_DBus,
      IntC_DBus => mb_opb_Sl_DBus(256 to 287),
      IntC_errAck => mb_opb_Sl_errAck(8),
      IntC_retry => mb_opb_Sl_retry(8),
      IntC_toutSup => mb_opb_Sl_toutSup(8),
      IntC_xferAck => mb_opb_Sl_xferAck(8),
      Irq => opb_intc_0_Irq
    );

  timer_2 : timer_2_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      TC_DBus => mb_opb_Sl_DBus(288 to 319),
      TC_errAck => mb_opb_Sl_errAck(9),
      TC_retry => mb_opb_Sl_retry(9),
      TC_toutSup => mb_opb_Sl_toutSup(9),
      TC_xferAck => mb_opb_Sl_xferAck(9),
      CaptureTrig0 => net_gnd0,
      CaptureTrig1 => net_gnd0,
      GenerateOut0 => open,
      GenerateOut1 => open,
      PWM0 => timer_2_PWM0,
      Interrupt => timer_2_Interrupt,
      Freeze => net_gnd0
    );

  timer_3 : timer_3_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      TC_DBus => mb_opb_Sl_DBus(320 to 351),
      TC_errAck => mb_opb_Sl_errAck(10),
      TC_retry => mb_opb_Sl_retry(10),
      TC_toutSup => mb_opb_Sl_toutSup(10),
      TC_xferAck => mb_opb_Sl_xferAck(10),
      CaptureTrig0 => net_gnd0,
      CaptureTrig1 => net_gnd0,
      GenerateOut0 => open,
      GenerateOut1 => open,
      PWM0 => open,
      Interrupt => timer_3_Interrupt,
      Freeze => net_gnd0
    );

  spi : spi_wrapper
    port map (
      SCK_I => net_gnd0,
      SCK_O => opb_spi_0_SCK_O,
      SCK_T => open,
      MISO_I => opb_spi_0_MISO_I,
      MISO_O => open,
      MISO_T => open,
      MOSI_I => net_gnd0,
      MOSI_O => open,
      MOSI_T => open,
      SPISEL => net_vcc0,
      SS_I => net_gnd1(0 to 0),
      SS_O => opb_spi_0_SS_O(0 to 0),
      SS_T => open,
      OPB_Rst => mb_opb_OPB_Rst,
      IP2INTC_Irpt => opb_spi_0_IP2INTC_Irpt,
      Freeze => net_gnd0,
      OPB_Clk => sys_clk_s,
      OPB_select => mb_opb_OPB_select,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      OPB_BE => mb_opb_OPB_BE,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_DBus => mb_opb_OPB_DBus,
      SPI_DBus => mb_opb_Sl_DBus(352 to 383),
      SPI_xferAck => mb_opb_Sl_xferAck(11),
      SPI_errAck => mb_opb_Sl_errAck(11),
      SPI_toutSup => mb_opb_Sl_toutSup(11),
      SPI_retry => mb_opb_Sl_retry(11)
    );

  lcd_fsl_0 : lcd_fsl_0_wrapper
    port map (
      FSL_Clk => sys_clk_s,
      FSL_Rst => fsl_v20_0_OPB_Rst,
      FSL_S_Clk => open,
      FSL_S_Read => fsl_v20_0_FSL_S_Read,
      FSL_S_Data => fsl_v20_0_FSL_S_Data,
      FSL_S_Control => fsl_v20_0_FSL_S_Control,
      FSL_S_Exists => fsl_v20_0_FSL_S_Exists,
      LCD_dio => lcd_fsl_0_LCD_dio,
      LCD_sck => lcd_fsl_0_LCD_sck,
      LCD_cs => lcd_fsl_0_LCD_cs
    );

  fsl_v20_0 : fsl_v20_0_wrapper
    port map (
      FSL_Clk => sys_clk_s,
      SYS_Rst => sys_rst_s,
      FSL_Rst => fsl_v20_0_OPB_Rst,
      FSL_M_Clk => net_gnd0,
      FSL_M_Data => fsl_v20_0_FSL_M_Data,
      FSL_M_Control => fsl_v20_0_FSL_M_Control,
      FSL_M_Write => fsl_v20_0_FSL_M_Write,
      FSL_M_Full => fsl_v20_0_FSL_M_Full,
      FSL_S_Clk => net_gnd0,
      FSL_S_Data => fsl_v20_0_FSL_S_Data,
      FSL_S_Control => fsl_v20_0_FSL_S_Control,
      FSL_S_Read => fsl_v20_0_FSL_S_Read,
      FSL_S_Exists => fsl_v20_0_FSL_S_Exists,
      FSL_Full => open,
      FSL_Has_Data => open,
      FSL_Control_IRQ => open
    );

  spi2 : spi2_wrapper
    port map (
      D => spi2_D,
      SCK => opb_spi_0_SCK_O,
      SS => opb_spi_0_SS_O(0 to 0),
      MISO => spi2_MISO
    );

  spi2_data : spi2_data_wrapper
    port map (
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_Clk => sys_clk_s,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      Sln_DBus => mb_opb_Sl_DBus(384 to 415),
      Sln_errAck => mb_opb_Sl_errAck(12),
      Sln_retry => mb_opb_Sl_retry(12),
      Sln_toutSup => mb_opb_Sl_toutSup(12),
      Sln_xferAck => mb_opb_Sl_xferAck(12),
      IP2INTC_Irpt => open,
      GPIO_in => net_gnd16,
      GPIO_d_out => open,
      GPIO_t_out => open,
      GPIO2_in => net_gnd16,
      GPIO2_d_out => open,
      GPIO2_t_out => open,
      GPIO_IO_I => spi2_D,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd16,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  gpio : gpio_wrapper
    port map (
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_Clk => sys_clk_s,
      OPB_DBus => mb_opb_OPB_DBus,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_Rst => mb_opb_OPB_Rst,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      Sln_DBus => mb_opb_Sl_DBus(416 to 447),
      Sln_errAck => mb_opb_Sl_errAck(13),
      Sln_retry => mb_opb_Sl_retry(13),
      Sln_toutSup => mb_opb_Sl_toutSup(13),
      Sln_xferAck => mb_opb_Sl_xferAck(13),
      IP2INTC_Irpt => open,
      GPIO_in => net_gnd32,
      GPIO_d_out => gpio_GPIO_d_out,
      GPIO_t_out => open,
      GPIO2_in => net_gnd32,
      GPIO2_d_out => open,
      GPIO2_t_out => open,
      GPIO_IO_I => net_gnd32,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd32,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  lcd_uart : lcd_uart_wrapper
    port map (
      OPB_Clk => sys_clk_s,
      OPB_Rst => mb_opb_OPB_Rst,
      Interrupt => open,
      OPB_ABus => mb_opb_OPB_ABus,
      OPB_BE => mb_opb_OPB_BE,
      OPB_RNW => mb_opb_OPB_RNW,
      OPB_select => mb_opb_OPB_select,
      OPB_seqAddr => mb_opb_OPB_seqAddr,
      OPB_DBus => mb_opb_OPB_DBus,
      UART_DBus => mb_opb_Sl_DBus(448 to 479),
      UART_errAck => mb_opb_Sl_errAck(14),
      UART_retry => mb_opb_Sl_retry(14),
      UART_toutSup => mb_opb_Sl_toutSup(14),
      UART_xferAck => mb_opb_Sl_xferAck(14),
      RX => lcd_uart_RX,
      TX => lcd_uart_TX
    );

  iobuf_0 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(0),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(0),
      O => fpga_0_Micron_RAM_Mem_DQ_I(0),
      T => fpga_0_Micron_RAM_Mem_DQ_T(0)
    );

  iobuf_1 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(1),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(1),
      O => fpga_0_Micron_RAM_Mem_DQ_I(1),
      T => fpga_0_Micron_RAM_Mem_DQ_T(1)
    );

  iobuf_2 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(2),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(2),
      O => fpga_0_Micron_RAM_Mem_DQ_I(2),
      T => fpga_0_Micron_RAM_Mem_DQ_T(2)
    );

  iobuf_3 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(3),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(3),
      O => fpga_0_Micron_RAM_Mem_DQ_I(3),
      T => fpga_0_Micron_RAM_Mem_DQ_T(3)
    );

  iobuf_4 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(4),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(4),
      O => fpga_0_Micron_RAM_Mem_DQ_I(4),
      T => fpga_0_Micron_RAM_Mem_DQ_T(4)
    );

  iobuf_5 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(5),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(5),
      O => fpga_0_Micron_RAM_Mem_DQ_I(5),
      T => fpga_0_Micron_RAM_Mem_DQ_T(5)
    );

  iobuf_6 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(6),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(6),
      O => fpga_0_Micron_RAM_Mem_DQ_I(6),
      T => fpga_0_Micron_RAM_Mem_DQ_T(6)
    );

  iobuf_7 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(7),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(7),
      O => fpga_0_Micron_RAM_Mem_DQ_I(7),
      T => fpga_0_Micron_RAM_Mem_DQ_T(7)
    );

  iobuf_8 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(8),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(8),
      O => fpga_0_Micron_RAM_Mem_DQ_I(8),
      T => fpga_0_Micron_RAM_Mem_DQ_T(8)
    );

  iobuf_9 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(9),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(9),
      O => fpga_0_Micron_RAM_Mem_DQ_I(9),
      T => fpga_0_Micron_RAM_Mem_DQ_T(9)
    );

  iobuf_10 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(10),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(10),
      O => fpga_0_Micron_RAM_Mem_DQ_I(10),
      T => fpga_0_Micron_RAM_Mem_DQ_T(10)
    );

  iobuf_11 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(11),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(11),
      O => fpga_0_Micron_RAM_Mem_DQ_I(11),
      T => fpga_0_Micron_RAM_Mem_DQ_T(11)
    );

  iobuf_12 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(12),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(12),
      O => fpga_0_Micron_RAM_Mem_DQ_I(12),
      T => fpga_0_Micron_RAM_Mem_DQ_T(12)
    );

  iobuf_13 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(13),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(13),
      O => fpga_0_Micron_RAM_Mem_DQ_I(13),
      T => fpga_0_Micron_RAM_Mem_DQ_T(13)
    );

  iobuf_14 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(14),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(14),
      O => fpga_0_Micron_RAM_Mem_DQ_I(14),
      T => fpga_0_Micron_RAM_Mem_DQ_T(14)
    );

  iobuf_15 : IOBUF
    port map (
      I => fpga_0_Micron_RAM_Mem_DQ_O(15),
      IO => fpga_0_Micron_RAM_Mem_DQ_pin(15),
      O => fpga_0_Micron_RAM_Mem_DQ_I(15),
      T => fpga_0_Micron_RAM_Mem_DQ_T(15)
    );

end architecture STRUCTURE;

