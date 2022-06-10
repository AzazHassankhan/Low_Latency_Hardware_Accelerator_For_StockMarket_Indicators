library IEEE;
use IEEE.Std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

USE ieee.std_logic_textio.all;
LIBRARY std;
USE std.textio.all;

entity top_tb is
	generic (N : integer := 20);
end;

architecture bench of top_tb is

  signal clk: std_logic:= '1';
  signal rst: std_logic:= '1';
  signal Go: std_logic:= '0';
  signal We: std_logic;
  signal Din: std_logic_vector(N-1 downto 0);
  signal Dout: std_logic_vector(1 downto 0);
  signal RdAddr: std_logic_vector(N-1 downto 0);
  signal Done: std_logic;
  signal Zwrite : std_logic;
  constant clk_period: time := 10 ns;
		
begin

  -- Insert values for generic parameters !!
  uut: entity work.top generic map ( N => N ) port map ( clk => clk, rst => rst, Go => Go, We => We, RdAddr => RdAddr, Din => Din,  Dout=>Dout, Done => Done);

  -- Clock 
  clk <= not clk after clk_period/2;
  
  stimulus: process
  
  	FILE vectorFile: TEXT OPEN READ_MODE is "MACD_Stock_data.txt"; --file read

    VARIABLE VectorLine: LINE; --line by line access
    VARIABLE space: CHARACTER;
    VARIABLE test_input: integer;
    
    file file_pointer : text;
    variable line_num : line;
          
  begin
  -- hold reset state for 100 ns.
	wait for 10*clk_period;
	rst <= '0';
	We <= '1';
	
	--Open the file write.txt from the specified location for writing(WRITE_MODE).
         file_open(file_pointer,"D:\University Data\FYP Material\FPGA Programs in Vivado\Top Level Designing\MACD_Implementation\MACD_Vivado_Implementation\MACD\Output_file.txt",WRITE_MODE); 
         
	-- insert stimulus here 
	for i in 0 to 199 loop
		readline(vectorFile, VectorLine); -- put file data into line
        read(VectorLine,test_input);
       
		RdAddr <= std_logic_vector(to_unsigned(i, RdAddr'Length));
		Din <= std_logic_vector (to_unsigned(test_input, Din'Length));
		wait for clk_period;
	end loop;

	  We <= '0'; 
	  Go <= '1';  
	
	for i in 0 to 199 loop
		write(line_num,conv_integer(Dout)); --write the line.
        writeline (file_pointer,line_num); --write the contents into the file.
		wait for clk_period;
	end loop;
	
	wait until Done = '1'; 
    wait; 
  end process;
end;
