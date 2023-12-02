library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Biblioteca IEEE para funções aritméticas

entity ULASomaSub is
	generic (larguraDados : NATURAL := 4);
	port (
		entradaA, entradaB : in STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
		inverte_B : in STD_LOGIC;
		inverte_A : in STD_LOGIC;

		seletor : in STD_LOGIC_VECTOR(1 downto 0);
		saida : out STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
		saida_z : out STD_LOGIC
	);
end entity;

architecture comportamento of ULASomaSub is
	signal soma : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
	signal subtracao : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
	signal vai1_0 : STD_LOGIC;
	signal vai1_1 : STD_LOGIC;
	signal vai1_2 : STD_LOGIC;
	signal vai1_3 : STD_LOGIC;
	signal vai1_4 : STD_LOGIC;
	signal vai1_5 : STD_LOGIC;
	signal vai1_6 : STD_LOGIC;
	signal vai1_7 : STD_LOGIC;
	signal vai1_8 : STD_LOGIC;
	signal vai1_9 : STD_LOGIC;
	signal vai1_10 : STD_LOGIC;
	signal vai1_11 : STD_LOGIC;
	signal vai1_12 : STD_LOGIC;
	signal vai1_13 : STD_LOGIC;
	signal vai1_14 : STD_LOGIC;
	signal vai1_15 : STD_LOGIC;
	signal vai1_16 : STD_LOGIC;
	signal vai1_17 : STD_LOGIC;
	signal vai1_18 : STD_LOGIC;
	signal vai1_19 : STD_LOGIC;
	signal vai1_20 : STD_LOGIC;
	signal vai1_21 : STD_LOGIC;
	signal vai1_22 : STD_LOGIC;
	signal vai1_23 : STD_LOGIC;
	signal vai1_24 : STD_LOGIC;
	signal vai1_25 : STD_LOGIC;
	signal vai1_26 : STD_LOGIC;
	signal vai1_27 : STD_LOGIC;
	signal vai1_28 : STD_LOGIC;
	signal vai1_29 : STD_LOGIC;
	signal vai1_30 : STD_LOGIC;
	signal overflow : STD_LOGIC;
begin
	ula_bit0 : entity work.ula_1bit
		port map(
			Vem1 => inverte_B,
			A => entradaA(0),
			B => entradaB(0),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => overflow,
			selecao => seletor,
			resultado => saida(0),
			vai1 => vai1_0);
	ula_bit1 : entity work.ula_1bit
		port map(
			Vem1 => vai1_0,
			A => entradaA(1),
			B => entradaB(1),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(1),
			vai1 => vai1_1);
	ula_bit2 : entity work.ula_1bit
		port map(
			Vem1 => vai1_1,
			A => entradaA(2),
			B => entradaB(2),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(2),
			vai1 => vai1_2);

	ula_bit3 : entity work.ula_1bit
		port map(
			Vem1 => vai1_2,
			A => entradaA(3),
			B => entradaB(3),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(3),
			vai1 => vai1_3);

	ula_bit4 : entity work.ula_1bit
		port map(
			Vem1 => vai1_3,
			A => entradaA(4),
			B => entradaB(4),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(4),
			vai1 => vai1_4);

	ula_bit5 : entity work.ula_1bit
		port map(
			Vem1 => vai1_4,
			A => entradaA(5),
			B => entradaB(5),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(5),
			vai1 => vai1_5);
	ula_bit6 : entity work.ula_1bit
		port map(
			Vem1 => vai1_5,
			A => entradaA(6),
			B => entradaB(6),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(6),
			vai1 => vai1_6);

	ula_bit7 : entity work.ula_1bit
		port map(
			Vem1 => vai1_6,
			A => entradaA(7),
			B => entradaB(7),
			inverte_A => inverte_A,
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(7),
			vai1 => vai1_7);
	ula_bit8 : entity work.ula_1bit
		port map(
			Vem1 => vai1_7,
			A => entradaA(8),
			B => entradaB(8),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(8),
			vai1 => vai1_8);

	ula_bit9 : entity work.ula_1bit
		port map(
			Vem1 => vai1_8,
			A => entradaA(9),
			B => entradaB(9),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(9),
			vai1 => vai1_9);

	ula_bit10 : entity work.ula_1bit
		port map(
			Vem1 => vai1_9,
			A => entradaA(10),
			B => entradaB(10),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(10),
			vai1 => vai1_10);

	ula_bit11 : entity work.ula_1bit
		port map(
			Vem1 => vai1_10,
			A => entradaA(11),
			B => entradaB(11),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(11),
			vai1 => vai1_11);

	ula_bit12 : entity work.ula_1bit
		port map(
			Vem1 => vai1_11,
			A => entradaA(12),
			B => entradaB(12),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(12),
			vai1 => vai1_12);

	ula_bit13 : entity work.ula_1bit
		port map(
			Vem1 => vai1_12,
			A => entradaA(13),
			B => entradaB(13),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(13),
			vai1 => vai1_13);

	ula_bit14 : entity work.ula_1bit
		port map(
			Vem1 => vai1_13,
			A => entradaA(14),
			B => entradaB(14),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(14),
			vai1 => vai1_14);
	ula_bit15 : entity work.ula_1bit
		port map(
			Vem1 => vai1_14,
			A => entradaA(15),
			B => entradaB(15),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(15),
			vai1 => vai1_15);

	ula_bit16 : entity work.ula_1bit
		port map(
			Vem1 => vai1_15,
			A => entradaA(16),
			B => entradaB(16),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(16),
			vai1 => vai1_16);
	ula_bit17 : entity work.ula_1bit
		port map(
			Vem1 => vai1_16,
			A => entradaA(17),
			B => entradaB(17),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(17),
			vai1 => vai1_17);
	ula_bit18 : entity work.ula_1bit
		port map(
			Vem1 => vai1_17,
			A => entradaA(18),
			B => entradaB(18),
			inverte_A => inverte_A,
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(18),
			vai1 => vai1_18);
	ula_bit19 : entity work.ula_1bit
		port map(
			Vem1 => vai1_18,
			A => entradaA(19),
			B => entradaB(19),
			inverte_A => inverte_A,
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(19),
			vai1 => vai1_19);
	ula_bit20 : entity work.ula_1bit
		port map(
			Vem1 => vai1_19,
			A => entradaA(20),
			B => entradaB(20),
			inverte_A => inverte_A,
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(20),
			vai1 => vai1_20);
	ula_bit21 : entity work.ula_1bit
		port map(
			Vem1 => vai1_20,
			inverte_A => inverte_A,
			A => entradaA(21),
			B => entradaB(21),
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(21),
			vai1 => vai1_21);
	ula_bit22 : entity work.ula_1bit
		port map(
			Vem1 => vai1_21,
			A => entradaA(22),
			inverte_A => inverte_A,
			B => entradaB(22),
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(22),
			vai1 => vai1_22);
	ula_bit23 : entity work.ula_1bit
		port map(
			Vem1 => vai1_22,
			A => entradaA(23),
			inverte_A => inverte_A,
			B => entradaB(23),
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(23),
			vai1 => vai1_23);
	ula_bit24 : entity work.ula_1bit
		port map(
			Vem1 => vai1_23,
			A => entradaA(24),
			inverte_A => inverte_A,
			B => entradaB(24),
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(24),
			vai1 => vai1_24);
	ula_bit25 : entity work.ula_1bit
		port map(
			Vem1 => vai1_24,
			A => entradaA(25),
			B => entradaB(25),
			inverte_A => inverte_A,
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(25),
			vai1 => vai1_25);

	ula_bit26 : entity work.ula_1bit
		port map(
			Vem1 => vai1_25,
			A => entradaA(26),
			B => entradaB(26),
			inverte_A => inverte_A,
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(26),
			vai1 => vai1_26);
	ula_bit27 : entity work.ula_1bit
		port map(
			Vem1 => vai1_26,
			A => entradaA(27),
			B => entradaB(27),
			inverte_A => inverte_A,
			inverte_B => inverte_B,
			SLT => '0',
			selecao => seletor,
			resultado => saida(27),
			vai1 => vai1_27);

	ula_bit28 : entity work.ula_1bit
		port map(
			Vem1 => vai1_27,
			A => entradaA(28),
			B => entradaB(28),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(28),
			vai1 => vai1_28);

	ula_bit29 : entity work.ula_1bit
		port map(
			Vem1 => vai1_28,
			A => entradaA(29),
			B => entradaB(29),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(29),
			vai1 => vai1_29);

	ula_bit30 : entity work.ula_1bit
		port map(
			Vem1 => vai1_29,
			A => entradaA(30),
			B => entradaB(30),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			selecao => seletor,
			resultado => saida(30),
			vai1 => vai1_30);

	ula_bit31 : entity work.ula_1bit_31
		port map(
			Vem1 => vai1_30,
			A => entradaA(31),
			B => entradaB(31),
			inverte_B => inverte_B,
			inverte_A => inverte_A,
			SLT => '0',
			overflow => overflow,
			selecao => seletor,
			resultado => saida(31)
		);
	saida_z <= '1' when unsigned(saida) = 0 else
		'0';
end architecture;