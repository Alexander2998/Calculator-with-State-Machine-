--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  segment_decoder.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will create the seven segment display component. 
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

ENTITY segment_decoder IS


  PORT (
  input1,input2,input3: IN  std_logic_vector(3 downto 0) ;
	
    -- add any inputs here
    --
    -- add any outputs here
	output1,output2,output3 : out std_logic_vector(6 downto 0)
    );
END ENTITY segment_decoder ;

ARCHITECTURE behave OF segment_decoder  IS

    ---------------------------------------------------------------------------
    -- define your signals here
    -- format: signal abc : <type>;
    ---------------------------------------------------------------------------
	
BEGIN
process(input1) 
	begin 
		case input1 is 
		when "0000" => output1<=ZERO; 
		when "0001" => output1<=ONE; 
		when "0010" => output1<=TWO; 
		when "0011" => output1<=THREE; 
		when "0100" => output1<=FOUR; 
		when "0101" => output1<=FIVE; 
		when "0110" => output1<=SIX; 
		when "0111" => output1<=SEVEN; 
		when "1000" => output1<=EIGHT; 
		when "1001" => output1<=NINE; 
		WHEN "1010" => output1<=A; 
		WHEN "1011" => output1<=B;
		WHEN "1100" => output1<=C;
		WHEN "1101" => output1<=D; 
		WHEN "1110" => output1<=E; 
		WHEN "1111" => output1<=F;		
		when others => output1<="1111111"; 
	end case; 
end process; 

process(input2) 
	begin 
		case input2 is 
		when "0000" => output2<=ZERO; 
		when "0001" => output2<=ONE; 
		when "0010" => output2<=TWO; 
		when "0011" => output2<=THREE; 
		when "0100" => output2<=FOUR; 
		when "0101" => output2<=FIVE; 
		when "0110" => output2<=SIX; 
		when "0111" => output2<=SEVEN; 
		when "1000" => output2<=EIGHT; 
		when "1001" => output2<=NINE; 
		WHEN "1010" => output2<=A; 
		WHEN "1011" => output2<=B;
		WHEN "1100" => output2<=C;
		WHEN "1101" => output2<=D; 
		WHEN "1110" => output2<=E; 
		WHEN "1111" => output2<=F;		
		when others => output2<="1111111"; 
	end case; 
end process; 

process(input3) 
	begin 
		case input3 is 
		when "0000" => output3<=ZERO; 
		when "0001" => output3<=ONE; 
		when "0010" => output3<=TWO; 
		when "0011" => output3<=THREE; 
		when "0100" => output3<=FOUR; 
		when "0101" => output3<=FIVE; 
		when "0110" => output3<=SIX; 
		when "0111" => output3<=SEVEN; 
		when "1000" => output3<=EIGHT; 
		when "1001" => output3<=NINE; 
		WHEN "1010" => output3<=A; 
		WHEN "1011" => output3<=B;
		WHEN "1100" => output3<=C;
		WHEN "1101" => output3<=D; 
		WHEN "1110" => output3<=E; 
		WHEN "1111" => output3<=F;		
		when others => output3<="1111111"; 
	end case; 
end process; 
    ---------------------------------------------------------------------------
    -- define your equations/design here
    ---------------------------------------------------------------------------

END ARCHITECTURE behave;
