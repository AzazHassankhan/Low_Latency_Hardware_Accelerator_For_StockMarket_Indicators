library ieee;
use ieee.std_logic_1164.all;

entity reg is
	Generic (N : INTEGER := 16);  -- N will specify the reg bits  
	Port
		(
		-- Input 
		clk : in std_logic;
		rst : in std_logic;
		en  : in std_logic;
		D 	: in std_logic_vector (N-1 downto 0);
		-- Output
		Q 	: out std_logic_vector (N-1 downto 0)
		);
end reg;

architecture arch of reg is
 signal output : std_logic_vector(N-1 downto 0);
 
begin
	process (clk) 
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				output <= (others => '0');  
			elsif (en = '1') then
				output <= D;
			end if;
		end if;
	end process;
	
	Q <= output; 

end arch;
	
		