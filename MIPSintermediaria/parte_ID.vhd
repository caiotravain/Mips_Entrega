library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parte_ID is
    generic (
        larguraDados : natural := 8
    );
    port (
	 
		saida_rom : in std_logic_vector(larguraDados-1 downto 0);
        saida_mux_banco : in std_logic_vector(4 downto 0);
		entra_soma_constante : in std_logic_vector(larguraDados-1 downto 0);
		saida_mux_ram : in std_logic_vector(larguraDados-1 downto 0);
		CLK,  habilita : in std_logic;

		opcode : out std_logic_vector(5 downto 0);
        saida_a : out std_logic_vector(larguraDados-1 downto 0);
		saida_b : out std_logic_vector(larguraDados-1 downto 0);
		extende_signal : out std_logic_vector(larguraDados-1 downto 0);
		lui : out std_logic_vector(larguraDados-1 downto 0);
		rt : out std_logic_vector(4 downto 0);
		rd : out std_logic_vector(4 downto 0);
		saida_decoder: out std_logic_vector(19 downto 0);
		imediato : out std_logic_vector(15 downto 0);
		Saida_soma_constante : out std_logic_vector(larguraDados-1 downto 0);
		imediato_jump : out std_logic_vector(larguraDados-1 downto 0);
		Endereco_reg0 : out std_logic_vector(4 downto 0);
		Endereco_reg1 : out std_logic_vector(4 downto 0);
		JR : out std_logic;
		Endereco_reg2 : out std_logic_vector(4 downto 0)

        );
end entity;

architecture comportamento of parte_ID is

		  signal Endereco_rom_sig : std_logic_vector(larguraDados-1 downto 0);
			 signal Endereco_reg0_sig : std_logic_vector(4 downto 0);
			 signal Endereco_reg1_sig : std_logic_vector(4 downto 0);
			 signal Endereco_reg2_sig : std_logic_vector(4 downto 0);

begin



Endereco_reg0 <= Endereco_reg0_sig;
Endereco_reg1 <= Endereco_reg1_sig;
Endereco_reg2 <= Endereco_reg2_sig;

Endereco_reg0_sig <= Saida_rom(25 downto 21);
Endereco_reg1_sig <= Saida_rom(20 downto 16);
Endereco_reg2_sig <= Saida_rom(15 downto 11);

imediato <= Saida_rom(15 downto 0)	;
opcode <= Saida_rom(31 downto 26);
 
imediato_jump <= entra_soma_constante(31 downto 28) & Saida_rom(25 downto 0) & "00";
			  
					  
BANCO_REG :  entity work.bancoReg   generic map (larguraDados => larguraDados, larguraEndBancoRegs => 5)
          port map ( clk => CLK,
              enderecoA => Endereco_reg0_sig,
              enderecoB => Endereco_reg1_sig,
              enderecoC => saida_mux_banco,
              dadoEscritaC => saida_mux_ram,
              escreveC => Habilita,
              saidaA => saida_A,
              saidaB  => saida_B);
				  
extende_signal <= imediato(15) & imediato(15) & imediato(15) & imediato(15) &
					imediato(15) &imediato(15) &imediato(15) &imediato(15) &imediato(15)
					&imediato(15) &imediato(15) &imediato(15) &imediato(15) &imediato(15) 
					&imediato(15) &imediato(15)&imediato(15 downto 0) 	when (saida_decoder(9) = '0') else
					"0000000000000000" & imediato;
					
					
LUI <= imediato & "0000000000000000";
					
					
					  
decoder :  entity work.decoderGeneric
        port map( entrada => Saida_rom(31 downto 26),
						nop => Saida_rom,
                 saida => saida_decoder);

	
rt <= Endereco_reg1_sig;
rd <= Endereco_reg2_sig;


Saida_soma_constante <= entra_soma_constante;
JR <= saida_decoder(19);

end architecture;