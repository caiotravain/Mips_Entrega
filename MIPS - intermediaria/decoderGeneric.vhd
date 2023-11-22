library ieee;
use ieee.std_logic_1164.all;

entity decoderGeneric is
  port ( entrada : in std_logic_vector(5 downto 0);
         saida : out std_logic_vector(14 downto 0)
  );
end entity;

architecture comportamento of decoderGeneric is

  constant LW   : std_logic_vector(5 downto 0) := "100011";
  constant SW   : std_logic_vector(5 downto 0) := "101011";
  constant BEQ  : std_logic_vector(5 downto 0) := "000100";
  CONSTANT r  : std_logic_vector(5 downto 0) := "000000";
  CONSTANT JUMP : std_logic_vector(5 downto 0) := "000010";
  
  
  
  
  
  begin
saida <= LW & "0011"  & "0"&  "1010" when entrada = LW else
         SW & "0001" & "0"& "1001" when entrada = SW else
			BEQ & "0000" & "0"& "1100" when entrada = BEQ else
			R & "0110" & "1"& "0000" when entrada = R else
			JUMP & "1000" & "0"& "0000" when entrada = JUMP else
         "000000000000000";  -- NOP para os entradas Indefinidas
end architecture;