library ieee;
use ieee.std_logic_1164.all;

entity Mux_UART is
	port(
		S: in std_logic_vector(3 downto 0);
		D: in std_logic_vector(7 downto 0);
		TXD: out std_logic
	);
end Mux_UART;

architecture Lambda of Mux_UART is
begin 
	process(D,S)
	begin
		
		case S is
			when  "0000"=> TXD<=D(0);
			when  "0001"=> TXD<=D(1);
			when  "0010"=> TXD<=D(2);
			when  "0011"=> TXD<=D(3);
			when  "0100"=> TXD<=D(4);
			when  "0101"=> TXD<=D(5);
			when  "0110"=> TXD<=D(6);
			when  "0111"=> TXD<=D(7);
			when  "1000"=> TXD<='0';
			when  "1001"=> TXD<='1';
			when others => TXD <= '0'; 
		end case;
	end process;
end Lambda;
			