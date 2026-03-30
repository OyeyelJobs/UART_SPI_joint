library ieee;
use ieee.std_logic_1164.all;

entity FSM is
	port(
		RST,CLK,StartSPI,CPHA,BT: in std_logic;  
		EndSPI,CLRBT,SCLK: out std_logic;
		OpcMUX: out std_logic_vector(2 downto 0);
		OpcSHL: out std_logic_vector(1 downto 0)
	);
end FSM;

architecture Meleboj of FSM is
signal Qp,Qn: std_logic_vector(4 downto 0);	 
begin
	
	Combinational:process(Qp,StartSPI,BT,CPHA)
	begin
		case Qp is
			when "00000" =>	-- S0
				EndSPI <= '0';
				CLRBT <= '1';
				OpcMUX <= "000";
				OpcSHL <= "01"; 
				SCLK <='0';
				
				if (StartSPI = '1') then
					Qn <= "00001";
				else
					Qn<=Qp;
				end if;
				
			
			when "00001" =>	--S1
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "000";
				OpcSHL <= "01"; 
				SCLK <='0';
				
				if (BT = '1') then
					Qn <= "00010";
				else
					Qn<=Qp;
				end if;
				
			when "00010" =>	--S2
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "000";
				OpcSHL <= "10";
				SCLK <='1';
				Qn <= "00011";
				
			when "00011" =>	--S3
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "000";
				OpcSHL <= "01";
				SCLK <='1';
				if (BT = '1') then
					Qn <= "00100";
				else
					Qn<=Qp;
				end if;
				
			
			when "00100" =>	--S4
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "001";
				OpcSHL <= "01";
				SCLK <='0';
				if (BT = '1') then
					Qn <= "00101";
				else
					Qn<=Qp;
				end if;
				
			when "00101" =>	--S5
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "001";
				OpcSHL <= "10";
				SCLK <='1';
				Qn <= "00110";																		  
				
			when "00110" =>	--S6
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "001";
				OpcSHL <= "01";
				SCLK <='1';
				if (BT = '1') then
					Qn <= "00111";
				else
					Qn<=Qp;
				end if;
				
			
			when "00111" =>	--S7
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "010";
				OpcSHL <= "01";
				SCLK <='0';
				if (BT = '1') then
					Qn <= "01000";
				else
					Qn<=Qp;
				end if;
				
			when "01000" =>	--S8
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "010";
				OpcSHL <= "10";
				SCLK <='1';
				Qn <= "01001";
				
			when "01001" =>	--S9
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "010";
				OpcSHL <= "01";
				SCLK <='1';
				if (BT = '1') then
					Qn <= "01010";
				else
					Qn<=Qp;
				end if;
				
			
			when "01010" =>	--S10
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "011";
				OpcSHL <= "01";
				SCLK <='0';
				if (BT = '1') then
					Qn <= "01011";
				else
					Qn<=Qp;
				end if;
				
			when "01011" =>	--S11
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "011";
				OpcSHL <= "10";
				SCLK <='1';
				Qn <= "01100";
				
			when "01100" =>	--S12
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "011";
				OpcSHL <= "01";
				SCLK <='1';
				
				if (BT = '1') then
					Qn <= "01101";
				else
					Qn<=Qp;
				end if;
				
			when "01101" =>	--S13
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "100";
				OpcSHL <= "01";
				SCLK <='0';
				
				if (BT = '1') then
					Qn <= "01110";
				else
					Qn<=Qp;
				end if;
				
			when "01110" =>	--S14
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "100";
				OpcSHL <= "10";
				SCLK <='1';
				
				Qn <= "01111";
				
			when "01111" =>	--S15
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "100";
				OpcSHL <= "01";
				SCLK <='1';
				
				if (BT = '1') then
					Qn <= "10000";
				else
					Qn<=Qp;
				end if;
				
			when "10000" =>	--S16
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "101";
				OpcSHL <= "01";
				SCLK <='0';
				
				if (BT = '1') then
					Qn <= "10001";
				else
					Qn<=Qp;
				end if;
				
			when "10001" =>	--S17
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "101";
				OpcSHL <= "10";
				SCLK <='1';
				Qn <= "10010";
				
			when "10010" =>	--S18
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "101";
				OpcSHL <= "01";
				SCLK <='1';
				
				if (BT = '1') then
					Qn <= "10011";
				else
					Qn<=Qp;
				end if;
				
			when "10011" =>	--S19
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "110";
				OpcSHL <= "01";
				SCLK <='0';
				
				if (BT = '1') then
					Qn <= "10100";
				else
					Qn<=Qp;
				end if;
				
			when "10100" =>	--S20
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "110";
				OpcSHL <= "10";
				SCLK <='1';
				Qn <= "10101";
				
			when "10101" =>	--S21
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "110";
				OpcSHL <= "01";
				SCLK <='1';
				
				if (BT = '1') then
					Qn <= "10110";
				else
					Qn<=Qp;
				end if;
				
			when "10110" =>	--S22
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "111";
				OpcSHL <= "01";
				SCLK <='0';
				
				if (BT = '1') then
					Qn <= "10111";
				else
					Qn<=Qp;
				end if;
				
			when "10111" =>	--S23
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "111";
				OpcSHL <= "10";
				SCLK <='1';
				Qn <= "11000";
				
			when "11000" =>	--S24
				EndSPI <= '0';
				CLRBT <= '0';
				OpcMUX <= "111";
				OpcSHL <= "01";
				SCLK <='1';
				if (BT = '1') then
					Qn <= "11001";
				else
					Qn<=Qp;
				end if;
				
			when others =>	--S25
				EndSPI <= '1';
				CLRBT <= '1';
				OpcMUX <= "000";
				OpcSHL <= "01";
				SCLK <='0';
				if (StartSPI = '1') then
					Qn <= "00001";
				else
					Qn<=(others=>'0');
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
end Meleboj;