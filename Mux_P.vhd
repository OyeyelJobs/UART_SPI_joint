--MUX for the ADS7841 driver
library ieee;
use ieee.std_logic_1164.all;

entity Mux_P is
	port(
		S: in std_logic;
		Din: in std_logic_vector(11 downto 0);
		Dout: out std_logic_vector(7 downto 0)
	);
end Mux_P;

architecture Lambda of Mux_P is
begin 
	process(Din,S)
	begin
		
		case S is
			when '0' => Dout <= Din(11 downto 4);
			when others => Dout <= Din (3 downto 0)&"0000";  
		end case;
	end process;
end Lambda;
			