-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
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
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
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
  end component;

begin

  system_i : system
    port map (
      fpga_0_RS232_PORT_RX_pin => fpga_0_RS232_PORT_RX_pin,
      fpga_0_RS232_PORT_TX_pin => fpga_0_RS232_PORT_TX_pin,
      fpga_0_LEDs_8Bit_GPIO_d_out_pin => fpga_0_LEDs_8Bit_GPIO_d_out_pin,
      fpga_0_Push_Buttons_3Bit_GPIO_in_pin => fpga_0_Push_Buttons_3Bit_GPIO_in_pin,
      fpga_0_Switches_8Bit_GPIO_in_pin => fpga_0_Switches_8Bit_GPIO_in_pin,
      fpga_0_Micron_RAM_Mem_A_pin => fpga_0_Micron_RAM_Mem_A_pin,
      fpga_0_Micron_RAM_Mem_DQ_pin => fpga_0_Micron_RAM_Mem_DQ_pin,
      fpga_0_Micron_RAM_Mem_OEN_pin => fpga_0_Micron_RAM_Mem_OEN_pin,
      fpga_0_Micron_RAM_Mem_WEN_pin => fpga_0_Micron_RAM_Mem_WEN_pin,
      fpga_0_Micron_RAM_Mem_BEN_pin => fpga_0_Micron_RAM_Mem_BEN_pin,
      fpga_0_net_gnd_pin => fpga_0_net_gnd_pin,
      fpga_0_net_gnd_1_pin => fpga_0_net_gnd_1_pin,
      fpga_0_net_gnd_2_pin => fpga_0_net_gnd_2_pin,
      sys_clk_pin => sys_clk_pin,
      sys_rst_pin => sys_rst_pin,
      segs => segs,
      seg_en => seg_en,
      timer_0_PWM0_pin => timer_0_PWM0_pin,
      timer_1_PWM0_pin => timer_1_PWM0_pin,
      sck => sck,
      miso => miso,
      ss => ss(0 to 0),
      timer_2_PWM0_pin => timer_2_PWM0_pin,
      LCD_sck => LCD_sck,
      LCD_dio => LCD_dio,
      LCD_cs => LCD_cs,
      spi2_MISO_pin => spi2_MISO_pin,
      gpio_out => gpio_out,
      lcd_uart_RX_pin => lcd_uart_RX_pin,
      lcd_uart_TX_pin => lcd_uart_TX_pin
    );

end architecture STRUCTURE;

