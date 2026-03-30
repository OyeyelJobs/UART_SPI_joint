library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Cont_BT_SPI is
	generic(
		n: integer:= 8
	);
	port(
		RST,CLK,CLR: in std_logic;
		BT: out std_logic
	);
end Cont_BT_SPI;

architecture MJVM1 of Cont_BT_SPI is
signal Qp,Qn: std_logic_vector(n-1 downto 0);
constant Ka: std_logic_vector(n-1 downto 0):= "00011000";
signal CK,Sel: std_logic;

begin		  	
	comp_CK: process(Qp)
	begin		
		if (Qp = Ka) then 
			CK <= '1';
		else  
			CK <= '0';
		end if;
	end process comp_CK;
	
	Combinational_1: process(CLR,CK)
	begin
		if (CLR = '0'and CK = '0') then
			BT<=CK;	
			Sel<='0';
		elsif (CLR = '0' and CK = '1') then
			BT<=CK;
			Sel<='1';						
		else 
			BT <= '0';
			Sel <= '1';
		end if; 
	end process Combinational_1; 
	
	Mux: process(Sel,Qp)
	begin
		if(Sel='0') then
			Qn<=Qp+1;
		else
			Qn<=(others=>'0');
		end if;
	end process Mux;
	
	Sequential: process(RST,CLK)
	begin
		if(RST = '0') then
			Qp<=(others =>'0');
		elsif(CLK'event and CLK = '1') then
			Qp<=Qn;
		end if;
	end process Sequential;	  				  
end MJVM1;