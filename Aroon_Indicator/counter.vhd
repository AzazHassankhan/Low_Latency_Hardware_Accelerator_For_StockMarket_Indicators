library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- up counter
entity countern is
	generic (N : integer := 4);
	port ( 	  
		clk : in std_logic;
		rst : in std_logic;
	    ld 	: in std_logic;
	    en 	: in std_logic; 
		input  : in std_logic_vector(N-1 downto 0);
        output : out std_logic_vector(N-1 downto 0)
	);
end countern;

architecture up of countern is
	signal temp : std_logic_vector(N-1 downto 0);
begin
	
	process( clk )
	begin
		if rising_edge( clk ) then
			if (rst = '1') then
				temp <= (others => '0');
			elsif (ld = '1') then
				temp <= input;
			elsif ( en = '1' ) then
				temp <= temp + 1;
			end if;
		end if;
	end process;  
	output <= temp;
end up;


