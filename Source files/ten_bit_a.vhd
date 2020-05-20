library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; 
 
entity ten_bit_a is
 port ( 
 modulo: in std_logic_vector(9 downto 0);
 a : in std_logic_vector(9 downto 0);
 b : in std_logic_vector(9 downto 0);
 s : out std_logic_vector(9 downto 0));
end ten_bit_a;
 
architecture behave of ten_bit_a is

begin
	process (a,b,modulo)
	variable temporary : std_logic_vector(10 downto 0);
	variable temporary_a : std_logic_vector(10 downto 0);
	variable temporary_b : std_logic_vector(10 downto 0);
	variable modul : std_logic_vector(10 downto 0);
	begin 	
		temporary_a(9 downto 0) := a;
		temporary_a(10) := '0';
		temporary_b(9 downto 0) := b;
		temporary_b(10) := '0';
		temporary := temporary_a + temporary_b;
		modul(9 downto 0) := modulo;  
		modul(10) := '0';
		if(temporary < modul) then
			s<=a+b;
		else				 
			temporary := temporary - modul;	
			s <= temporary(9 downto 0);
		end if;
	end process;
end architecture;
