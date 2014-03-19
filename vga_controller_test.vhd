--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:14:51 03/17/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/newVGA/vga_controller_test.vhd
-- Project Name:  newVGA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: vga_controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity vga_controller_test is
end vga_controller_test;

architecture behavior of vga_controller_test is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component vga_controller
    port(
      clk100M    : in  std_logic;
      reset  : in  std_logic;
      hs     : out std_logic;
      vs     : out std_logic;
      red    : out std_logic_vector(2 downto 0);
      green  : out std_logic_vector(2 downto 0);
      blue   : out std_logic_vector(1 downto 0);
      row    : out std_logic_vector(8 downto 0);
      column : out std_logic_vector(9 downto 0)
      );
  end component;


  --Inputs
  signal clk100M   : std_logic := '0';
  signal reset : std_logic := '0';

  --Outputs
  signal hs     : std_logic;
  signal vs     : std_logic;
  signal red    : std_logic_vector(2 downto 0);
  signal green  : std_logic_vector(2 downto 0);
  signal blue   : std_logic_vector(1 downto 0);
  signal row    : std_logic_vector(8 downto 0);
  signal column : std_logic_vector(9 downto 0);

  -- Clock period definitions
  constant clk100M_period : time := 10 ns;
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : vga_controller port map (
    clk100M    => clk100M,
    reset  => reset,
    hs     => hs,
    vs     => vs,
    red    => red,
    green  => green,
    blue   => blue,
    row    => row,
    column => column
    );

  -- Clock process definitions
  clk100M_process : process
  begin
    clk100M <= '0';
    wait for clk100M_period/2;
    clk100M <= '1';
    wait for clk100M_period/2;
  end process;


  -- Stimulus process
  stim_proc : process
  begin
    reset <= '0';
    wait for 100 ns;
    reset <= '1';
    wait for clk100M_period*10;

    -- insert stimulus here 

    wait;
  end process;

end;
