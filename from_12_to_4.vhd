--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  from_12_to_4.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will create the 12 to 4 bit component 
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
ENTITY from_12_to_4 IS
PORT
(
clk : IN std_logic;
result_padded : IN std_logic_vector(11 downto 0);
reset: in std_logic;
--
ones,tens,hundreds  : OUT std_logic_vector(3 downto 0)
);
END ENTITY from_12_to_4;
ARCHITECTURE behave OF from_12_to_4 IS
BEGIN
bcd1: process(clk,reset)
-- temporary variable
variable temp : STD_LOGIC_VECTOR (11 downto 0);
-- variable to store the output BCD number
-- organized as follows
-- thousands = bcd(15 downto 12)
-- hundreds = bcd(11 downto 8)
-- tens = bcd(7 downto 4)
-- units = bcd(3 downto 0)
variable bcd : UNSIGNED (15 downto 0) := (others => '0');
-- by
-- https://en.wikipedia.org/wiki/Double_dabble
begin
if(reset='1') then --output is 0
ones<=(others =>'0');
  tens<=(others =>'0');
    hundreds<=(others =>'0');
      elsIF (rising_edge(clk)) THEN
      -- zero the bcd variable
      bcd := (others => '0');
      -- read input into temp variable
      temp(11 downto 0) := result_padded;
      -- cycle 12 times as we have 12 input bits
      -- this could be optimized, we dont need to check and add 3 for the
      -- first 3 iterations as the number can never be >4
      for i in 0 to 11 loop
      if bcd(3 downto 0) > 4 then
      bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      if bcd(7 downto 4) > 4 then
      bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
      if bcd(11 downto 8) > 4 then
      bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;
      -- thousands can't be >4 for a 12-bit input number
      -- so don't need to do anything to upper 4 bits of bcd
      -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
      bcd := bcd(14 downto 0) & temp(11);
      -- shift temp left by 1 bit
      temp := temp(10 downto 0) & '0';
      end loop;
      end if;
      -- set outputs
      ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
         tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
           hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
             --thousands <= STD_LOGIC_VECTOR(bcd(15 downto 12));
               end process bcd1;
               END ARCHITECTURE behave;
               