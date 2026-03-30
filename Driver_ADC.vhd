--This performs a specific sequence of commands needed by the ADS7841 to work properly, in tandem with LUT_P.vhd and MUX.P.vhd
library ieee;
use ieee.std_logic_1164.all;

entity Driver is
	port(			  
		CH: in std_logic_vector (1 downto 0);
		DTX: out std_logic_vector(7 downto 0);
		OpMux: in std_logic;
		
		QA,QB: in std_logic_vector(7 downto 0);
		DADC: out std_logic_vector(11 downto 0)
	);
end Driver;

architecture ADC of Driver is

signal CMD: std_logic_vector(7 downto 0);
signal A: std_logic_vector(2 downto 0);
begin
				
	CMDGen: process(CH,A,CMD)
	begin
		case CH is 
			when "00" => A <= "001";
			when "01" => A <= "101";
			when "10" => A <= "010";
			when others => A <= "110";
		end case;
		
	CMD <= '1'&A&"0111";
	end process CMDGen;
		
	Mux: process (OpMux)
	begin
		case OpMux is
			when '0' => DTX <= (others=>'0');
			when others => DTX <= CMD;
		end case;
	end process Mux;
	
	ConcatADC:process (QA,QB)
	begin
		DADC <= QA(6 downto 0)&QB(7 downto 3);
	
	end process ConcatADC;
end ADC;