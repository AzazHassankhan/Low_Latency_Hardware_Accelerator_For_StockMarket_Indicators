library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity RAM is
Generic 
(     
	addr_width  	: integer := 2;  -- Address is 2 bits
    data_width   	: integer := 8   -- Data is 8 bits
    -- 2^Addr_width * data_width = 2^2 * 8 RAM = 4 * 8 RAM => 4 Memory Locations each having 8 bits of data
);
Port
(
	 ADDR: in std_logic_vector(addr_width-1 downto 0); 
	 DIN: in std_logic_vector(data_width-1 downto 0);
	 WE: in std_logic; 
	 CLK: in std_logic; 
	 DOUT: out std_logic_vector(data_width-1 downto 0)
);
end RAM;

architecture arch of RAM is

	type ram_array is array (0 to 2**9-1) of std_logic_vector (data_width-1 downto 0);
	signal ram_memory : ram_array := (others => (others => '0'));  -- All memory locations initialze with 0
begin
	process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(WE='1') then 
				ram_memory(conv_integer(ADDR)) <= DIN;
			end if;
		end if;
	end process;
			   	DOUT <= ram_memory(conv_integer(ADDR));
end arch;