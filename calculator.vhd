--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  calculator.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will instantiate the calculator.
--
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 10/13/20 | XXX  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
library work;
use work.clock_synchronizer_pkg.all;
use work.FSM_pkg.all;
use work.segment_decoder_pkg.all;
ENTITY calculator IS
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
END ENTITY calculator;
ARCHITECTURE behave OF calculator IS
-------------------------------------------------------------------------------
--Component declarations
-------------------------------------------------------------------------------
component from_12_to_4 IS
PORT
(
clk : IN std_logic;
result_padded : IN std_logic_vector(11 downto 0);
reset: in std_logic;
--
ones,tens,hundreds  : OUT std_logic_vector(3 downto 0)
);
END component ;
COMPONENT clock_synchronizer IS
GENERIC (
bit_width : integer := 8
);
PORT (
clk      : IN  std_logic;
reset    : IN  std_logic;
async_in : IN  std_logic_vector(bit_width-1 DOWNTO 0);
sync_out : OUT std_logic_vector(bit_width-1 DOWNTO 0)
);
END COMPONENT ;
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
-------------------------------------------------------------------------------
--End component declarations
-------------------------------------------------------------------------------
signal input_syn: std_Logic_vector( 7 downto 0);
signal add_sub : std_logic_vector( 0 downto 0);
signal add_sub_syn : std_logic_vector( 1 downto 0);
signal temp : std_logic_vector( 0 downto 0) := (others=> '0');
signal fsm_enable : std_logic;
signal button1,button2,button3,button4: std_logic ;
signal eight_bit_a,eight_bit_b : std_Logic_vector(7 downto 0);
signal eight_bit_sum, eight_bit_diff : std_Logic_vector(8 downto 0);
signal display_number: std_Logic_vector(11 downto 0);
signal ONES, TENS,HUNDREDS: std_Logic_vector( 3 downto 0):=(others =>'0');
BEGIN
-------------------------------------------------------------------------------
--Instantiate the components
-------------------------------------------------------------------------------
temp(0) <= not pb_enable_c; LED<= button1 & button2 & button3 & button4; 
    clock1: clock_synchronizer GENERIC map (bit_width  => 8
    )
    PORT map(
    clk => CLK,
    reset  =>RESET,
    async_in =>input1,
    sync_out => input_syn
    );
    clock2: clock_synchronizer
    GENERIC map (
    bit_width  => 1
    )
    PORT map(
    clk => CLK,
    reset  =>RESET,
    async_in => temp ,
    sync_out => add_sub
    );
    edge_syn: rising_edge_synchronizer
    PORT map(
    clk   =>CLK,
    reset=> RESET,
    input => add_sub(0),
    edge => fsm_enable
    );
    fsm_1: FSM
    PORT map(
    clock  =>CLK,
    reset_n =>RESET,
    pb_enable=> fsm_enable,
    -- add any inputs here
    --
    -- add any outputs here
    a_button=>button1,
    b_button=>button2,
    disp_button=>button3,
    return_button =>button4
    );
    state1: input_a_state
    PORT map (
    a_button =>button1,
    clk =>CLK,
    reset =>RESET,
    input => input_syn,
    -- add any inputs here
    --
    -- add any outputs here
    output =>eight_bit_a
    );
    state2: input_b_state
    PORT map(
    b_button =>button2,
    clk=> CLK,
    reset =>RESET,
    input=>input_syn,
    -- add any inputs here
    --
    -- add any outputs here
    output => eight_bit_b
    );
    state3: disp_sum
    PORT map (
    disp_button=> button3,
    clk =>CLK,
    reset =>RESET,
    a=>eight_bit_a,
    b =>eight_bit_b,
    -- add any inputs here
    --
    -- add any outputs here
    sum =>eight_bit_sum
    );
    state4: disp_diff
    PORT map (
    return_button=> button4,
    clk =>CLK,
    reset =>RESET,
    a=>eight_bit_a,
    b =>eight_bit_b,
    -- add any inputs here
    --
    -- add any outputs here
    sum =>eight_bit_diff
    );
    choose_display: display_mux
    port map (
    clk=> CLK,
    a_syn=>eight_bit_a,
    b_syn=>eight_bit_b,
    reset_n=> RESET,
    sum_result=>eight_bit_sum,
    diff_result=>eight_bit_diff,
    a_reg_enable=>button1,
    b_reg_enable=>button2,
    sum_enable=>button3,
    diff_enable=>button4,
    -- add any inputs here
    --
    -- add any outputs here
    output=> display_number
    );
    twelvetofour_4:  from_12_to_4
    PORT map
    (
    clk =>CLK,
    result_padded =>display_number,
    reset =>RESET,
    --
    ones=>ONES,
    tens=>TENS,
    hundreds=>HUNDREDS
    );
    diff_decoder: segment_decoder
    PORT map (
    input1=>ONES,
    input2=>TENS,
    input3=>HUNDREDS,
    -- add any inputs here
    --
    -- add any outputs here
    output1=>ones_out,
    output2=>tens_out,
    output3=>hundreds_out
    );
    END ARCHITECTURE behave;
    