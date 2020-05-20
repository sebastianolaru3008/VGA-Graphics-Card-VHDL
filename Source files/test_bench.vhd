library ieee;
use ieee.std_logic_1164.all;	  
use ieee.std_logic_textio.all;
use std.textio.all;

entity test is 
end test;	

architecture behave of test is

component graphic_card  
	port( 
	MASTER_RESET: in std_logic;
	MASTER_CLOCK: in std_logic;
	h_sync:      out std_logic;
	v_sync:      out std_logic;
	up, down, left, right: in std_logic;
	p_sel:   in std_logic_vector(1 downto 0);
	c_sel:   in std_logic_vector(1 downto 0);
	rgb:    out std_logic_vector(7 downto 0));
end component; 

signal MASTER_RESET: std_logic := '0';
signal clk: std_logic;
signal h_sync:       std_logic;
signal v_sync:       std_logic;
signal up: std_logic := '0'; 
signal down: std_logic := '0'; 
signal left: std_logic := '0'; 
signal right: std_logic := '0';
signal p_sel:   std_logic_vector(1 downto 0);
signal c_sel:   std_logic_vector(1 downto 0);
signal rgb:     std_logic_vector(7 downto 0);	

constant clk_period : time := 40 ns;

begin
	
	GFK_CRD: graphic_card port map(MASTER_RESET, clk, h_sync, v_sync, up, down, left, right, p_sel, c_sel, rgb);
	
	signals_proc: process
	begin 
		c_sel <= "00"; 
		p_sel <= "00";
		up <= '1'; 
		wait for 16672000 ns;
		up <= '0';
		right <= '1'; 
		wait for 16672000 ns;
		right <= '0'; 
		down <= '1';
		wait for 16672000 ns;
		down <= '0';
		left <= '1'; 
		wait for 16672000 ns;
		left <= '0';
		
		
		
	end process;
	
	clk_proc: process
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
	end process;
	
	process (clk)
	    file file_pointer: text is out "write.txt";
	    variable line_el: line;
		begin
	
		    if rising_edge(clk) then
		
		        -- Write the time
		        write(line_el, now); -- write the line.
		        write(line_el, ":"); -- write the line.
		
		        -- Write the hsync
		        write(line_el, " ");
		        write(line_el, h_sync); -- write the line.
		
		        -- Write the vsync
		        write(line_el, " ");
		        write(line_el, v_sync); -- write the line.
		
		        -- Write the red
		        write(line_el, " ");
		        write(line_el, rgb(7 downto 5)); -- write the line.
		
		        -- Write the green
		        write(line_el, " ");
		        write(line_el, rgb(4 downto 2)); -- write the line.	 
		
		        -- Write the blue
		        write(line_el, " ");
		        write(line_el, rgb(1 downto 0)); -- write the line.	
		
		        writeline(file_pointer, line_el); -- write the contents into the file.
		
		    end if;
	end process;
	
end architecture;