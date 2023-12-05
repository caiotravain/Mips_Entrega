library ieee;
use ieee.std_logic_1164.all;

entity decoderGeneric is
	port (
		entrada : in  std_logic_vector(5 downto 0);
		nop     : in  std_logic_vector(31 downto 0);
		saida   : out std_logic_vector(19 downto 0)
	);
end entity;

architecture comportamento of decoderGeneric is

	constant LW           : std_logic_vector(5 downto 0)  := "100011";
	constant SW           : std_logic_vector(5 downto 0)  := "101011";
	constant BEQ          : std_logic_vector(5 downto 0)  := "000100";
	constant r            : std_logic_vector(5 downto 0)  := "000000";
	constant JUMP         : std_logic_vector(5 downto 0)  := "000010";
	constant ADDI         : std_logic_vector(5 downto 0)  := "001000";
	constant ANDI         : std_logic_vector(5 downto 0)  := "001100";
	constant ORI          : std_logic_vector(5 downto 0)  := "001101";
	constant SLTI         : std_logic_vector(5 downto 0)  := "001010";
	constant LUI          : std_logic_vector(5 downto 0)  := "001111";
	constant JAL          : std_logic_vector(5 downto 0)  := "000011";
	constant JR           : std_logic_vector(5 downto 0)  := "001000";
	constant BNE          : std_logic_vector(5 downto 0)  := "000101";
	constant nop_esperado : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal funct          : std_logic_vector(5 downto 0);

begin

	funct <= nop(5 downto 0);

	saida <= "00000000000000000000" when nop = nop_esperado else
		"0" & "0" & LW & "00" & "0" & "11" & "0" & "01" & "00" & "10" when entrada = LW else
		"1" & "0" & R & "00" & "0" & "00" & "0" & "00" & "00" & "00" when (entrada = R and funct = JR) else --- JR INSTRUCTION
		"0" & "0" & SW & "00" & "0" & "01" & "0" & "01" & "00" & "01" when entrada = SW else
		"0" & "0" & BEQ & "00" & "0" & "00" & "0" & "01" & "10" & "00" when entrada = BEQ else
		"0" & "0" & BNE & "00" & "0" & "00" & "0" & "01" & "01" & "00" when entrada = BNE else
		"0" & "0" & ADDI & "00" & "0" & "11" & "0" & "00" & "00" & "00" when entrada = ADDI else
		"0" & "0" & ANDI & "00" & "1" & "11" & "0" & "00" & "00" & "00" when entrada = ANDI else
		"0" & "0" & ORI & "00" & "1" & "11" & "0" & "00" & "00" & "00" when entrada = ORI else
		"0" & "0" & SLTI & "00" & "0" & "11" & "0" & "00" & "00" & "00" when entrada = SLTI else
		"0" & "0" & LUI & "00" & "0" & "11" & "0" & "11" & "00" & "00" when entrada = LUI else
		"0" & "0" & R & "01" & "0" & "10" & "1" & "00" & "00" & "00" when entrada = R else -- other R instructions
		"0" & "1" & JUMP & "00" & "0" & "00" & "0" & "00" & "00" & "00" when entrada = JUMP else
		"0" & "1" & JAL & "10" & "0" & "10" & "0" & "10" & "00" & "00" when entrada = JAL else
		"00000000000000000000"; -- NOP para os entradas Indefinidas
end architecture;