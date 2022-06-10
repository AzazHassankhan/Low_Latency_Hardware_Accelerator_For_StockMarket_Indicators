library ieee;
use ieee.std_logic_1164.all;

-- controller
entity controller is
	port( 	  
		-- inputs	
		clk : in std_logic;
		rst : in std_logic;
		Go 	: in std_logic; 
		Zi  : in std_logic; 
		Zj  : in std_logic; 
		Zk  : in std_logic; 
		gt1 : in std_logic; 
		gt2 : in std_logic; 
		gt3 : in std_logic; 
		Zmax : in std_logic; 

		-- outputs
		S1 : out std_logic; 
		S2 : out std_logic; 
		S3 : out std_logic; 
		S4 : out std_logic; 
		Li : out std_logic; 
		Ei : out std_logic; 
		EA : out std_logic; 
		EB : out std_logic; 
		EC : out std_logic; 
		ED : out std_logic; 
		Zwrite : out std_logic; 
		esum : out std_logic; 
		Done : out std_logic;
		Csel_1 : out std_logic; 
		Csel_2 : out std_logic;
		Csel_3 : out std_logic
	);
end controller;

architecture arch of controller is

	type y is ( S_waiting, S_loading, S_counting, S_done);
	signal state : y;  
	
begin

	process(clk)
	begin
		if (rising_edge (clk)) then
			if(rst = '1') then		-- Synchronous reset (active low)
				state <= S_waiting;
			else
				case (state) is
					when S_waiting => 
						if (Go = '1') then
							state <= S_loading;
						else
							state <= S_waiting;
						end if;
						
					when S_loading => 
						state <= S_counting;

					when S_counting => 
						if (Zi = '1') then
							if (Zmax = '1') then
								state<= S_done;
							else
								state<= S_counting;
						    end if;
						else
							if (gt1 = '1') then
								if (Zmax = '1') then
									state<= S_done;
								else
									state<= S_counting;
								end if;	
							else
								if (Zmax = '1') then
									state<= S_done;
								else
									state<= S_counting;
								end if;	
							end if;
						end if;
						
						if (Zj = '1') then
							if (Zmax = '1') then
								state<= S_done;
							else
								state<= S_counting;
						    end if;
						else
							if (gt2 = '1') then
								if (Zmax = '1') then
									state<= S_done;
								else
									state<= S_counting;
								end if;	
							else
								if (Zmax = '1') then
									state<= S_done;
								else
									state<= S_counting;
								end if;	
							end if;
						end if;
						
						if (Zk = '1') then
							if (Zmax = '1') then
								state<= S_done;
							else
								state<= S_counting;
						    end if;
						else
							if (gt3 = '1') then
								if (Zmax = '1') then
									state<= S_done;
								else
									state<= S_counting;
								end if;	
							else
								if (Zmax = '1') then
									state<= S_done;
								else
									state<= S_counting;
								end if;	
							end if;
						end if;
					
					when S_done =>
						state <= S_done;
						
				    when others =>
				        state <= S_waiting;
				end case;	
			end if;
		end if;	
    end process;
	
	-- control signals 
    Li <= '1' when (state = S_waiting) else '0'; 
    Ei <= '1' when (state = S_loading) or (state = S_counting) else '0'; 
    EA <= '1' when (state = S_counting) else '0'; 
    EB <= '1' when (state = S_counting) else '0'; 
    EC <= '1' when (state = S_counting) else '0'; 
    ED <= '1' when (state = S_counting) else '0'; 
    S1 <= '1' when (state = S_loading or state = S_counting) else '0'; 
    S2 <= '1' when (state = S_counting and Zi = '1') else '0'; 
    S3 <= '1' when (state = S_counting and Zj = '1') else '0'; 
    S4 <= '1' when (state = S_counting and Zk = '1') else '0'; 
    esum <= '1' when (state = S_counting or state = S_loading) else '0'; 
    Zwrite <= '1' when (state = S_counting) else '0'; 
    Csel_1 <= '1' when (state = S_counting and Zi = '0' and gt1 = '1') else '0'; 
    Csel_2 <= '1' when (state = S_counting and Zj = '0' and gt2 = '1') else '0'; 
    Csel_3 <= '1' when (state = S_counting and Zk = '0' and gt3 = '1') else '0'; 
    Done <= '1' when (state = S_done) else '0';

end arch;


