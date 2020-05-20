library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity image_source is 
	port(
	clock: in std_logic;
	reset: in std_logic;
	img_e: in std_logic;
	pos_x: in std_logic_vector(9 downto 0); 
	pos_y: in std_logic_vector(9 downto 0);
	up, down, left, right: in std_logic; 
	p_sel: in std_logic_vector(1 downto 0);
	c_sel: in std_logic_vector(1 downto 0);
	rgb:  out std_logic_vector(7 downto 0)
	);
end image_source; 

architecture behave of image_source is

signal offset_x: std_logic_vector(9 downto 0) ;
signal offset_y: std_logic_vector(9 downto 0) ;	 
signal pixel_x:  std_logic_vector(9 downto 0) ;
signal pixel_y:  std_logic_vector(9 downto 0) ;
signal debounced_up:    std_logic;
signal debounced_down:  std_logic;
signal debounced_left:  std_logic;
signal debounced_right: std_logic;

component image_graph
	port(
	img_e:            in std_logic;
	pixel_x, pixel_y: in std_logic_vector(9 downto 0);
	c_sel:            in std_logic_vector(1 downto 0);
	p_sel:            in std_logic_vector(1 downto 0);
	rgb:             out std_logic_vector(7 downto 0));
end component; 

component rev_counter
	port (
	range_px:    in std_logic_vector(9 downto 0);
	initial_px : in std_logic_vector(9 downto 0);
	cup:         in std_logic;
	cdn:         in std_logic;
	clock:       in std_logic;
	rst:         in std_logic;
	q:          out std_logic_vector(9 downto 0));
end component;

component debouncer is
	port (
	data: in std_logic;
	clock : in std_logic;
	op_data : out std_logic);
end component ;

component ten_bit_a 
 port ( 
 modulo: in std_logic_vector(9 downto 0);
 a :     in std_logic_vector(9 downto 0);
 b :     in std_logic_vector(9 downto 0);
 s :    out std_logic_vector(9 downto 0));	  
end component;

begin		  
	
	PIX_MAP:   image_graph port map( img_e, pixel_x, pixel_y, c_sel, p_sel, rgb);
	DEB_UP:    debouncer   port map( up,    clock, debounced_up   );
	DEB_DOWN:  debouncer   port map( down,  clock, debounced_down );
	DEB_LEFT:  debouncer   port map( left,  clock, debounced_left );
	DEB_RIGHT: debouncer   port map( right, clock, debounced_right);
	C_X:       rev_counter port map( "1010000000", "0101000000", debounced_left, debounced_right, clock, reset, offset_x);
	C_Y:       rev_counter port map( "0111100000", "0011110000", debounced_up,   debounced_down,  clock, reset, offset_y);
	ADD_X:     ten_bit_a   port map( "1010000000", pos_x, offset_x, pixel_x);
	ADD_Y:     ten_bit_a   port map( "0111100000", pos_y, offset_y, pixel_y);
	
end architecture;