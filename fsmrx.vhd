library ieee;
use ieee.std_logic_1164.all;

entity FSM_RX is
	port(
		RST,CLK,RXD,BT1,BT2: in std_logic;
		CLR1,CLR2,Valid: out std_logic;
		SHR: out std_logic_vector(1 downto 0)
	);											    
end FSM_RX;

architecture Lambda of FSM_RX is
signal Qp,Qn: std_logic_vector(4 downto 0);
begin
	Combinational:process(Qp,RXD,BT1,BT2)
	begin
		
	case Qp is
		when "00000"=>
			CLR1 <= '1';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (RXD = '0') then
				Qn <= "00001";
			else
				Qn<=Qp;
			end if;
			
		when "00001"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "00010";
			else
				Qn<=Qp;
			end if;
		
		when "00010"=>
			CLR1 <= '1';
			CLR2 <= '0';
			SHR <= "01";
			Valid <= '0';
			if (BT2 = '1') then
				Qn <= "00011";
			else
				Qn<=Qp;
			end if;
			
		when "00011"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "00100";
		
		when "00100"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "00101";
			else
				Qn<=Qp;
			end if;
		
		when "00101"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';	  
			
			Qn <= "00110";
		
		when "00110"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "00111";
			else
				Qn<=Qp;
			end if;
			
		when "00111"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "01000";
		
		when "01000"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "01001";
			else
				Qn<=Qp;
			end if;
			
		when "01001"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "01010";
		
		when "01010"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "01011";
			else
				Qn<=Qp;
			end if;		 
			
		when "01011"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "01100";
			
		when "01100"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "01101";
			else
				Qn<=Qp;
			end if;	
			
		when "01101"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "01110";
			
		when "01110"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "01111";
			else
				Qn<=Qp;
			end if;
		
		when "01111"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "10000";
			
		when "10000"=>
			CLR1 <= '0';
			CLR2 <= '0';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "10001";
			else
				Qn<=Qp;
			end if;
			
		when "10001"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "10010";
		
		when "10010"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "10011";
			else
				Qn<=Qp;
			end if;
		
		when "10011"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "10";
			Valid <= '0';
			
			Qn <= "10100";
		
		when "10100"=>
			CLR1 <= '0';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
			if (BT1 = '1') then
				Qn <= "10101";
			else
				Qn<=Qp;
			end if;	   
		
		when "10101" =>
			CLR1 <= '1';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '1';	
			Qn <= "00000"; 
		
		when others =>
			CLR1 <= '1';
			CLR2 <= '1';
			SHR <= "01";
			Valid <= '0';
		
			Qn <= "00000";
		end case;
	end process Combinational;

	Sequential:process(RST,CLK)
	begin
		if (RST = '0') then
			Qp <= "00000";
		elsif(cLK'event and CLK = '1') then
			Qp<=Qn;
		end if;
	end process Sequential;
end Lambda;