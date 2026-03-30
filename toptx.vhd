library ieee;
use ieee.std_logic_1164.all;

entity Top_TX is
	port(
		RST,CLK,Start_TX: in std_logic;
		DTop: in std_logic_vector(7 downto 0);
		End_TX,TXD: out std_logic
	);	
end Top_TX;

architecture TX of Top_TX is 

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

component FSM_UART is
	port(
		STX,BT,RST,CLK: in std_logic;
		ETX,ClrBT: out std_logic;
		Sel: out std_logic_vector(3 downto 0)
	);
end component;						

component Mux_UART is
	port(
		S: in std_logic_vector(3 downto 0);
		D: in std_logic_vector(7 downto 0);
		TXD: out std_logic
	);	
end component;
	
signal CLR_BT,B_T: std_logic;
signal S_S: std_logic_vector(3 downto 0);
begin
	Base_T: Cont_BTe port map (RST,CLK,CLR_BT,B_T);
	State_M: FSM_UART port map (Start_TX,B_T,RST,CLK,End_TX,CLR_BT,S_S);
	Mux: Mux_UART port map (S_S,DTop,TXD);
end TX;