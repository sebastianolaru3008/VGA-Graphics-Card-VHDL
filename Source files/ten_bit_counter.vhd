library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
	port ( 
	ce:  in std_logic;
	clk: in std_logic;
	rst: in std_logic;
	q: out std_logic_vector(9 downto 0));
end counter;

architecture behave of counter is

begin
count: process(clk, rst)
		variable temp: std_logic_vector(9 downto 0) := "0000000000";	
	   begin
	   if(clk'event and clk='1')then
		   if rst='1' then
			   temp := "0000000000"; 
		   else
			   if(ce = '1')	then
			   	temp := temp + 1;
				end if;
			end if;
		end if;
		   q <= temp;
		end process;
end architecture;
		   
