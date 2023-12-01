library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is


  port   (
    -- Input ports
    entrada:  in STD_LOGIC_VECTOR(31 downto 0);
	   HEX0 :  out    STD_LOGIC_VECTOR(6 downto 0);
		HEX1 :  out    STD_LOGIC_VECTOR(6 downto 0);
		HEX2 :   out   STD_LOGIC_VECTOR(6 downto 0);
		HEX3 :  out    STD_LOGIC_VECTOR(6 downto 0);
      HEX4 :  out    STD_LOGIC_VECTOR(6 downto 0);
	   HEX5 :  out    STD_LOGIC_VECTOR(6 downto 0); 
		LED3_0  : out STD_LOGIC_VECTOR(3 downto 0); 
		LED7_4  :out STD_LOGIC_VECTOR(3 downto 0) 
  );
end entity;


architecture arch_name of display is



begin

					  
DECODER7SEG0:  entity work.conversorHex7Seg
        port map(dadoHex => entrada(3 downto 0),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX0);		
					  
					  
DECODER7SEG1:  entity work.conversorHex7Seg
        port map(dadoHex => entrada(7 downto 4),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX1);		
					  
DECODER7SEG2:  entity work.conversorHex7Seg
        port map(dadoHex => entrada(11 downto 8),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX2);							  
					  
DECODER7SEG3:  entity work.conversorHex7Seg
        port map(dadoHex => entrada(15 downto 12),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX3);	
					 
					
					  
DECODER7SEG4:  entity work.conversorHex7Seg
        port map(dadoHex => entrada(19 downto 16),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX4);		
					  
					  
DECODER7SEG5:  entity work.conversorHex7Seg
        port map(dadoHex => entrada(23 downto 20),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX5);		
			
			
LED3_0 <= entrada(27 downto 24);

LED7_4 <= entrada(31 downto 28);
					  							
end architecture;
