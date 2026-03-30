--FSM for use of an ADS7841 via SPI
library ieee;
use ieee.std_logic_1164.all;

entity FSM2 is
	port(
		RST,CLK,StADC,EndSPI: in std_logic;
	
		OpMux,CS,EndADC,StSPI: out std_logic;
		OpRA,OpRB: out std_logic_vector(1 downto 0)
	);								   
end FSM2;

architecture ADS of FSM2 is
signal Qn,Qp: std_logic_vector(3 downto 0);
begin
	Combinational:process(Qp,StADC,EndSPI)
	begin
		case Qp is
			when "0000" =>
				OpMux <= '0';
				CS <= '1';
				EndADC <= '0';
				StSPI <= '0';
				OpRA <= "00";
				OpRB <= "00";
				if (StADC = '1') then
					Qn <= "0001";
				else
					Qn<=Qp;
				end if;
			
			when "0001" =>
				OpMux <= '1';
				CS <= '0';
				EndADC <= '0';
				StSPI <= '1';
				OpRA <= "01";
				OpRB <= "01";
				
				Qn <= "0010";
				
			when "0010" =>
				OpMux <= '1';
				CS <= '0';
				EndADC <= '0';
				StSPI <= '0';
				OpRA <= "01";
				OpRB <= "01";
				
				if (EndSPI = '1') then
					Qn <= "0011";
				else
					Qn <= Qp;
				end if;
			
			when "0011" =>
				OpMux <= '0';
				CS <= '0';
				EndADC <= '0';
				StSPI <= '1';
				OpRA <= "01";
				OpRB <= "01";
				
				Qn <= "0100"; 
				
			when "0100" =>
				OpMux <= '0';
				CS <= '0';
				EndADC <= '0';
				StSPI <= '0';
				OpRA <= "01";
				OpRB <= "01";
				
				if (EndSPI = '1') then 
					Qn <= "0101";
				else
					Qn<=Qp;
				end if;
				
			when "0101" =>
				OpMux <= '0';
				CS <= '0';
				EndADC <= '0';
				StSPI <= '1';
				OpRA <= "11";
				OpRB <= "01";
				
				Qn <= "0110";
				
			when "0110" =>
				OpMux <= '0';
				CS <= '0';
				EndADC <= '0';
				StSPI <= '0';
				OpRA <= "01";
				OpRB <= "01";
				
				if (EndSPI = '1') then 
					Qn <= "0111";
				else
					Qn<=Qp;
				end if;	
				
			when "0111" =>
				OpMux <= '0';
				CS <= '0';
				EndADC <= '0';
				StSPI <= '0';
				OpRA <= "01";
				OpRB <= "11";
				
				Qn <= "1000";
				
			when "1000" =>
				OpMux <= '0';
				CS <= '0';
				EndADC <= '1';
				StSPI <= '0';
				OpRA <= "01";
				OpRB <= "01";
				
				Qn <= "1001";
			
			when others =>
				OpMux <= '0';
				CS <= '1';
				EndADC <= '0';
				StSPI <= '0';
				OpRA <= "01";
				OpRB <= "01";
				
				if (StADC = '1') then
					Qn <= "0001";
				else
					Qn <= "0000";
				end if;		
		end case;
	end process Combinational;		
	
	Sequential:process(RST,CLK)
	begin				
		if (RST = '0') then
			Qp <= (others=>'0');
		elsif(CLK'event and CLK = '1') then
			Qp <= Qn;
		end if;
	end process Sequential;	   
end ADS;