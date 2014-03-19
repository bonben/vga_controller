----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:52:15 02/14/2013 
-- Design Name: 
-- Module Name:    compteur_49 - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_49 is
    Port ( counting : in  STD_LOGIC; -- the counter counts only when counting bit is 1
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (5 downto 0));-- the output number
end counter_49;

architecture Behavioral of counter_49 is

signal internal_count : UNSIGNED (5 downto 0);

begin


	PROCESS (clock, reset)
		BEGIN
			IF reset='0' THEN  -- asynchronous reset (active low)
				internal_count <= "000001";-- initialization to one
			ELSIF clock'EVENT AND clock = '1' THEN-- rising clock edge
				
				IF counting = '0' THEN
					internal_count <= internal_count;
				ELSE
					IF internal_count >= 49 THEN
					internal_count <= "000001"; --revient à un 
					ELSE
					internal_count <= internal_count + 1;
					END IF;
				END IF;
					
			END IF;
		
	END PROCESS;
count <= STD_LOGIC_VECTOR (internal_count);


end Behavioral;

