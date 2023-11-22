library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is


  port   (
    -- Input ports
    Vem1  :  in  std_logic;
    A  : in  std_logic;
    B     : in  std_logic;


    -- Output ports
    Soma :  out std_logic ;
	 vai1 :  out std_logic 
  );
end entity;


architecture arch_name of full_adder is



begin

Soma <= vem1 xor (A xor B);
vai1 <= (A and B) or ((A xor B) and Vem1);

end architecture;
