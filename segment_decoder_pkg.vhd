--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  segment_decoder_pkg.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--            This design will declare the segment decoder package.
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 10/13/20 | xxx  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
PACKAGE segment_decoder_pkg IS
COMPONENT rising_edge_synchronizer is
port (
clk               : in std_logic;
reset             : in std_logic;
input             : in std_logic;
edge              : out std_logic
);
end COMPONENT;
COMPONENT segment_decoder IS
PORT (
input1,input2,input3: IN  std_logic_vector(3 downto 0) ;
-- add any inputs here
--
-- add any outputs here
output1,output2,output3 : out std_logic_vector(6 downto 0)
);
end component;
component display_mux IS
PORT (
clk: in std_logic;
reset_n: in std_logic;
a_syn, b_syn : in std_logic_vector(7 downto 0);
sum_result,diff_result : in std_logic_vector(8 downto 0);
a_reg_enable, b_reg_enable, sum_enable,diff_enable    : IN  std_logic;
-- add any inputs here
--
-- add any outputs here
output  : out  std_logic_vector( 11 downto 0)
);
END component ;
component from_12_to_4 IS
PORT
(
clk : IN std_logic;
result_padded : IN std_logic_vector(11 downto 0);
reset: in std_logic;
--
ones,tens,hundreds  : OUT std_logic_vector(3 downto 0)
);
END component;
component calculator IS
PORT
(
CLK : IN std_logic;
pb_enable_c : in std_logic;
input1: in std_logic_vector(7 downto 0);
RESET: in std_logic;
--
LED : out std_Logic_vector(3 downto 0);
ones_out,tens_out,hundreds_out: OUT std_logic_vector(6 downto 0)
);
END component ;
component input_a_state IS
PORT (
a_button: in std_logic;
clk : in std_logic;
reset: in std_logic;
input    : IN  std_logic_vector(7 downto 0) ;
-- add any inputs here
--
-- add any outputs here
output : out std_logic_vector(7 downto 0)
);
END component  ;
component input_b_state IS
PORT (
b_button: in std_logic;
clk : in std_logic;
reset: in std_logic;
input    : IN  std_logic_vector(7 downto 0) ;
-- add any inputs here
--
-- add any outputs here
output : out std_logic_vector(7 downto 0)
);
END component ;
component disp_sum IS
PORT (
disp_button: in std_logic;
clk : in std_logic;
reset: in std_logic;
a,b  : IN  std_logic_vector(7 downto 0) ;
-- add any inputs here
--
-- add any outputs here
sum : out std_logic_vector(8 downto 0)
);
END component ;
component disp_diff IS
PORT (
return_button: in std_logic;
clk : in std_logic;
reset: in std_logic;
a,b  : IN  std_logic_vector(7 downto 0) ;
-- add any inputs here
--
-- add any outputs here
sum : out std_logic_vector(8 downto 0)
);
END component ;
constant ZERO : std_logic_vector(6 downto 0) :=  "1000000";
constant ONE  : std_logic_vector(6 downto 0) :=  "1111001";
constant TWO  : std_logic_vector(6 downto 0) :=  "0100100";
constant THREE : std_logic_vector(6 downto 0) :=  "0110000";
constant FOUR : std_logic_vector(6 downto 0) :=  "0011001";
constant FIVE : std_logic_vector(6 downto 0) :=  "0010010";
constant SIX  : std_logic_vector(6 downto 0) :=  "0000010";
constant SEVEN : std_logic_vector(6 downto 0) :=  "1111000";
constant EIGHT : std_logic_vector(6 downto 0) :=  "0000000";
constant NINE : std_logic_vector(6 downto 0) :=  "0010000";
constant A : std_logic_vector(6 downto 0) :=  "0001000";
constant B : std_logic_vector(6 downto 0) :=  "0000011";
constant C : std_logic_vector(6 downto 0) :=  "1000110";
constant D : std_logic_vector(6 downto 0) :=  "0100001";
constant E : std_logic_vector(6 downto 0) :=  "0000110";
constant F : std_logic_vector(6 downto 0) :=  "0001110";
constant blank : std_logic_vector(6 downto 0) :=  "1111111";
constant high_c : std_logic :=  '1';
END PACKAGE segment_decoder_pkg;
