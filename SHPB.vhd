library ieee;
use ieee.std_logic_1164.all;

entity SHPB is
	generic(
		n: integer:= 8
		);
	port(
		RST: in std_logic;
		CLK: in std_logic;
		OpB: in std_logic_vector(1 downto 0);
		DB: in std_logic_vector(n-1 downto 0);
		QB: out std_logic_vector(n-1 downto 0)
		);

end SHPB;

architecture Simple of SHPB is
signal Qn,Qp: std_logic_vector(n-1 downto 0);
begin
	Combinacional: process(Qp,OpB,DB)
	begin
		case OpB is
			when "00" => Qn <= (others=>'0');
			when "11" => Qn <= DB;
			when others => Qn <= Qp;
		end case;
		QB <= Qp;
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