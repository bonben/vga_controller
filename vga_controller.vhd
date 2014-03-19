----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:52:15 02/14/2013 
-- Design Name: 
-- Module Name:   vga_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
-- Deliver numbers from 1 to 49
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_controller is
  
  port (
    clk100M : in  std_logic;                      -- 25 MHz clock
    reset   : in  std_logic;
    hs      : out std_logic;                      -- horizontal synch
    vs      : out std_logic;                      -- vertical synch
    red     : out std_logic_vector(2 downto 0);
    green   : out std_logic_vector(2 downto 0);
    blue    : out std_logic_vector(1 downto 0);
    row     : out std_logic_vector(8 downto 0);   -- pixel row
    column  : out std_logic_vector(9 downto 0));  -- pixel column
end entity vga_controller;




architecture RTL of vga_controller is

  signal hcounter         : unsigned(9 downto 0) := "0000000000";  -- horizontal counter
  signal vcounter         : unsigned(9 downto 0) := "0000000000";  -- vertical counter
  signal vcountenable     : std_logic            := '0';  -- vertical counter count enable
  signal vlastcountenable : std_logic            := '0';  -- vertical count enable last clock cycle
  signal hsdelay          : std_logic            := '0';  --artificail signal to sycnhronize h and v pulse
  signal hsdelay2         : std_logic            := '0';  --artificail signal to sycnhronize h and v pulse
  signal clk25M           : std_logic;

  component IP_clk
    port
      (
        CLK_IN1  : in  std_logic;
        CLK_OUT1 : out std_logic
        );
  end component;

begin  -- architecture RTL


  
  process (clk25M, reset) is
  begin  -- process
    if reset = '0' then                 -- asynchronous reset (active low)
      hs               <= '0';
      vs               <= '0';
      red              <= "000";
      green            <= "000";
      blue             <= "00";
      row              <= "000000000";
      column           <= "0000000000";
      hcounter         <= "0000000000";
      vcounter         <= "0000000000";
      vcountenable     <= '0';
      vlastcountenable <= '0';
      
    elsif clk25M'event and clk25M = '1' then  -- rising clock edge

      
      if hcounter < 799 then            -- compte 800 cycles d'horloges
        hcounter <= hcounter+1;
      else
        hcounter <= "0000000000";
      end if;

      if hcounter = 0 then
        hsdelay      <= '0';
        vcountenable <= '1';
      end if;
      if hcounter = 96 then
        hsdelay      <= '1';
        vcountenable <= '0';
      end if;
      hsdelay2 <= hsdelay;
      hs       <= hsdelay2;

      vlastcountenable <= vcountenable;

      if vlastcountenable = '0' and vcountenable = '1' then
        if vcounter < 520 then          --compte 521
          vcounter <= vcounter + 1;
        else
          vcounter <= "0000000000";
        end if;
      end if;

      if vcounter = 0 then
        vs <= '0';
      end if;
      if vcounter = 2 then
        vs <= '1';
      end if;

      if (hcounter mod 60) < 20 then
        green <= "000";
        blue  <= "11";
        red   <= "000";
      elsif (hcounter mod 60) < 40 then
        green <= "111";
        blue  <= "00";
        red   <= "000";
      else
        green <= "000";
        blue  <= "00";
        red   <= "111";
      end if;
    end if;
  end process;

  Clock_manager : IP_clk
    port map
    (
      CLK_IN1  => clk100M,
      CLK_OUT1 => clk25M);

end architecture RTL;



