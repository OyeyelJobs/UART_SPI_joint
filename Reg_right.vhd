library ieee;
use ieee.std_logic_1164.all;

entity Reg_right is
	generic(n: integer := 8
		);
	port(
		RST: in std_logic;
		CLK: in std_logic;
		R: in std_logic;
		Q: out std_logic
		);			 
		
end Reg_right;

architecture Simple of Reg_right is
signal Qp,Qn: std_logic_vector(n-1 downto 0);
begin
	Combinacional: process (Qp,R)
	begin
		Qn(n-1) <= R; 
		for i in n-2 downto 0 loop 
			Qn(i) <= Qp(i+1); 
		end loop;
		Q<=Qp(0);
	end process Combinacional;
	
	Secuencial:process(RST,CLK)
	begin
		if (RST = '0') then
			Qp <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			Qp <= Qn;
		end if;
	end process Secuencial;
end Simple;