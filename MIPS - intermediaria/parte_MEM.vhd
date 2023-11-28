library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parte_MEM is
    generic (
        larguraDados : natural := 8
    );
    port (
        CLK : in std_logic;
        Saida_soma_constante : in std_logic_vector(larguraDados-1 downto 0);
        saida_soma_beq : in std_logic_vector(larguraDados-1 downto 0);
        saida_ula : in std_logic_vector(larguraDados-1 downto 0);
        sel_beq_jmp : in std_logic;
        dado_saida_reg1 : in std_logic_vector(larguraDados-1 downto 0);
        WR : in std_logic;
        RE : in std_logic;
		habilita: in std_logic;
        BEQ: in std_logic;
        saida_mux_banco_entrada: in std_logic_vector(4 downto 0);
        sel_ula_mem : in std_logic;

		saida_zULA : in std_logic;
        sel_beq_jmp_saida : out std_logic;
        signal_beq : out std_logic;
        saida_mux_beq : out std_logic_vector(larguraDados-1 downto 0);
        saida_ram : out std_logic_vector(larguraDados-1 downto 0);
        out_habilita : out std_logic;
        sel_ula_mem_saida : out std_logic;
        saida_mux_banco : out std_logic_vector(4 downto 0);
        imediato_jump : out std_logic_vector(31 downto 0);

		saida_ula_saida : out std_logic_vector(larguraDados-1 downto 0)


        );
end entity;

architecture comportamento of parte_MEM is

begin
    
        out_habilita <= habilita;
        saida_ula_saida <= saida_ula;
        saida_mux_banco <= saida_mux_banco_entrada;
        sel_ula_mem_saida <= sel_ula_mem;
        sel_beq_jmp_saida <= sel_beq_jmp;
		signal_beq <= BEQ and saida_zULA;	
    Mux_beq :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => Saida_soma_constante,
                 entradaB_MUX =>  saida_soma_beq,
                 seletor_MUX => BEQ and saida_zULA,
                 saida_MUX => Saida_mux_beq);	

RAM : entity work.RAMMIPS 
          port map (Endereco => saida_ula, we => WR, re => RE, habilita  => '1', dado_in => dado_saida_reg1, dado_out => saida_ram, clk => CLK);

		


end architecture;