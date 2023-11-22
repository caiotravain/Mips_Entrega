library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_control is


  port   (
    -- Input ports
    funct, opcode:  in STD_LOGIC_VECTOR(5 downto 0);

    Tipo_R  : in  std_logic;

	 ULA_ctrl :  out STD_LOGIC_VECTOR ( 3 downto 0)
  );
end entity;


architecture arch_name of ula_control is

signal SAIDA_OPCODE : STD_LOGIC_VECTOR ( 3 downto 0);
signal SAIDA_FUNCT : STD_LOGIC_VECTOR ( 3 downto 0);

begin


op_ctrl:  entity work.op_code_dec
        port map( opcode => opcode,
                 ULA_ctrl =>SAIDA_OPCODE);

funct_ctrl:  entity work.funct_dec
        port map( funct => funct,
                 ULA_ctrl =>SAIDA_FUNCT);
					  
ULA_ctrl <= SAIDA_OPCODE when Tipo_r = '0' else SAIDA_FUNCT;

end architecture;
