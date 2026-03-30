library ieee;
use ieee.std_logic_1164.all;

entity Mux is
	port(
		ByteTX: in std_logic_vector(7 downto 0);
		Opc: in std_logic_vector(2 downto 0);
		MOSI: out std_logic
	);				   
end Mux;

architecture Meleboj of Mux is
begin
	process(Opc,ByteTX)
	begin
		case Opc is
			when "000" => MOSI <= ByteTX(7);
			when "001" => MOSI <= ByteTX(6);
			when "010" => MOSI <= ByteTX(5);
			when "011" => MOSI <= ByteTX(4);
			when "100" => MOSI <= ByteTX(3);
			when "101" => MOSI <= ByteTX(2);
			when "110" => MOSI <= ByteTX(1);
			when OTHERS => MOSI <= ByteTX(0);

		end case;
	end process;
end Meleboj;