library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity graphic_card is 
	port( 
	MASTER_RESET: in std_logic;
	MASTER_CLOCK: in std_logic;
	h_sync:      out std_logic;
	v_sync:      out std_logic;
	btn: in std_logic_vector(3 downto 0);
	p_sel:   in std_logic_vector(1 downto 0);
	c_sel:   in std_logic_vector(1 downto 0);
	rgb:    out std_logic_vector(7 downto 0));
end graphic_card;

architecture behave of graphic_card is 

component controller_vga is
	port (
	clock:   in std_logic;
	reset:   in std_logic;
	img_e:  out std_logic;
	h_sync: out std_logic;
	v_sync: out std_logic;
	pos_x:  out std_logic_vector(9 downto 0);
	pos_y:  out std_logic_vector(9 downto 0));
end component;

signal clock1: std_logic;
signal clock2: std_logic;
signal img_e: std_logic;
signal pos_x: std_logic_vector(9 downto 0);
signal pos_y: std_logic_vector(9 downto 0);

component image_source 
	port(
	clock: in std_logic;
	reset: in std_logic; 
	img_e: in std_logic;
	btn: in std_logic_vector(3 downto 0);
	pos_x: in std_logic_vector(9 downto 0); 
	pos_y: in std_logic_vector(9 downto 0); 
	p_sel: in std_logic_vector(1 downto 0);
	c_sel: in std_logic_vector(1 downto 0);
	rgb:  out std_logic_vector(7 downto 0));
end component;

component t_flip_flop 
	port (
	clk: in std_logic;
	rst: in std_logic;
	t: in std_logic;
	q: out std_logic;
	n_q: out std_logic);
end component;

begin
	
	FR_D1: t_flip_flop    port map( clk => MASTER_CLOCK, rst => MASTER_RESET, t => '1', q => clock1, n_q => open);
	FR_D2: t_flip_flop    port map( clk => clock1,       rst => MASTER_RESET, t => '1', q => clock2, n_q => open);
	CNTRL: controller_vga port map( clock2, MASTER_RESET, img_e, h_sync, v_sync, pos_x, pos_y); 
	IMG_S: image_source   port map( MASTER_CLOCK, MASTER_RESET, img_e, btn, pos_x, pos_y, p_sel, c_sel, rgb); 
	
end architecture;
	
	
	
	
	
	