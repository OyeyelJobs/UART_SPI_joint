library ieee;
use ieee.std_logic_1164.all;

entity SHL is 
	port(
		RST,CLK,MISO: in std_logic;
		OPC: in std_logic_vector(1 downto 0);
		ByteRX: out std_logic_vector(7 downto 0)
	);										 
end SHL;

architecture Simple of SHL is
signal Qp,Qn: std_logic_vector(7 downto 0);
begin
	Combinational:process(Qp,MISO,Opc)
	begin
		case OPC is
			when "00" =>
				Qn <= (others=>'0');
			when "10"=>
				Qn(0)<=MISO;
				for i in 1 to 7 loop
					Qn(i) <= Qp(i-1);
				end loop;
			when others =>
				Qn<=Qp;
		end case;		 
		ByteRX <= Qp;
	end process Combinational;
	
	Sequential:process(RST,CLK)
	begin
		if(RST='0') then
			Qp <= (others=>'0');
		elsif(CLK'event and CLK='1') then
			Qp <= Qn;
		end if;
	end process Sequential;
end Simple;