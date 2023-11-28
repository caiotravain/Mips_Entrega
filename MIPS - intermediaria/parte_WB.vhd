library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parte_WB is
    generic (
        larguraDados : natural := 8
    );
    port (
        clk : in std_logic;
        saida_ula : in std_logic_vector(larguraDados-1 downto 0);
        saida_mux_banco : in std_logic_vector(4 downto 0);
        saida_ram : in std_logic_vector(larguraDados-1 downto 0);
        SEL_ula_mem : in std_logic;
        habilita : in std_logic;

        saida_mux_ram : out std_logic_vector(larguraDados-1 downto 0);
        saida_mux_banco_final : out std_logic_vector(4 downto 0);
        habilita_final : out std_logic
        


        );
end entity;

architecture comportamento of parte_WB is

begin

    saida_mux_banco_final <= saida_mux_banco;
    habilita_final <= habilita;
				  
	
    Mux_saida_ram:  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => saida_ula,
                 entradaB_MUX =>  saida_ram,
                 seletor_MUX =>SEL_ula_mem ,
                 saida_MUX => saida_mux_ram);	
                 

end architecture;