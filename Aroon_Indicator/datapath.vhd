library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- datapath
entity datapath is
generic (N : integer := 20; L : integer := 20);
port 
(-- inputs	
	clk : in std_logic;
	rst : in std_logic;
	RdAddr : in std_logic_vector(N-1 downto 0);
	S1 : in std_logic;  
	S2 : in std_logic;
	S3 : in std_logic;  
	Li : in std_logic;  
	Lj : in std_logic;  
	Ei : in std_logic;  
	Ej : in std_logic;  
	EA : in std_logic;
	EC : in std_logic;  

	Ecount_0 : in std_logic;
	Ecount_0_down : in std_logic;  
	WE_A : in std_logic;  
	Csel : in std_logic;  
	ResetC : in std_logic;
	ResetD : in std_logic;  
	Din : in std_logic_vector(N-1 downto 0);
	Din_down : in std_logic_vector(N-1 downto 0);   
	-- outputs
	Zi_max : out std_logic; 
	Zj_max : inout std_logic;
	Order_signal : out std_logic_vector(1 downto 0)

);
end datapath;

architecture arch of datapath is

constant Length_file : std_logic_vector(N-1 downto 0) := x"000B8";  -- 185
constant Frame_size : std_logic_vector(N-1 downto 0)  := x"0000F";  
signal cntr_i_in : std_logic_vector(N-1 downto 0);
signal cntr_j_in : std_logic_vector(N-1 downto 0);
signal i : std_logic_vector(N-1 downto 0); 
signal j : std_logic_vector(N-1 downto 0); 
signal mux0_out : std_logic_vector(N-1 downto 0); 
signal mux1_out : std_logic_vector(N-1 downto 0); 
signal mux2_out : std_logic;
signal mux3_out : std_logic;
signal mux4_out : std_logic;
signal mux5_out : std_logic; 
signal    ED :  std_logic;
signal    EE : std_logic;
signal RamA_out   : std_logic_vector(L-1 downto 0);
signal RamB_out   : std_logic_vector(L-1 downto 0);  
signal reg_Aout   : std_logic_vector(L-1 downto 0);
signal reg_Cout   : std_logic_vector(L-1 downto 0); 
signal Adder1_out : std_logic_vector(L-1 downto 0);
signal Adder1_out_down : std_logic_vector(L-1 downto 0); 
signal Aroon_up_1 : std_logic_vector(N+L-1 downto 0);
signal Previous_Aroon_up   : std_logic_vector(N-1 downto 0);
signal Aroon_down_1 : std_logic_vector(N+L-1 downto 0);
signal Previous_Aroon_down  : std_logic_vector(N-1 downto 0);   
signal Period     : std_logic_vector(L-1 downto 0);
signal Period_down     : std_logic_vector(L-1 downto 0); 
signal Count      : std_logic_vector(L-1 downto 0);
signal Count_down      : std_logic_vector(L-1 downto 0); 
signal Comp       : std_logic; 
signal Comp1      : std_logic; 
signal Comp_down       : std_logic; 
signal Comp1_down      : std_logic; 
signal Dout_down : std_logic_vector (N-1 downto 0);
signal Dout       : std_logic_vector (N-1 downto 0);
signal buy                :     std_logic_vector(1 downto 0);
signal sell               :     std_logic_vector(1 downto 0);
signal sel_out            :     std_logic_vector(3 downto 0);
begin

	cntr_i_in <= (others=>'0');
	
	-- counter i
	cntr_i : entity work.countern generic map (N => L)
	port map(clk => clk, rst => rst, ld=> li, en => Ei, input => cntr_i_in, output => i);
	Zi_max <= '1' when (i = Length_file) else '0';
	
	-- counter j
	cntr_j_in <= i + 1;
	cntr_j : entity work.countern generic map (N => L)
	port map(clk => clk, rst => rst, ld => lj, en => Ej, input => cntr_j_in, output => j);
	Zj_max <= '1'  when (j = i+Frame_size) else '0';

	-- multiplexers
	mux0_out <= j when (Csel = '1') else i;
	mux1_out <= mux0_out when (S1 = '1') else RdAddr;
	mux2_out <= Comp1 when (S2 = '1') else EA;
    mux3_out<='1' when Comp='0' else ResetC;
	-- RAM
	RAM_up : entity work.RAM generic map (addr_width => L, data_width => N)
	port map( clk => clk, WE => WE_A, ADDR => mux1_out, DIN => Din, DOUT => RamA_out);
    Rom_up: entity work.ROM 
    port map( addr  => Aroon_up_1, cout => Dout);
          
    RAM_down : entity work.RAM generic map (addr_width => L, data_width => N)
    port map( clk => clk, WE => WE_A, ADDR => mux1_out, DIN => Din_down, DOUT => RamB_out);
    Rom_down: entity work.Rom
    port map( addr  => Aroon_down_1, cout => Dout_down);
	-- register
	reg_A : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => mux2_out, D => RamA_out, Q => reg_Aout); 
	reg_Count : entity work.reg generic map (N => N) port map (clk => clk, rst =>  mux3_out, en => Ecount_0, D => Adder1_out, Q => Count); 
    reg_Previous_Arron_up : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => ED, D => Dout , Q => Previous_Aroon_up);     
    reg_Previous_Arron_down : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => EE, D => Dout_down, Q => Previous_Aroon_down );     

	Comp <= '1'  when (RamA_out < reg_Aout) else '0';
    Comp1<='1'   when Comp='0'  else '0';
 
	-- Accumulator
	Adder1_out <= Comp + Count;

	-- Formula Calculation
	Period <= Count when (Zj_MAX='1' and Count>=0) else x"0000E";
	Aroon_up_1 <=  std_logic_vector(unsigned(14-Period)*100);


   	reg_C : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => mux4_out, D => RamB_out, Q => reg_Cout); 
    reg_D : entity work.reg generic map (N => N) port map (clk => clk, rst =>  mux5_out, en => Ecount_0_down, D => Adder1_out_down, Q => Count_down); 

    Adder1_out_down <= Comp_down + Count_down;
    	
    mux4_out     <= Comp1_down when (S3 = '1') else EC;
    mux5_out     <= '1'        when  Comp_down='0'  else ResetD;
    Comp_down    <= '1'        when (RamB_out > reg_Cout) else '0';
    Comp1_down   <= '1'        when  Comp_down='0'  else '0'; 
    Period_down  <= Count_down when (Zj_MAX='1' and Count>=0) else x"0000E" ;
    Aroon_down_1 <=  std_logic_vector(unsigned(14-Period_down)*100);

    ED<='1' when Zj_MAX='1' else '0';
    EE<='1' when Zj_MAX='1' else '0';
    Buy <="01"  when   (Dout > Dout_down and Previous_Aroon_up  <= Previous_Aroon_down )  else (others=>'0'); 
    Sell <="10" when  (Dout < Dout_down and Previous_Aroon_up   >= Previous_Aroon_down )  else (others=>'0'); 
    sel_out <= Buy & Sell;
            with sel_out select 
            Order_signal  <=  Buy when  "0100",
                              Sell when "0010",
            (others => '0') when others;
end arch;


