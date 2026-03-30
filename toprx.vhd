library ieee;
use ieee.std_logic_1164.all;

entity Top_RXD is
	port(
		RST,CLK,RXD: in std_logic;
		DatoRXT: out std_logic_vector(7 downto 0);
		ValidT: out std_logic
	);
end Top_RXD;

architecture RX of Top_RXD is

component Cont_BTe is
	generic(
	n: integer:= 13;
	k: integer:= 5208
	);
	port(
		RST,CLK,CLR: in std_logic;
		BT: out std_logic
	);
end component;

component Cont_BT2 is
	generic(
		n: integer:= 13;
		k: integer:= 2604
	);
	port(
		RST,CLK,CLR2: in std_logic;
		BT2: out std_logic
	);
end component;

component FSM_RX is
	port(
		RST,CLK,RXD,BT1,BT2: in std_logic;
		CLR1,CLR2,Valid: out std_logic;
		SHR: out std_logic_vector(1 downto 0)
	);											    
end component;	

component SHR is
	port(
		RST,CLK,D: in std_logic;
		OPC: in std_logic_vector(1 downto 0);
		DatoRX: out std_logic_vector(7 downto 0)
	);										 
end component;	

signal CLRBT_1,BT_1,CLRBT_2,BT_2: std_logic;
signal S_OPC: std_logic_vector(1 downto 0);
begin
	Base_T1:Cont_BTe port map (RST,CLK,CLRBT_1,BT_1);
	Base_T2:Cont_BT2 port map (RST,CLK,CLRBT_2,BT_2);
	State_M:FSM_RX port map (RST,CLK,RXD,BT_1,BT_2,CLRBT_1,CLRBT_2,ValidT,S_OPC);
	Reg_R:SHR port map (RST,CLK,RXD,S_OPC,DatoRXT);
end RX;