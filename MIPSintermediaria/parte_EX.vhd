library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parte_EX is
    generic (
        larguraDados : natural := 8
    );
    port (
	 		  lui_entrada : in std_logic_vector(larguraDados-1 downto 0);

        dado_saida_reg1 : in std_logic_vector(larguraDados-1 downto 0);
        dado_saida_reg0 : in std_logic_vector(larguraDados-1 downto 0);
        extende_signal : in std_logic_vector(31 downto 0);
        saida_decoder : in std_logic_vector(19 downto 0);
        rt, rd : in std_logic_vector(4 downto 0);
        Saida_soma_constante : in std_logic_vector(31 downto 0);


		WR, RE, BEQ, Habilita, SEL_beq_jmp, BNE : out std_logic;
        SEL_ula_mem : out std_logic_vector(1 downto 0);
        saida_ula : out std_logic_vector(larguraDados-1 downto 0);
        saida_zULA : out std_logic;
        saida_soma_beq : out std_logic_vector(larguraDados-1 downto 0);
        saida_soma_constante_EX_MEM : out std_logic_vector(31 downto 0);
        dado_saida_reg1_EX_MEM : out std_logic_vector(larguraDados-1 downto 0);
        saida_mux_banco : out std_logic_vector(4 downto 0);
		  entrada_b : out std_logic_vector(larguraDados-1 downto 0);
		  lui_saida : out std_logic_vector(larguraDados-1 downto 0)

        );
end entity;

architecture comportamento of parte_EX is

		  signal Endereco_rom_sig : std_logic_vector(larguraDados-1 downto 0);
		  signal saida_mux_B : std_logic_vector(larguraDados-1 downto 0);
          signal SEL_rt_imed : std_logic;
		  signal SEL_rt_rd : std_logic_vector(1 downto 0);
		  		  signal ORi_ANDi : std_logic;
				  

		  signal ULA_ctrl :  std_logic_vector(3 downto 0);
		  signal extende_signal_beq:  std_logic_vector(larguraDados-1 downto 0);



begin

    saida_soma_constante_EX_MEM <= Saida_soma_constante;
    dado_saida_reg1_EX_MEM <= dado_saida_reg1;
	 lui_saida <= lui_entrada;

    Mux_banco_reg:  entity work.muxGenerico4x1 generic map (larguraDados => 5)
        port map( entradaA_MUX => rt,
                 entradaB_MUX =>  rd,
					  entradac_MUX =>  "11111",
					  entradad_MUX =>  "00000",
                 seletor_MUX => SEL_rt_rd ,
                 saida_MUX => saida_mux_banco);		

				  
				  

Mux_entrada_b:  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => dado_saida_reg1,
                 entradaB_MUX =>  extende_signal,
                 seletor_MUX =>  SEL_rt_imed,
                 saida_MUX => saida_mux_B);	

entrada_b <= dado_saida_reg0;
				  
ULA : entity work.ULASomaSub  generic map(larguraDados => larguraDados)
          port map (entradaA => dado_saida_reg0, entradaB => saida_mux_B , saida => saida_ula, seletor => ULA_ctrl(1 downto 0), saida_z=> saida_zULA, inverte_B=>ULA_ctrl(2),inverte_A=>ULA_ctrl(3));		

			
Soma_beq :  entity work.somadorGenerico  generic map (larguraDados => 32)
        port map( entradaA => Saida_soma_constante, entradaB =>  extende_signal_beq, saida => saida_soma_beq);			 
			 
			 		

ula_control: entity work.ula_control
        port map( opcode => saida_decoder(17 downto 12),
						funct => extende_signal(5 downto 0),
						tipo_r => saida_decoder(6),
                 ULA_ctrl => ULA_ctrl);

                 

extende_signal_beq <= extende_signal(29 downto 0) & "00";				
SEL_rt_imed <= saida_decoder(7)	;
SEL_rt_rd  <= saida_decoder(11 downto 10)	;

		
WR <= saida_decoder(0)	;				  
RE <= saida_decoder(1)	;
BEQ <= saida_decoder(3)	;
BNE <= saida_decoder(2)	;
SEL_ula_mem <= saida_decoder(5 downto 4)	;

				  
Habilita <= saida_decoder(8)		;	
ORi_ANDi		<=	  saida_decoder(9);	
					  

end architecture;