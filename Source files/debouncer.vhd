library ieee;
use ieee.std_logic_1164.ALL;
 
entity debouncer is
	port (
	data: in std_logic;
	clock : in std_logic;
	op_data : out std_logic);
end debouncer ;
 
architecture behave of debouncer is
signal op1, op2, op3, op4, op5: std_logic;
begin
	process(clock)
	begin
		if (clock'event and clock = '1') then
			op1 <= DATA;
			op2 <= op1;
			op3 <= op2;
			op4 <= op3;
			op5 <= op4;
		end if;
 	end process;
 
op_data <= op1 and op2 and op3 and op4 and op5;
 
end behave;
