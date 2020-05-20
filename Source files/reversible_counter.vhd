library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rev_counter is
	port (
	range_px: in std_logic_vector(9 downto 0);
	initial_px : in std_logic_vector(9 downto 0);
	cup: in std_logic;
	cdn: in std_logic;
	clock: in std_logic;
	rst: in std_logic;
	q: out std_logic_vector(9 downto 0));
end rev_counter;

architecture behave of rev_counter is
begin
count: process(cup, cdn, rst, clock)
variable temp: std_logic_vector(9 downto 0) := initial_px;
	   begin	 	
		   if rst='1' then
			   temp := initial_px;
		   elsif(clock'event and clock='1' and cup='1')	then
			   temp := temp + 1;
			   if (temp = range_px)then
				   temp := "0000000000";   
			   end if;
		   elsif(clock'event and clock='1' and cdn='1')	then
			   temp := temp - 1;
			   if (temp = "0000000000")then
				   temp := range_px - 1;
			   end if;
		   end if;
		   q <= temp;
		end process; 
end architecture;
		   
