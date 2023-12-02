library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity parte_MEM is
	generic (
		larguraDados : natural := 8
	);
	port (
		CLK : in std_logic;
		Saida_soma_constante : in std_logic_vector(larguraDados - 1 downto 0);
		saida_soma_beq : in std_logic_vector(larguraDados - 1 downto 0);
		saida_ula : in std_logic_vector(larguraDados - 1 downto 0);
		dado_saida_reg1 : in std_logic_vector(larguraDados - 1 downto 0);
		WR : in std_logic;
		RE : in std_logic;
		habilita : in std_logic;
		BEQ, BNE : in std_logic;
		saida_mux_banco_entrada : in std_logic_vector(4 downto 0);
		sel_ula_mem : in std_logic_vector(1 downto 0);
		entrada_lui : in std_logic_vector(larguraDados - 1 downto 0);
		saida_zULA : in std_logic;
		signal_beq : out std_logic;
		saida_ram : out std_logic_vector(larguraDados - 1 downto 0);
		out_habilita : out std_logic;
		sel_ula_mem_saida : out std_logic_vector(1 downto 0);
		saida_mux_banco : out std_logic_vector(4 downto 0);
		imediato_jump : out std_logic_vector(31 downto 0);
		lui_saida : out std_logic_vector(larguraDados - 1 downto 0);
		saida_soma_constante_final : out std_logic_vector(larguraDados - 1 downto 0);
		saida_ula_saida : out std_logic_vector(larguraDados - 1 downto 0);
		saida_mux_beq_bne : out std_logic
	);
end entity;

architecture comportamento of parte_MEM is
	signal saida_mux_beq_bne_signal : std_logic;

begin

	saida_soma_constante_final <= Saida_soma_constante;

	RAM : entity work.RAMMIPS
		port map(Endereco => saida_ula, we => WR, re => RE, habilita => '1', dado_in => dado_saida_reg1, dado_out => saida_ram, clk => CLK);

	saida_mux_beq_bne_signal <= saida_zULA when (BEQ = '1') else
		not (saida_zUla);
	lui_saida <= entrada_lui;
	out_habilita <= habilita;
	saida_ula_saida <= saida_ula;
	saida_mux_banco <= saida_mux_banco_entrada;
	sel_ula_mem_saida <= sel_ula_mem;
	signal_beq <= (BEQ or BNE) and saida_mux_beq_bne_signal;

	saida_mux_beq_bne <= saida_mux_beq_bne_signal;

end architecture;