-------------------------------------------------------------------------------
-- sseg_d_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library sseg;
use sseg.All;

entity sseg_d_wrapper is
  port (
    data : in std_logic_vector(15 downto 0);
    segs : out std_logic_vector(7 downto 0);
    seg_en : out std_logic_vector(3 downto 0);
    clk : in std_logic
  );
end sseg_d_wrapper;

architecture STRUCTURE of sseg_d_wrapper is

  component sseg is
    port (
      data : in std_logic_vector(15 downto 0);
      segs : out std_logic_vector(7 downto 0);
      seg_en : out std_logic_vector(3 downto 0);
      clk : in std_logic
    );
  end component;

  attribute x_core_info : STRING;
  attribute x_core_info of sseg : component is "sseg_v";

begin

  sseg_d : sseg
    port map (
      data => data,
      segs => segs,
      seg_en => seg_en,
      clk => clk
    );

end architecture STRUCTURE;

