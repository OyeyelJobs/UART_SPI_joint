--Master FSM for joining both interfaces and control them using an FPGA
library ieee;
use ieee.std_logic_1164.all;

entity FSM_P is
	port(
		RST,CLK,EndADC,BT,EndUART: in std_logic;
		SelK: in std_logic_vector(1 downto 0);
		StADC,ClrBT,StUARt,SelMux: out std_logic
	);
end FSM_P;

architecture YaUe of FSM_P is
signal Qp,Qn: std_logic_vector(3 downto 0);
begin
	Combinational: process(Qp,BT,EndADC,EndUART,SelK)
	begin
		case Qp is	
			when "0000"=>
				StADC <= '0';
				ClrBT <= '1';
				STUART <= '0';
				SelMux <= '0';
				if (SelK = "00") then
				Qn <= Qp;
					else
				Qn <= "0001";
				end if;
			
			when "0001"=>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '0';
				if (BT = '1') then
					Qn  <= "0010";
				else
					Qn <= Qp;
				end if;
		
			when "0010"=>
				StADC <= '1';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '0';
			
				Qn  <= "0011";
		
			when "0011"=>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '0';
				if (EndADC = '1') then
					Qn  <= "0100";
				else
					Qn <= Qp;
				end if;
			
			when "0100"=>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '0';
			
				Qn  <= "0101";
			
			when "0101"=>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '1';
				SelMux <= '0';
				
				Qn  <= "0110";
		
			when "0110"=>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '0';
				if (EndUART = '1') then
					Qn  <= "0111";
				else
					Qn <= Qp;
				end if;		  
		
			when "0111"=>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '0';
			
				Qn  <= "1000";
		
			when "1000"=>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '1';
				SelMux <= '1';
			
				Qn  <= "1001";
			
			when "1001" =>
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '1';
				if (EndUART = '1') then
					Qn  <= "0001";
				else
					Qn <= Qp;
				end if;
				
				when others => 
				
				StADC <= '0';
				ClrBT <= '0';
				STUART <= '0';
				SelMux <= '0';
				
				Qn <= "0000";
			end case;
			
		end process Combinational;

	Sequential: process(RST,CLK)
	begin
		if (RST = '0') then
			Qp <= "0000";
		elsif(CLK'event and CLK = '1') then
			Qp <= Qn;
		end if;
	end process Sequential;
end YaUe;
	
		