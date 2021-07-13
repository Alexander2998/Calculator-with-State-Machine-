--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  disp_sum.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will declare the sum display component.
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
use ieee.numeric_std.all;
use work.segment_decoder_pkg.all;
ENTITY disp_sum IS
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
END ENTITY disp_sum ;
ARCHITECTURE behave OF disp_sum  IS
---------------------------------------------------------------------------
-- define your signals here
-- format: signal abc : <type>;
  ---------------------------------------------------------------------------
  signal button :  std_logic ;
  signal sum_temp   : std_logic_vector(8 downto 0):= (others => '0');
  signal cin_guard  : std_logic_vector(7 downto 0) := (others => '0');
  begin
  button<=disp_button; process(clk, reset)
                 begin
                 if(reset='1'
                 ) then
                 sum<= (others=>'0');
      elsif(rising_edge(clk)) then
      sum_temp  <= std_logic_vector(unsigned('0'
         & a) + unsigned('0'
         & b) + unsigned(cin_guard ));
         end if;
         sum <= sum_temp(8 downto 0);
           end process;
           ---------------------------------------------------------------------------
           -- define your equations/design here
           ---------------------------------------------------------------------------
           END ARCHITECTURE behave;
           