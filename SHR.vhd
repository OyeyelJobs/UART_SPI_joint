library ieee;
use ieee.std_logic_1164.all;

entity SHR is 
	port(
		RST,CLK,D: in std_logic;
		OPC: in std_logic_vector(1 downto 0);
		DatoRX: out std_logic_vector(7 downto 0)
	);										 
end SHR;

architecture Simple of SHR is
signal Qp,Qn: std_logic_vector(7 downto 0);
begin
	Combinational:process(Qp,D,OPC)
	begin
		case OPC is
			when "00" =>
				Qn <= (others=>'0');
			when "10"=>
				Qn(7)<=D;
				for i in 6 downto 0 loop
					Qn(i) <= Qp(i+1);
				end loop;
			when others =>
				Qn<=Qp;
		end case;		 
		
	end process Combinational;
	
	Sequential:process(RST,CLK)
	begin
		if(RST='0') then
			Qp <= (others=>'0');
		elsif(CLK'event and CLK='1') then
			Qp <= Qn;
		end if;	
	end process Sequential;	
	DatoRX <= Qp;
end Simple;