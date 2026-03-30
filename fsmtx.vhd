library ieee;
use ieee.std_logic_1164.all;

entity FSM_UART is 
	port(
		STX,BT,RST,CLK: in std_logic;
		ETX,ClrBT: out std_logic;
		Sel: out std_logic_vector(3 downto 0)
	);
end FSM_UART;

architecture Lambda of FSM_UART is		   
signal Qp,Qn: std_logic_vector(3 downto 0);
begin
	Combinational:process (Qp,STX,BT)
	begin
		case Qp is
			when "0000" =>
				ClrBT <= '1';
				Sel <= "1001";
				ETX <= '0';
				
				if(STX='1') then
					Qn<="0001";
				else
					Qn<="0000";
				end if;	 
			when "0001" =>
				ClrBT <= '0';
				Sel <= "1000";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="0010";
				else
					Qn<="0001";
				end if;
				
			when "0010" =>
				ClrBT <= '0';
				Sel <= "0000";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="0011";
				else
					Qn<="0010";
				end if;
			
			when "0011" =>
				ClrBT <= '0';
				Sel <= "0001";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="0100";
				else
					Qn<="0011";
				end if;
			
			when "0100" =>
				ClrBT <= '0';
				Sel <= "0010";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="0101";
				else
					Qn<="0100";
				end if;
			
			when "0101" =>
				ClrBT <= '0';
				Sel <= "0011";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="0110";
				else
					Qn<="0101";
				end if;
				
			when "0110" =>
				ClrBT <= '0';
				Sel <= "0100";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="0111";
				else
					Qn<="0110";
				end if;		 
			
			when "0111" =>
				ClrBT <= '0';
				Sel <= "0101";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="1000";
				else
					Qn<="0111";
				end if;	
			
			when "1000" =>
				ClrBT <= '0';
				Sel <= "0110";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="1001";
				else
					Qn<="1000";
				end if;
			
			when "1001" =>
				ClrBT <= '0';
				Sel <= "0111";
				ETX <= '0';
				
				if(BT='1') then
					Qn<="1010";
				else
					Qn<="1001";
				end if;
				
			when "1010" =>
				ClrBT <= '1';
				Sel <= "1001";
				ETX <= '1';
				
				Qn<="1011";
			
			when others =>
				ClrBT <= '1';
				Sel <= "1001";
				ETX <= '0';
				
				if(STX = '1') then
					Qn<="0001";
				else
					Qn<=Qp;
				end if;	
		end case;
	end process Combinational;
	
	Sequential: process(RST,CLK)
	begin
		if (RST = '0') then
			Qp<="0000";
		elsif(CLK'event and CLK = '1') then
			Qp<=Qn;
		end if;
	end process Sequential;
end Lambda;