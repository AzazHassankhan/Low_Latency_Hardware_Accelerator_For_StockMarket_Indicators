library ieee;
use ieee.std_logic_1164.all;

-- top
entity top is
	generic (N : integer := 20);
	port 
	( 	-- Inputs 
		clk : in std_logic;
		rst : in std_logic;
		Go :  in std_logic;
		We :  in std_logic;
		Din : in std_logic_vector(N-1 downto 0);
		RdAddr : in std_logic_vector(7 downto 0);
		-- Outputs
		Done : out std_logic;
		RSI_Dout : out std_logic_vector(N-1 downto 0);
		Dout : out std_logic_vector(1 downto 0)
    );
end top;

architecture arch of top is
   -- Top signals
   signal S1 : std_logic;
   signal S2 : std_logic;
   signal S3 : std_logic;
   signal Li : std_logic;
   signal Ei : std_logic;
   signal EA : std_logic;
   signal EC : std_logic;
   signal ED : std_logic;
   signal Ee : std_logic;
   signal Ef : std_logic;
   signal Zi : std_logic;
   signal gt1 : std_logic;
   signal Zmax : std_logic;

begin 
	-- datapath Instant	
	datapath_inst: entity work.datapath 
    generic map ( N => N)
    port map
    ( 	 
	clk => clk,   
	rst => rst,  
	S1  => S1,   
	S2  => S2,   
	S3  => S3,   
	Ei  => Ei,    
	Li  => Li,    
	EA  => EA,       
	EC  => EC,    
	ED  => ED,
    Ee  => Ee,    
	Ef  => Ef,    
	We  => We,    
	Zi  => Zi,   
	gt1 => gt1, 
	Din  => Din,   
	Dout => Dout,
	RSI_Dout =>RSI_Dout,
	Zmax => Zmax, 
	RdAddr => RdAddr

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
	Ei => Ei,    
	EA => EA,        
	EC => EC,    
	ED => ED,
    Ee  => Ee,    
    Ef  => Ef,
	Zi  => Zi,   
	gt1 => gt1,   
	Zmax => Zmax,  
	Done => Done 
	);
	
end arch;


