--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Alex Chen
  --
  --       LAB NAME:  lab 6 Calculator Add Subtract
  --
  --      FILE NAME:  top.vhd
  --
  -------------------------------------------------------------------------------
  --
  --  DESCRIPTION
  --    This file is a used for compiling file in Quartus so the ENTITY
  --    signals names match the DE1-SOC board pins file names.
  --
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
  LIBRARY work;
  USE work.clock_synchronizer_pkg.ALL;
  USE work.segment_decoder_pkg.ALL;
  USE work.FSM_pkg.ALL;
  ENTITY top IS
  PORT (
  CLOCK_50 : IN  std_logic;
  SW       : IN  std_logic_vector(9 DOWNTO 0);
  KEY      : IN  std_logic_vector(3 DOWNTO 0);
  --
  LEDR     : OUT std_logic_vector(8 DOWNTO 0);
  HEX0     : OUT std_logic_vector(6 DOWNTO 0);
  HEX1     : OUT std_logic_vector(6 DOWNTO 0);
  HEX2     : OUT std_logic_vector(6 DOWNTO 0)
  );
  END ENTITY top;
  ARCHITECTURE arch OF top IS
  BEGIN
  top_inst : calculator
  PORT MAP (
  CLK      => CLOCK_50,
  RESET => SW(0),
  pb_enable_c   => KEY(0),
  input1=> SW(8 downto 1),
  --
  LED  => LEDR(3 downto 0),
  ones_out=>HEX0,
  tens_out=>HEX1,
  hundreds_out=>HEX2
  );
  END ARCHITECTURE arch;
  