library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Datapath
entity datapath is
generic (N : integer := 20; M : integer := 20);
port 
( 	

        clk : in std_logic;
        rst : in std_logic;
        S1  : in std_logic; 
        S2  : in std_logic;
        S3  : in std_logic; 
        Ei  : in std_logic; 
        Li  : in std_logic; 
        EA  : in std_logic; 
        EC  : in std_logic; 
        ED  : in std_logic;
        Ef  : in std_logic;
        Ee  : in std_logic; 
        Eg  : inout std_logic;
        Egain  : inout std_logic;
        Eloss  : inout std_logic;      
     
        We  : in std_logic; 
        Din : in std_logic_vector(N-1 downto 0); 
        RdAddr : in std_logic_vector(7 downto 0); 
        
        -- Outputs
        Zi  : inout std_logic; 
        gt1 : inout std_logic;
        Zmax : out std_logic; 
        Dout : out std_logic_vector(1 downto 0);
        RSI_Dout : out std_logic_vector(N-1 downto 0)
);
end datapath;

architecture arch of datapath is

    
    signal cntr_in            :     std_logic_vector(7 downto 0);
	signal i_count    		  :     std_logic_vector(7 downto 0);
	signal mux0_out   		  :     std_logic_vector(7 downto 0); 
	signal mux1_out   		  :     std_logic_vector(N-1 downto 0); 
    signal mux2_out   		  :     std_logic_vector(N-1 downto 0);
    signal mux2_out_1		  :     std_logic_vector(N+M-1 downto 0);

    signal ram_out    		  :     std_logic_vector(N-1 downto 0); 
	signal EA_out     		  :     std_logic_vector(N-1 downto 0);
    signal EC_out             :     std_logic_vector(N+M-1 downto 0); 
    signal ED_out             :     std_logic_vector(N+M-1 downto 0); 
    signal Ee_out             :     std_logic_vector(N-1 downto 0); 
    signal Ef_out             :     std_logic_vector(N-1 downto 0); 	
    signal Diff               :     std_logic_vector(N-1 downto 0); 
	signal Gain       		  :     std_logic_vector(N-1 downto 0); 
	signal Loss       		  :     std_logic_vector(N-1 downto 0); 
    signal Adder1_out 		  :     std_logic_vector(N+M-1 downto 0);  
	signal Adder2_out 		  :     std_logic_vector(N+M-1 downto 0);  
    signal DivideGain_14      :     std_logic_vector(N+M-1 downto 0);  
	signal DivideLoss_14 	  :     std_logic_vector(N+M-1 downto 0);
    signal Gain_Out           :     std_logic_vector(N-1 downto 0); 
	signal Loss_Out           :     std_logic_vector(N-1 downto 0); 
    signal AverageGain1       :     std_logic_vector(N-1 downto 0); 
	signal AverageLoss1       :     std_logic_vector(N-1 downto 0); 
    signal AverageGain2       :     std_logic_vector(N-1 downto 0); 
	signal AverageLoss2       :     std_logic_vector(N-1 downto 0);
    signal AverageGain_N      :     std_logic_vector(N+M-1 downto 0); 
	signal AverageLoss_N      :     std_logic_vector(N+M-1 downto 0);	
	signal Divide_gain        :     std_logic_vector(N+M-1 downto 0); 
	signal Divide_Loss        :     std_logic_vector(N+M-1 downto 0); 
	signal RS                 :     std_logic_vector(N-1 downto 0);
    signal RS_1               :     std_logic_vector(N+M-1 downto 0); 
	signal RS_2               :     std_logic_vector(N+M-1 downto 0);	
    signal RSI                :     std_logic_vector(N-1 downto 0);
    signal Rsi_prev           :     std_logic_vector(N-1 downto 0);

    signal RSI_1              :     std_logic_vector(N-1 downto 0);  
    signal RSI_2              :     std_logic_vector(N-1 downto 0);   
    signal buy                :     std_logic_vector(1 downto 0);
    signal sell               :     std_logic_vector(1 downto 0);
    signal sel_out            :     std_logic_vector(3 downto 0);

begin
	
	cntr_in <=  x"00"; 	-- Initialize counter value with '1'

	-- Counter i
	couter_i : entity work.countern generic map (N => 8) port map (clk => clk, rst => rst, ld => Li, en => Ei, input => cntr_in, output => i_count);
	
	-- RAM 
	RAM_A : entity work.RAM generic map (addr_width=>8,data_width => N) port map(clk => clk, WE => We, ADDR => mux0_out, DIN => Din, DOUT => ram_out);

	-- Register
    reg_EA : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => EA, D => ram_out, Q => EA_out);     
	reg_EC : entity work.reg generic map (N => N+M) port map (clk => clk, rst => rst, en => EC, D => Adder1_out, Q => EC_out); 
    reg_ED : entity work.reg generic map (N => N+M) port map (clk => clk, rst => rst, en => ED, D => Adder2_out, Q => ED_out); 
	reg_Ee : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => Ee, D => mux1_out, Q => Ee_out);     
    reg_Ef : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => Ef, D => mux2_out, Q => Ef_out);
    reg_Gain : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => Egain, D => Gain, Q => Gain_out);     
    reg_Loss : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => Eloss, D => Loss, Q => Loss_out);      
    reg_Previous_rsi : entity work.reg generic map (N => N) port map (clk => clk, rst => rst, en => Eg, D => rsi, Q => Rsi_prev);     

	--Status signal
	Zi   <= '1'   when (i_count =  x"0F")  else '0';
	gt1  <= '1'   when (i_count >  x"0F")  else '0';
	Zmax <= '1'   when (i_count >= x"c7")  else '0';
	
	-- Multiplexers
    mux0_out <= i_count      when (S1 = '1') else RdAddr;
    mux1_out <= AverageGain1 when (S2 = '1') else AverageGain2;
    mux2_out <= AverageLoss1 when (S3 = '1') else AverageLoss2;

    -- Subtractor
	DIFF<= std_logic_vector((signed(Ram_out)-signed(EA_out)));
	Gain <=std_logic_vector(abs(signed(DIFF)))  when signed(Diff)>0 else (others=>'0'); 
    Loss <=std_logic_vector(abs(signed(DIFF)))  when signed(Diff)<0 else (others=>'0'); 
 
	-- Accumulator
	Adder1_out <= EC_out + Gain;
	Adder2_out <= ED_out + Loss;
	
--	--Calculation_of RSI

    Egain<='1' when (gt1='1' or zi='1') else '0';
    Eloss<='1' when (gt1='1' or zi='1') else '0';
	--Calculation_of_AverageGain1 and AverageLoss1
	DivideGain_14 <= std_logic_vector(unsigned(Ec_out) / 14);
	AverageGain1 <=DivideGain_14(N-1 downto 0);
	
	DivideLoss_14 <= std_logic_vector(unsigned(ED_out) / 14);
	AverageLoss1 <=DivideLoss_14(N-1 downto 0);
	
	--Calculation of AverageGain2 and AverageLoss2
	Divide_gain <=std_logic_vector((unsigned(Ee_out)*(13))+ (unsigned(Gain_Out)));
	AverageGain_N<=std_logic_vector(unsigned(Divide_gain) / 14);
	AverageGain2<=AverageGain_N(N-1 downto 0);
	
	Divide_Loss <=std_logic_vector((unsigned(Ef_out)*(13))  + (unsigned(Loss_Out)));
    AverageLoss_N<=std_logic_vector(unsigned(Divide_Loss) / 14);
    AverageLoss2<=AverageLoss_N(N-1 downto 0);

	--Calculation of RS
	RS_1<=std_logic_vector((unsigned(Mux1_out))*100);
    Mux2_out_1 <= std_logic_vector(resize(unsigned(Mux2_out), Mux2_out_1'length));
	RS_2<= std_logic_vector(to_signed(to_integer(signed(RS_1+1) / signed(Mux2_out_1+1)),RS_2'Length));
	RS<=RS_2(N-1 downto 0);
	
    --Calculation of RSI
	
	RSI_1<=RS+100;
	RSI_2<=std_logic_vector(10000/ unsigned(RSI_1) );
	RSI<=std_logic_vector(100-unsigned(RSI_2)) when (Zi='1' or gt1='1')  else (others=>'0') ;
	RSI_Dout <= RSI;
	 
	 
	Eg<='1' when (gt1='1' or zi='1') else '0';
	Buy <="01" when  (Rsi_prev>=30 and rsi<30) else (others=>'0'); 
    Sell <="10" when  (Rsi_prev<=70 and rsi>70) else (others=>'0'); 


--    --Dout <= order_buy when (buy='1') else order_sell;
    sel_out <= Buy & Sell   when (gt1='1')  else (others=>'0');
    with sel_out select 
      Dout <=  Buy when  "0100",
               Sell when "0010",
              (others => '0') when others;
	
	

end arch;
