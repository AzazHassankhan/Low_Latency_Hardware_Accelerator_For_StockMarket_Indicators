library ieee;
use ieee.std_logic_1164.all;
-- top
entity top is
	generic (N : integer := 20);
	port 
	( 	-- Inputs 
		clk : in std_logic;
		rst : in std_logic;
		Go : in std_logic;
		WE_A : in std_logic;
		Din : in std_logic_vector(N-1 downto 0);
		Din_down : in std_logic_vector(N-1 downto 0);
		RdAddr : in std_logic_vector(N-1 downto 0);
		-- Outputs
		Done : inout std_logic;
		Order_signal : out std_logic_vector(1 downto 0)

    );
end top;

architecture arch of top is
   -- Top signals
   signal RAdd : std_logic;
   signal S1 : std_logic;
   signal S2 : std_logic;
   signal S3 : std_logic;
   signal Li : std_logic;
   signal Lj : std_logic;
   signal Ei : std_logic;
   signal Ej : std_logic;
   signal EA : std_logic;
   signal EC : std_logic;
   signal Ecount_0 :	std_logic;
   signal Ecount_0_down :	std_logic;
   signal Csel : std_logic;
   signal ResetC : std_logic;
   signal ResetD : std_logic;
   signal Zi_max	: std_logic;
   signal Zj_max	: std_logic;
begin 
	-- datapath Instant	
	datapath_inst: entity work.datapath 
    generic map ( N => N)
    port map
    ( 	 
	clk => clk,   
	rst => rst,  
	RdAddr => RdAddr,
	S1 => S1,
	S2 => S2,
	S3 => S3,
	Li => Li,
	Lj => Lj,
	Ei => Ei,
	Ej => Ej,
	EA => EA,
	EC => EC,
	Ecount_0 => Ecount_0,
	Ecount_0_down => Ecount_0_down,
	WE_A   => WE_A  ,
	Csel   => Csel  ,
	ResetC => ResetC,
	ResetD => ResetD,
	Din    => Din   ,
	Din_down    => Din_down,
	Zi_max => Zi_max,
	Zj_max => Zj_max,
	Order_signal=>Order_signal

	);
	-- Controller Instant
	controller_inst: entity work.controller 
	port map
	( 	  
	clk	=> clk,	
	rst => rst,  
	Go 	=> Go,	 
	S1 => S1,
	S2 => S2,
	S3 => S3,
	Li => Li,
	Lj => Lj,
	Ei => Ei,
	Ej => Ej,
	EA => EA,
    EC => EC,
	Ecount_0 => Ecount_0,
    Ecount_0_down => Ecount_0_down,
	Csel     => Csel ,   
	ResetC   => ResetC,
	ResetD => ResetD,   
	Zi_max   => Zi_max , 
	Zj_max   => Zj_max  ,
	Done => Done  
	);
end arch;


