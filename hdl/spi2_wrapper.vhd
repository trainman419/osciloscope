-------------------------------------------------------------------------------
-- spi2_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library a2d_addon;
use a2d_addon.All;

entity spi2_wrapper is
  port (
    D : out std_logic_vector(0 to 15);
    SCK : in std_logic;
    SS : in std_logic_vector(0 to 0);
    MISO : in std_logic
  );
end spi2_wrapper;

architecture STRUCTURE of spi2_wrapper is

  component a2d_addon is
    port (
      D : out std_logic_vector(0 to 15);
      SCK : in std_logic;
      SS : in std_logic_vector(0 to 0);
      MISO : in std_logic
    );
  end component;

  attribute x_core_info : STRING;
  attribute x_core_info of a2d_addon : component is "a2d_addon_v";

begin

  spi2 : a2d_addon
    port map (
      D => D,
      SCK => SCK,
      SS => SS,
      MISO => MISO
    );

end architecture STRUCTURE;

