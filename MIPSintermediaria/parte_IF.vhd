library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parte_IF is
    generic (
        larguraDados : natural := 8
    );
    port (
	 
		imediato_jump : in std_logic_vector(larguraDados-1 downto 0);
		saida_soma_beq : in std_logic_vector(larguraDados-1 downto 0);
		entrada_registrador : in std_logic_vector(larguraDados-1 downto 0);

		signal_beq, JR : in std_logic;
		
       Saida_rom : out std_logic_vector(larguraDados-1 downto 0);
		  Saida_soma_constante : out std_logic_vector(larguraDados-1 downto 0);
		  Endereco_rom : out std_logic_vector(larguraDados-1 downto 0);
		  
		  saida_prox_pc : out std_logic_vector(larguraDados-1 downto 0);
       CLK, SEL_beq_jmp : in std_logic
        );
end entity;

architecture comportamento of parte_IF is

		  signal Endereco_rom_sig : std_logic_vector(larguraDados-1 downto 0);
		  signal saida_mux_proxpc :  std_logic_vector(larguraDados-1 downto 0);
		  signal saida_soma_sig :  std_logic_vector(larguraDados-1 downto 0);
		  signal Saida_mux_beq:  std_logic_vector(larguraDados-1 downto 0);
		  signal saida_mux_JR:  std_logic_vector(larguraDados-1 downto 0);


begin





---parte 1
ROM_MIPS : entity work.ROMMIPS 
          port map (Endereco => Endereco_rom_sig, Dado => Saida_rom);
			 
			 
-- O port map completo do Program Counter.
PC : entity work.pc_counter   generic map (larguraDados => larguraDados)
      port map (DIN => saida_mux_JR, DOUT => Endereco_rom_sig, ENABLE => '1', CLK => CLK, RST => '0');			 
			 

somaconstante :  entity work.somaConstante  generic map (larguraDados => larguraDados, constante => 4)
        port map( entrada => Endereco_rom_sig, saida =>saida_soma_sig );
		  

mux_proxpc :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => Saida_mux_beq,
                 entradaB_MUX =>  imediato_jump,
                 seletor_MUX => SEL_beq_jmp,
                 saida_MUX => saida_mux_proxpc);
					  
Mux_beq :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => saida_soma_sig,
                 entradaB_MUX =>  saida_soma_beq,
                 seletor_MUX => signal_beq,
                 saida_MUX => Saida_mux_beq);	
					  

mux_JR :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => saida_mux_proxpc,
                 entradaB_MUX =>  entrada_registrador,
                 seletor_MUX => JR,
                 saida_MUX => saida_mux_JR);
					  
					  
saida_prox_pc <= 		saida_mux_proxpc;			  
Endereco_rom <= Endereco_rom_sig;	
Saida_soma_constante <=	saida_soma_sig;			  
end architecture;