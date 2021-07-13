--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  display_mux.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will declare the display mux component.
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
------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||
-- |||| COMPONENT DESCRIPTION
-- ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
ENTITY display_mux IS
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
END ENTITY display_mux ;
ARCHITECTURE behave OF display_mux  IS
---------------------------------------------------------------------------
-- define your signals here
-- format: signal abc : <type>;
  ---------------------------------------------------------------------------
  BEGIN
  process(clk,reset_n)
  begin
  IF (reset_n = '1') THEN
  output <= (OTHERS => '0');
    elsIF (rising_edge(clk)) THEN
    if(a_reg_enable ='1' ) then
    output<="0000" & a_syn;
             elsif(b_reg_enable='1'
             ) then
             output<="0000" & b_syn;
               elsif(sum_enable='1'
               ) then
               output<="000" & sum_result;
                elsif(diff_enable='1'
                ) then
                output<="000" & diff_result;
                  end if;
                  end if;
                  end process;
                  ---------------------------------------------------------------------------
                  -- define your equations/design here
                  ---------------------------------------------------------------------------
                  END ARCHITECTURE behave;
                  