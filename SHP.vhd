library ieee;
use ieee.std_logic_1164.all;

entity SHPA is
	generic(
		n: integer:= 8
		);
	port(
		RST: in std_logic;
		CLK: in std_logic;
		OpA: in std_logic_vector(1 downto 0);
		DA: in std_logic_vector(n-1 downto 0);
		QA: out std_logic_vector(n-1 downto 0)
		);

end SHPA;

architecture Simple of SHPA is
signal Qn,Qp: std_logic_vector(n-1 downto 0);
begin
	Combinacional: process(Qp,OpA,DA)
	begin
		case OpA is
			when "00" => Qn <= (others=>'0');
			when "11" => Qn <= DA;
			when others => Qn <= Qp;
		end case;
		QA <= Qp;
	end process Combinacional;
		
	Secuencial: process(RST,CLK)
	begin
		if (RST = '0') then
			Qp <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			Qp <= Qn;
		end if;
	end process Secuencial;
end Simple;
	