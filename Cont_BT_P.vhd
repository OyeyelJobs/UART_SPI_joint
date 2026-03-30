library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Cont_BTP is
	generic(
		n: integer:= 13
	);
	port(
		RST,CLK,CLR: in std_logic;
		SelK: in std_logic_vector(1 downto 0);
		BT: out std_logic
	);
end Cont_BTP;

architecture MJVM of Cont_BTP is
signal Qp,Qn: std_logic_vector(n-1 downto 0);
signal CK,Sel: std_logic;
signal K: std_logic_vector (23 downto 0);

begin		  	
	comp_CK: process(Qp)
	begin
		
		case SelK is
			when "00" => K <= "000000000000000000000011";
			when "01" => K <= "111111100101000000101001"; --3 Hz
			when "10" => K <= "100110001001011001111111"; --5 Hz
			when others  => K <= "010011000100101101000000"; --10 Hz
		end case;
			
		if (Qp = K) then 
			CK <= '1';
		else  
			CK <= '0';
		end if;
	end process comp_CK;
	
	Combinational_1: process(CLR,CK)
	begin
		if (CLR = '0'and CK = '0') then
			BT<='0';	
			Sel<='0';
		elsif (CLR = '0' and CK = '1') then
			BT<='1';
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
end MJVM;