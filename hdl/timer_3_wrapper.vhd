-------------------------------------------------------------------------------
-- timer_3_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library opb_timer_v1_00_b;
use opb_timer_v1_00_b.All;

entity timer_3_wrapper is
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
end timer_3_wrapper;

architecture STRUCTURE of timer_3_wrapper is

  component opb_timer is
    generic (
      C_FAMILY : STRING;
      C_COUNT_WIDTH : INTEGER;
      C_ONE_TIMER_ONLY : INTEGER;
      C_TRIG0_ASSERT : std_logic;
      C_TRIG1_ASSERT : std_logic;
      C_GEN0_ASSERT : std_logic;
      C_GEN1_ASSERT : std_logic;
      C_OPB_AWIDTH : INTEGER;
      C_OPB_DWIDTH : INTEGER;
      C_BASEADDR : std_logic_vector;
      C_HIGHADDR : std_logic_vector
    );
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

  attribute x_core_info : STRING;
  attribute x_core_info of opb_timer : component is "opb_timer_v1_00_b";

begin

  timer_3 : opb_timer
    generic map (
      C_FAMILY => "spartan3e",
      C_COUNT_WIDTH => 32,
      C_ONE_TIMER_ONLY => 0,
      C_TRIG0_ASSERT => '1',
      C_TRIG1_ASSERT => '1',
      C_GEN0_ASSERT => '1',
      C_GEN1_ASSERT => '1',
      C_OPB_AWIDTH => 32,
      C_OPB_DWIDTH => 32,
      C_BASEADDR => X"40010000",
      C_HIGHADDR => X"400101FF"
    )
    port map (
      OPB_Clk => OPB_Clk,
      OPB_Rst => OPB_Rst,
      OPB_ABus => OPB_ABus,
      OPB_BE => OPB_BE,
      OPB_DBus => OPB_DBus,
      OPB_RNW => OPB_RNW,
      OPB_select => OPB_select,
      OPB_seqAddr => OPB_seqAddr,
      TC_DBus => TC_DBus,
      TC_errAck => TC_errAck,
      TC_retry => TC_retry,
      TC_toutSup => TC_toutSup,
      TC_xferAck => TC_xferAck,
      CaptureTrig0 => CaptureTrig0,
      CaptureTrig1 => CaptureTrig1,
      GenerateOut0 => GenerateOut0,
      GenerateOut1 => GenerateOut1,
      PWM0 => PWM0,
      Interrupt => Interrupt,
      Freeze => Freeze
    );

end architecture STRUCTURE;

