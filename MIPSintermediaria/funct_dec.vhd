library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity funct_dec is
	port (
		-- Input ports
		funct : in std_logic_vector(5 downto 0);
		ULA_ctrl : out std_logic_vector (3 downto 0)
	);
end entity;
architecture arch_name of funct_dec is
	constant OP_AND : std_logic_vector(5 downto 0) := "100100";
	constant OP_OR : std_logic_vector(5 downto 0) := "100101";
	constant OP_NOR : std_logic_vector(5 downto 0) := "100111";

	constant OP_ADD : std_logic_vector(5 downto 0) := "100000";
	constant OP_SUB : std_logic_vector(5 downto 0) := "100010";
	constant OP_SLT : std_logic_vector(5 downto 0) := "101010";

begin

	ULA_ctrl <= "0000" when funct = OP_AND else
		"0001" when funct = OP_OR else
		"1100" when funct = OP_NOR else
		"0010" when funct = OP_ADD else
		"0110" when funct = OP_SUB else
		"0111" when funct = OP_SLT else
		"0000";
end architecture;