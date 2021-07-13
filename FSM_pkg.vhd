--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Alex Chen
--
--       LAB NAME:  lab 6 Calculator Add Subtract
--
--      FILE NAME:  FSM_pkg.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will declare the finite state machine component.
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
------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||                                                                   ||||
-- ||||                    COMPONENT PACKAGE                              ||||
-- ||||                                                                   ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
PACKAGE FSM_pkg IS
COMPONENT FSM IS
PORT (
clock    : IN  std_logic;
reset_n  : IN  std_logic;
pb_enable : in std_logic ;
-- add any inputs here
--
-- add any outputs here
a_button,b_button,disp_button,return_button: out std_logic
);
END COMPONENT;
END PACKAGE FSM_pkg;
------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||
-- |||| COMPONENT DESCRIPTION
-- ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY FSM  IS
PORT (
clock    : IN  std_logic;
reset_n  : IN  std_logic;
pb_enable : in std_logic ;
-- add any inputs here
--
-- add any outputs here
a_button,b_button,disp_button,return_button: out std_logic
);
END ENTITY FSM ;
ARCHITECTURE behave OF FSM  IS
type finite_state_machine is (input_a, input_b, disp_sum, disp_diff);
signal present_state: finite_state_machine;
signal next_state: finite_state_machine;
signal pb: std_logic ;
---------------------------------------------------------------------------
-- define the encoding of the state machine
-- format: signal abc : <type>;
  ---------------------------------------------------------------------------
  --attribute syn_coding : string;
  --attribute syn_coding of finite_state_machine: type is "sequential, Safe";
  ---------------------------------------------------------------------------
  BEGIN
  --update the states
  lower: process(reset_n,clock)
  begin
  if(reset_n='1') then --reset is active high
  present_state<=input_a; elsif(rising_edge(clock)) then
             present_state<= next_state;
       end if;
       end process;
       comb: process(pb_enable, present_state)
       begin
       case present_state is
       when input_a=>
      if(pb_enable ='1') then
      next_state<=input_b; else
                 next_state<=input_a; end if;
                   when input_b=>
          if(pb_enable ='1') then
          next_state<=disp_sum; else
                      next_state<=input_b; end if;
                       when disp_sum=>
              if(pb_enable ='1') then
              next_state<=disp_diff; else
                           next_state<=disp_sum; end if;
                            when disp_diff=>
                  if(pb_enable ='1') then
                  next_state<=input_a; else
                             next_state<=disp_diff; end if;
                                 end case;
                                 end process;
                                 outputs: process(present_state)
                                 begin
                                 case (present_state) is
                                 when input_a=> a_button<='1' ; b_button <='0' ; disp_button<='0' ; return_button<='0'; when input_b=> b_button<='1' ; a_button <='0' ; disp_button<='0' ; return_button<='0'; when disp_sum=> disp_button<='1' ; a_button <='0' ; b_button<='0' ; return_button<='0'; when disp_diff=> return_button<='1' ; a_button <='0' ; b_button<='0' ; disp_button<='0' ;
                                                          end case;
                                                          end process;
                                                          ---------------------------------------------------------------------------
                                                          -- define your equations/design here
                                                          ---------------------------------------------------------------------------
                                                          END ARCHITECTURE behave;
                                                          