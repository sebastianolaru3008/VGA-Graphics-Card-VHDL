library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity controller_vga is
	port (
	clock:   in std_logic;
	reset:   in std_logic;
	img_e:  out std_logic;
	h_sync: out std_logic;
	v_sync: out std_logic;
	pos_x:  out std_logic_vector(9 downto 0);
	pos_y:  out std_logic_vector(9 downto 0));
end controller_vga;

architecture behave of controller_vga is

signal tmp_pos_x, tmp_pos_y : std_logic_vector(9 downto 0);
signal t : std_logic_vector(0 to 3);
signal q : std_logic_vector(0 to 3) := "1111";
signal reset_h, reset_v : std_logic := '0';

component counter
	port (
	clk: in std_logic;
	rst: in std_logic;
	q:  out std_logic_vector(9 downto 0);
	ce:  in std_logic);
end component;

component t_flip_flop
	port (
	t:    in std_logic;
	clk:  in std_logic;
	rst:  in std_logic;
	q:   out std_logic;
	n_q: out std_logic);
end component;

begin
	
COUNTER_H: counter port map(clock, reset_h, tmp_pos_x, '1');
COUNTER_V: counter port map(clock, reset_v, tmp_pos_y, reset_h);


OUTPUT: process(tmp_pos_x, tmp_pos_y)
variable x_pos, y_pos : std_logic;
	
begin
if (tmp_pos_x >= "0000000000" and tmp_pos_x <= "1001111111") then
	x_pos := '1';																
else
	x_pos := '0';
end if;	
if (tmp_pos_y >= "0000000000" and tmp_pos_y <= "0111011111") then
	y_pos := '1';
else
	y_pos := '0';
end if;	 



if (tmp_pos_x >= "1010001111" and tmp_pos_x <= "1011101111") then
	h_sync <= '0';
else
	h_sync <= '1';
end if;	
if (tmp_pos_y >= "0111101001" and tmp_pos_y <= "0111101011") then
	v_sync <= '0';
else
	v_sync <= '1';
end if;

if (tmp_pos_x = "1100011111") then
	reset_h <= '1';
else
	reset_h <= '0';
end if;
if (tmp_pos_y = "1000001000") then
	reset_v <= '1';
else
	reset_v <= '0';
end if;

img_e <= x_pos and y_pos;
pos_x <= tmp_pos_x;
pos_y <= tmp_pos_y;
end process;


end behave;







	