library ieee;
use ieee.std_logic_1164.all;

entity Top_p is
	port(
		RST, CLK : in std_logic;
		RXDT     : in std_logic;
		CPHA     : in std_logic;
		MISO     : in std_logic;
		CH       : in std_logic_vector(1 downto 0);

		TXD      : out std_logic;
		CS       : out std_logic;
		MOSI     : out std_logic;
		SCLK     : out std_logic;
		DADC     : out std_logic_vector(11 downto 0)
	);
end Top_p;

architecture bomel of Top_p is

	component Top_SPI is
		port(
			RST,CLK,CPHA,StADC,MISO: in std_logic;
			CH: in std_logic_vector(1 downto 0);                                 
			EndADC,CS,MOSI,SCLK: out std_logic;
			DADC: out std_logic_vector(11 downto 0)
		);
	end component;

	component Top_UART is 
		port(
			RST,CLK,Start_TX,RXDT : in std_logic;
			Dato_TX : in std_logic_vector(7 downto 0);
			TXD,End_TX,DVal: out std_logic;
			Dato_RX : out std_logic_vector(7 downto 0)
		);
	end component;

	component FSM_P is
		port(
			RST,CLK,EndADC,BT,EndUART: in std_logic;
			SelK: in std_logic_vector(1 downto 0);
			StADC,ClrBT,StUART,SelMux: out std_logic
		);
	end component;

	component Cont_BTP is
		generic(
			n: integer:= 13
		);
		port(
			RST,CLK,CLR: in std_logic;
			SelK: in std_logic_vector(1 downto 0);
			BT: out std_logic
		);
	end component;

	component LUT_P is
		port(
			RX: in std_logic_vector(7 downto 0);
			Op: out std_logic_vector (1 downto 0)
		); 
	end component;

	component Mux_P is
		port(
			S: in std_logic;
			Din: in std_logic_vector(11 downto 0);
			Dout: out std_logic_vector(7 downto 0)
		);
	end component;

	signal End_ADC   : std_logic;
	signal End_UART  : std_logic;
	signal BT        : std_logic;
	signal St_ADC    : std_logic;
	signal Clr_BT    : std_logic;
	signal St_UART   : std_logic;
	signal Sel_Mux   : std_logic;

	signal Sel_K     : std_logic_vector(1 downto 0);
	signal RX_Data   : std_logic_vector(7 downto 0);
	signal TX_Data   : std_logic_vector(7 downto 0);
	signal DADC_int  : std_logic_vector(11 downto 0);

begin

	U1: LUT_P
		port map (
			RX_Data,
			Sel_K
		);

	U2: Cont_BTP
		port map (
			RST,
			CLK,
			Clr_BT,
			Sel_K,
			BT
		);

	U3: FSM_P
		port map (
			RST,
			CLK,
			End_ADC,
			BT,
			End_UART,
			Sel_K,
			St_ADC,
			Clr_BT,
			St_UART,
			Sel_Mux
		);

	U4: Top_SPI
		port map (
			RST,
			CLK,
			CPHA,
			St_ADC,
			MISO,
			CH,
			End_ADC,
			CS,
			MOSI,
			SCLK,
			DADC_int
		);

	U5: Mux_P
		port map (
			Sel_Mux,
			DADC_int,
			TX_Data
		);

	U6: Top_UART
		port map (
			RST,
			CLK,
			St_UART,
			RXDT,
			TX_Data,
			TXD,
			End_UART,open,
			RX_Data
		);

	DADC <= DADC_int;

end bomel;
