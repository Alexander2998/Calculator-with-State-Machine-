--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  input_b_state.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will declare the state that contains the second input.
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
use work.segment_decoder_pkg.all;
ENTITY input_b_state IS
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
END ENTITY input_b_state ;
ARCHITECTURE behave OF input_b_state  IS
---------------------------------------------------------------------------
-- define your signals here
-- format: signal abc : <type>;
  ---------------------------------------------------------------------------
  signal button :  std_logic ;
  BEGIN
  process(clk, reset)
  begin
  if(reset='1') then --output is 0
  output<=(others =>'0');
    elsIF (rising_edge(clk)) THEn
    if(b_button='1') then
    output<= input;
       end if;
       end if;
       end process;
       ---------------------------------------------------------------------------
       -- define your equations/design here
       ---------------------------------------------------------------------------
       END ARCHITECTURE behave;
       