library ieee;
use ieee.std_logic_1164.all;

entity Top_SPI is
	port(
		RST,CLK,CPHA,StADC,MISO: in std_logic;--MISO GPIO
		CH: in std_logic_vector(1 downto 0); --Slide                                   
		EndADC,CS, MOSI,SCLK: out std_logic; --GPIO menos End
		DADC: out std_logic_vector(11 downto 0) --LEDs
	);
end Top_SPI;
	
architecture ADS of Top_SPI is

	 
component Top is
	port(
		RST,CLK,StartSPI,CPHA,MISO: in std_logic;
		ByteTX: in std_logic_vector(7 downto 0);
		EndSPI,SCLK,MOSI: out std_logic;			
		ByteRX: out std_logic_vector(7 downto 0)
	);
end component;

component FSM2 is
	port(
		RST,CLK,StADC,EndSPI: in std_logic;
	
		OpMux,CS,EndADC,StSPI: out std_logic;
		OpRA,OpRB: out std_logic_vector(1 downto 0)
	);								   
end component;

component Driver is
	port(			  
		CH: in std_logic_vector (1 downto 0);
		DTX: out std_logic_vector(7 downto 0);
		OpMux: in std_logic;
		
		QA,QB: in std_logic_vector (7 downto 0);
		DADC: out std_logic_vector(11 downto 0)
	);
end component;	

component SHPA is
	generic(
		n: integer:= 8
		);
	port(
		RST: in std_logic;
		CLK: in std_logic;
		OpA: in std_logic_vector(1 downto 0);
		DA: in std_logic_vector(n-1 downto 0);
		QA: out std_logic_vector(n-1 downto 0)
		);

end component;


component SHPB is
	generic(
		n: integer:= 8
		);
	port(
		RST: in std_logic;
		CLK: in std_logic;
		OpB: in std_logic_vector(1 downto 0);
		DB: in std_logic_vector(n-1 downto 0);
		QB: out std_logic_vector(n-1 downto 0)
		);

end component;

signal St_SPI,End_SPI,Op_Mux: std_logic;
signal D_TX,D_RX,Q_A,Q_B: std_logic_vector(7 downto 0);
signal OP_RA,OP_RB: std_logic_vector(1 downto 0);
signal StADCn: std_logic;
begin
	C1: Top port map(RST,CLK,St_SPI,CPHA,MISO,D_TX,End_SPI,SCLK,MOSI,D_RX);
	C2: FSM2 port map (RST,CLK,StADCn,End_SPI,Op_Mux,CS,EndADC,St_SPI,OP_RA,OP_RB);
	C3: Driver port map (CH,D_TX,Op_Mux,Q_A,Q_B,DADC);
	C4: SHPA port map (RST,CLK,OP_RA,D_RX,Q_A);
	C5: SHPB port map (RST,CLK,OP_RB,D_RX,Q_B);
	
	StADCn<= not StADC;
end ADS;