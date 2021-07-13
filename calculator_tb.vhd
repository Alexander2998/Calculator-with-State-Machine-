--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  calculator_tb.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will make a testbench for calculator. 
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

-- include ieee packages here
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all; 

-- include your packages here
LIBRARY work;
use work.FSM_pkg.ALL;
USE work.segment_decoder_pkg.ALL;


ENTITY calculator_tb IS

END ENTITY calculator_tb;

-------------------------------------------------------------------------------

ARCHITECTURE test OF calculator_tb IS

    ---------------------------------------------------------------------------
    -- define sigals that you will need to test UUT
    ---------------------------------------------------------------------------
	signal clk_tb,reset_tb : std_logic := '0'; 
  signal pb_enable_c_tb : std_logic  ; --activate on active low 
	signal input1_tb : std_logic_vector(7 downto 0) ; 
  signal ones_out_tb,tens_out_tb,hundreds_out_tb: std_logic_vector(6 downto 0) := (others =>'0'); 
  signal LED_tb : std_logic_vector(3 downto 0) := (others => '0'); 
  
  constant PERIOD_c: time := 20 ns; 
  constant TCO_c: time := 1 ns; 
	signal sim_done : boolean := false; 
    -- <define your signals here> 
    
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
 
BEGIN  -- test


    ---------------------------------------------------------------------------
    -- instantiate the unit under test (UUT)
    ---------------------------------------------------------------------------
    UUT : calculator
    PORT MAP (
  
     CLK =>clk_tb, 
     pb_enable_c =>pb_enable_c_tb,
     input1=>input1_tb,
     
     RESET=> reset_tb, 
     --
     LED=>LED_tb,
     ones_out=>ones_out_tb,
     tens_out=>tens_out_tb,
     hundreds_out=>hundreds_out_tb
        
     );

    clk_tb<= not clk_tb after PERIOD_c/2 WHEN (NOT sim_done) else '0';
    
    ---------------------------------------------------------------------------
    -- the process will apply the test vectors to the UUT
    ---------------------------------------------------------------------------
    stimulus : PROCESS
    
    procedure Cycle_Pushbutton is 
      constant PB_CLOCK_ACTIVE_c : integer:=1; 
      constant PB_CLOCK_DEACTIVE_c : integer:=3; 
     begin 
     --activate pushbutton 
      pb_enable_c_tb<= '0' after TCO_c; 
      wait for PB_CLOCK_ACTIVE_c * PERIOD_c; 
     --deactivate pushbutton
      pb_enable_c_tb<= '1' after TCO_c; 
      wait for PB_CLOCK_DEACTIVE_c * PERIOD_c; 
      wait until (clk_tb ='1'); 
    end procedure Cycle_Pushbutton; 
      
    BEGIN  -- PROCESS stimulus
    
    input1_tb<= (others=> '0'); 
    reset_tb<= '1'; 
    wait for PERIOD_c; 
    
    reset_tb<= '0'; 
    wait for 5*PERIOD_c; 
		
		wait until rising_edge(clk_tb); 

        -- INSERT YOUR TEST VECTORS HERE
    --for k in 0 to 3 loop
      
          for i in 0 to ((2 ** input1_tb'length) - 1)  loop
            input1_tb <= std_logic_vector(to_unsigned(i, input1_tb'length)) after TCO_c;
            Cycle_Pushbutton; 
            
            for j in 0 to ((2 ** input1_tb'length) - 1)  loop
            input1_tb <= std_logic_vector(to_unsigned(j, input1_tb'length)) after TCO_c ;
            Cycle_Pushbutton; 
            
            input1_tb<= (others=>'0') after TCO_c; 
            Cycle_Pushbutton; 
            
            input1_tb<= (others=>'0') after TCO_c; 
            Cycle_Pushbutton; 
            
            input1_tb <= std_logic_vector(to_unsigned(i, input1_tb'length)) after TCO_c; 
            Cycle_Pushbutton; 
           

        end loop;
      end loop;
    --end loop; 
	
		sim_done<=true; 
        -----------------------------------------------------------------------
        -- stop simulation, wait here forever
        -----------------------------------------------------------------------
        wait;
    END PROCESS stimulus;

END ARCHITECTURE test;

-------------------------------------------------------------------------------
