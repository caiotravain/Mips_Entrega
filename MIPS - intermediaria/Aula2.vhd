library ieee;
use ieee.std_logic_1164.all;

entity Aula2 is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 32;
        larguraEnderecos : natural := 32;
        simulacao : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLOCK_50 : in std_logic;
	 KEY : in std_logic_vector(3 downto 0);
	 UC : out std_logic_vector(5 downto 0);
	 saida :out std_logic_vector(larguraDados-1 downto 0);
	 pc_out : out	 std_logic_vector(larguraEnderecos-1 downto 0);
	  SW : in std_logic_VECTOR(9 DOWNTO 0);
	  LEDR : out std_logic_vector(9 downto 0);
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);
    HEX5 : out std_logic_vector(6 downto 0)



  );
end entity;


architecture arquitetura of Aula2 is
		  signal CLK : std_logic;
		  signal Endereco_rom : std_logic_vector(larguraEnderecos-1 downto 0);
		  signal Saida_rom : std_logic_vector(larguraEnderecos-1 downto 0);
		  signal Saida_soma_constante : std_logic_vector(larguraEnderecos-1 downto 0);
		  signal Endereco_reg0 : std_logic_vector(4 downto 0);
		  signal Endereco_reg1 : std_logic_vector(4 downto 0);
		  signal Endereco_reg2 : std_logic_vector(4 downto 0);
		  signal saida_mux_banco : std_logic_vector(4 downto 0);
		  signal saida_mux_ram: std_logic_vector(larguraDados-1 downto 0);
		  signal dado_saida_reg0 : std_logic_vector(larguraDados-1 downto 0);
		  signal dado_saida_reg1 : std_logic_vector(larguraDados-1 downto 0);
		  signal saida_mux_B : std_logic_vector(larguraDados-1 downto 0);
		  signal saida_ula :  std_logic_vector(larguraDados-1 downto 0);
		  signal saida_ram :  std_logic_vector(larguraDados-1 downto 0);
		  signal extende_signal :  std_logic_vector(larguraDados-1 downto 0);
		  signal imediato :std_logic_vector(15 downto 0);
		  signal saida_soma_beq :  std_logic_vector(larguraDados-1 downto 0);
		  signal Saida_mux_beq :  std_logic_vector(larguraDados-1 downto 0);
		  signal extende_signal_beq:  std_logic_vector(larguraDados-1 downto 0);
		  signal imediato_jump :  std_logic_vector(larguraDados-1 downto 0);
		  signal saida_mux_proxpc :  std_logic_vector(larguraDados-1 downto 0);
		  
		  signal saida_mux_final :  std_logic_vector(larguraDados-1 downto 0);
	     signal saida_decoder:  std_logic_vector(14 downto 0);
		  signal opcode:  std_logic_vector(5 downto 0);
		  
		  signal ULA_ctrl :  std_logic_vector(3 downto 0);

		  signal signal_beq : std_logic;
		  signal saida_zULA : std_logic;
		  
		  signal BEQ : std_logic;
		  signal RD : std_logic;
		  signal WR : std_logic;
		  signal habilita : std_logic;
		  
		  signal SEL_ula_mem : std_logic;
		  signal SEL_rt_imed : std_logic;
		  signal SEL_rt_rd : std_logic;
		  signal SEL_beq_jmp : std_logic;


begin

-- Instanciando os componentes:

-- Para simular, fica mais simples tirar o edgeDetector
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;


ROM_MIPS : entity work.ROMMIPS 
          port map (Endereco => Endereco_rom, Dado => Saida_rom);
			 
			 
-- O port map completo do Program Counter.
PC : entity work.pc_counter   generic map (larguraDados => larguraEnderecos)
      port map (DIN => saida_mux_proxpc, DOUT => Endereco_rom, ENABLE => '1', CLK => CLK, RST => '0');			 
			 

somaconstante :  entity work.somaConstante  generic map (larguraDados => larguraEnderecos, constante => 4)
        port map( entrada => Endereco_rom, saida => Saida_soma_constante);
		  
		  
Mux_banco_reg:  entity work.muxGenerico2x1 generic map (larguraDados => 5)
        port map( entradaA_MUX => Endereco_reg1,
                 entradaB_MUX =>  Endereco_reg2,
                 seletor_MUX => SEL_rt_rd ,
                 saida_MUX => saida_mux_banco);		  

		  
Mux_saida_ram:  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => saida_ula,
                 entradaB_MUX =>  saida_ram,
                 seletor_MUX =>SEL_ula_mem ,
                 saida_MUX => saida_mux_ram);						  
					  
					  
					  
BANCO_REG :  entity work.bancoReg   generic map (larguraDados => larguraDados, larguraEndBancoRegs => 5)
          port map ( clk => CLK,
              enderecoA => Endereco_reg0,
              enderecoB => Endereco_reg1,
              enderecoC => saida_mux_banco,
              dadoEscritaC => saida_mux_ram,
              escreveC => Habilita,
              saidaA => dado_saida_reg0,
              saidaB  => dado_saida_reg1);

Mux_entrada_b:  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => dado_saida_reg1,
                 entradaB_MUX =>  extende_signal,
                 seletor_MUX =>  SEL_rt_imed,
                 saida_MUX => saida_mux_B);	


				  
ULA : entity work.ULASomaSub  generic map(larguraDados => larguraDados)
          port map (entradaA => dado_saida_reg0, entradaB => saida_mux_B , saida => saida_ula, seletor => ULA_ctrl(1 downto 0), saida_z=> saida_zULA, inverte_B=>ULA_ctrl(2),inverte_A=>ULA_ctrl(3));		

			 
RAM : entity work.RAMMIPS 
          port map (Endereco => saida_ula, we => WR, re => RD, habilita  => '1', dado_in => dado_saida_reg1, dado_out => saida_ram, clk => CLK);

			 
Soma_beq :  entity work.somadorGenerico  generic map (larguraDados => 32)
        port map( entradaA => Saida_soma_constante, entradaB =>  extende_signal_beq, saida => saida_soma_beq);			 
			 
			 
			 
Mux_beq :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => Saida_soma_constante,
                 entradaB_MUX =>  saida_soma_beq,
                 seletor_MUX => signal_beq,
                 saida_MUX => Saida_mux_beq);

mux_proxpc :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => Saida_mux_beq,
                 entradaB_MUX =>  imediato_jump,
                 seletor_MUX => SEL_beq_jmp,
                 saida_MUX => saida_mux_proxpc);
					  
					  
decoder :  entity work.decoderGeneric
        port map( entrada => opcode,
                 saida => saida_decoder);
					  
	
ula_control: entity work.ula_control
        port map( opcode => saida_decoder(14 downto 9),
						funct => imediato(5 downto 0),
						tipo_r => saida_decoder(4),
                 ULA_ctrl => ULA_ctrl);
					  
					  
mux_final :  entity work.muxGenerico2x1 generic map (larguraDados => 32)
        port map( entradaA_MUX => Endereco_rom,
                 entradaB_MUX =>  saida_ula,
                 seletor_MUX => SW(0),
                 saida_MUX => saida_mux_final);

display :  entity work.display
        port map( entrada => saida_mux_final,
                 HEX0 => HEX0,
					  HEX1 => HEX1,
					  HEX2 => HEX2,
					  HEX3 => HEX3,
					  HEX4 => HEX4,
					  HEX5 => HEX5,
					  LED3_0 => LEDR(3 downto 0),
					  LED7_4 => LEDR(7 downto 4)
					  );			  
					  


		
WR <= saida_decoder(0)	;				  
RD <= saida_decoder(1)	;
BEQ <= saida_decoder(2)	;
SEL_ula_mem <= saida_decoder(3)	;

SEL_rt_imed <= saida_decoder(5)	;					  
Habilita <= saida_decoder(6)		;				  
SEL_rt_rd  <= saida_decoder(7)	;
SEL_beq_jmp  <= saida_decoder(8)	;					  
					  
					  

signal_beq <= BEQ and saida_zULA;
imediato_jump <= Saida_soma_constante(31 downto 28) & Saida_rom(25 downto 0) & "00";
			 
Endereco_reg0 <= Saida_rom(25 downto 21);
Endereco_reg1 <= Saida_rom(20 downto 16);
Endereco_reg2 <= Saida_rom(15 downto 11);

opcode <= Saida_rom(31 downto 26);
		
extende_signal <= imediato(15) & imediato(15) & imediato(15) & imediato(15) &
					imediato(15) &imediato(15) &imediato(15) &imediato(15) &imediato(15)
					&imediato(15) &imediato(15) &imediato(15) &imediato(15) &imediato(15) 
					&imediato(15) &imediato(15)&imediato(15 downto 0);
					
extende_signal_beq <= extende_signal(29 downto 0) & "00";
imediato <= Saida_rom(15 downto 0)	;	
	

	
UC <= Saida_rom(31 downto 26);
saida <= saida_ula;

pc_out <= Endereco_rom;

end architecture;