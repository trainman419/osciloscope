-------------------------------------------------------------------------------
-- lcd_fsl_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library lcd_fsl_v1_00_a;
use lcd_fsl_v1_00_a.All;

entity lcd_fsl_0_wrapper is
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
end lcd_fsl_0_wrapper;

architecture STRUCTURE of lcd_fsl_0_wrapper is

  component lcd_fsl is
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

  attribute x_core_info : STRING;
  attribute x_core_info of lcd_fsl : component is "lcd_fsl_v1_00_a";

begin

  lcd_fsl_0 : lcd_fsl
    port map (
      FSL_Clk => FSL_Clk,
      FSL_Rst => FSL_Rst,
      FSL_S_Clk => FSL_S_Clk,
      FSL_S_Read => FSL_S_Read,
      FSL_S_Data => FSL_S_Data,
      FSL_S_Control => FSL_S_Control,
      FSL_S_Exists => FSL_S_Exists,
      LCD_dio => LCD_dio,
      LCD_sck => LCD_sck,
      LCD_cs => LCD_cs
    );

end architecture STRUCTURE;

