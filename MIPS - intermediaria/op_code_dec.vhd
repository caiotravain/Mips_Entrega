library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity op_code_dec is


  port   (
    -- Input ports
    opcode:  in STD_LOGIC_VECTOR(5 downto 0);


	 ULA_ctrl :  out STD_LOGIC_VECTOR (3 downto 0)
  );
end entity;


architecture arch_name of op_code_dec is
  constant LW   : std_logic_vector(5 downto 0) := "100011";
  constant SW   : std_logic_vector(5 downto 0) := "101011";
  constant BEQ  : std_logic_vector(5 downto 0) := "000100";



begin

ULA_ctrl <= "0010" when opcode = LW else
				"0010" when opcode = SW else
				"0110" when opcode = BEQ else
				"0000";
end architecture;
