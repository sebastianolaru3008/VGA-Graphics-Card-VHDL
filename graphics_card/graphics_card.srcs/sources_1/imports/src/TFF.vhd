library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity t_flip_flop is
	port (
	t: in std_logic;
	clk: in std_logic;
	rst: in std_logic;
	q: out std_logic;
	n_q: out std_logic);
end t_flip_flop; 

architecture behave of t_flip_flop is

begin 
	process(clk, rst)
	variable tmp: std_logic := '0';
	begin
		if rst='1' then
			tmp := '0';
		elsif (clk'event and clk='1') then
			tmp := t xor tmp;
		end if;
		q <= tmp;
		n_q <= not tmp;
	end process;
end architecture;
	