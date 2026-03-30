library ieee;
use ieee.std_logic_1164.all;

entity Top is
	port(
		RST,CLK,StartSPI,CPHA,MISO: in std_logic;
		ByteTX: in std_logic_vector(7 downto 0);
		EndSPI,SCLK,MOSI: out std_logic;			
		ByteRX: out std_logic_vector(7 downto 0)
	);
end Top;

architecture Transfer of Top is

component FSM is
	port(
		RST,CLK,StartSPI,CPHA,BT: in std_logic;  
		EndSPI,CLRBT,SCLK: out std_logic;
		OpcMux: out std_logic_vector(2 downto 0);
		OpcSHL: out std_logic_vector(1 downto 0)
	);
end component; 					  

component SHL is 
	port(
		RST,CLK,MISO: in std_logic;
		OPC: in std_logic_vector(1 downto 0);
		ByteRX: out std_logic_vector(7 downto 0)
	);										 
end component;   

component Mux is
	port(
		ByteTX: in std_logic_vector(7 downto 0);
		Opc: in std_logic_vector(2 downto 0);
		MOSI: out std_logic
	);				   
end component;

component Cont_BT_SPI is
	generic(
		n: integer:= 8
	);
	port(
		RST,CLK,CLR: in std_logic;
		BT: out std_logic
	);
end component;

signal CLR_BT,B_T: std_logic;
signal Opc_SHL: std_logic_vector(1 downto 0);
signal Opc_Mux: std_logic_vector(2 downto 0);

begin
	Base_T: Cont_BT_SPI port map (RST,CLK,CLR_BT,B_T);
	Multix: Mux port map (ByteTX,Opc_Mux,MOSI);
	Reg_L: SHL port map (RST,CLK,MISO,Opc_SHL,ByteRX);
	State_M: FSM port map (RST,CLK,StartSPI,CPHA,B_T,EndSPI,CLR_BT,SCLK,Opc_Mux,Opc_SHL);
end Transfer;