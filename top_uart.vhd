library ieee;
use ieee.std_logic_1164.all;

entity Top_UART is 
    port(
        RST,CLK,Start_TX,RXDT : in std_logic;
        Dato_TX : in std_logic_vector(7 downto 0);
        TXD,End_TX,DVal: out std_logic;
        Dato_RX : out std_logic_vector(7 downto 0)
    );
end Top_UART;

architecture Mele of Top_UART is
    
    component Top_TX is 
        port(
            RST,CLK,Start_tx : in std_logic;
            DTop : in std_logic_vector(7 downto 0);
            End_TX,TXD : out std_logic
        );
    end component;
    
	component Top_RXD is
		port(
			RST,CLK,RXD: in std_logic;
			DatoRXT: out std_logic_vector(7 downto 0);
			ValidT: out std_logic
		);
	end component;
begin
	
	C1: Top_TX port map (RST,CLK,Start_TX,Dato_TX,End_TX,TXD);
	C2: Top_RXD port map (RST,CLK,RXDT,Dato_RX,DVal);
end Mele;