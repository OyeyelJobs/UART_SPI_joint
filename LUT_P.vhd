library ieee;
use ieee.std_logic_1164.all;

entity LUT_P is
	port(
		RX: in std_logic_vector(7 downto 0);
		Op: out std_logic_vector (1 downto 0)
	); 
end LUT_P;

architecture Yaa of LUT_P is
begin
process(RX)
begin
	case RX is
		when "01000001" => Op <= "00";
		when "01000010" => Op <= "01";
		when "01000011" => Op <= "10";
		when "01000100" => Op <= "11";
		when others => Op <= "00";
	end case;
	end process;
end Yaa;