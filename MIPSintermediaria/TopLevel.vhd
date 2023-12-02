
library ieee;
use ieee.std_logic_1164.all;

entity TopLevel is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 32;
        larguraEnderecos : natural := 32;
        simulacao : boolean := False -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
        CLOCK_50 : in std_logic;
        KEY : in std_logic_vector(3 downto 0);
        UC : out std_logic_vector(5 downto 0);
        saida : out std_logic_vector(larguraDados-1 downto 0);
        pc_out : out std_logic_vector(larguraEnderecos-1 downto 0);
        SW : in std_logic_VECTOR(9 DOWNTO 0);
        LEDR : out std_logic_vector(9 downto 0);
        HEX0 : out std_logic_vector(6 downto 0);
        HEX1 : out std_logic_vector(6 downto 0);
        HEX2 : out std_logic_vector(6 downto 0);
        HEX3 : out std_logic_vector(6 downto 0);
        HEX4 : out std_logic_vector(6 downto 0);
        HEX5 : out std_logic_vector(6 downto 0);
	saida_final : out std_logic_vector(larguraEnderecos-1 downto 0);
	end_final : out std_logic_vector(4 downto 0);
	end_1 : out std_logic_vector(4 downto 0);
	habilita_end : out std_logic
  );
end entity;


architecture arquitetura of TopLevel is
        signal CLK : std_logic;
        signal Saida_rom : std_logic_vector(larguraEnderecos-1 downto 0);
        signal entra_soma_constante : std_logic_vector(larguraEnderecos-1 downto 0);
        signal saida_soma_constante_EX_MEM : std_logic_vector(larguraEnderecos-1 downto 0);
        signal Saida_soma_constante : std_logic_vector(larguraEnderecos-1 downto 0);
        signal saida_soma_constante_final : std_logic_vector(larguraEnderecos-1 downto 0);
        signal Endereco_reg0 : std_logic_vector(4 downto 0);
        signal rt : std_logic_vector(4 downto 0);
        signal rd : std_logic_vector(4 downto 0);
        signal saida_mux_banco : std_logic_vector(4 downto 0);
        signal saida_mux_banco_entrada: std_logic_vector(4 downto 0);
        signal saida_mux_banco_final: std_logic_vector(4 downto 0);


        signal saida_mux_ram: std_logic_vector(larguraDados-1 downto 0);
        signal dado_saida_reg0 : std_logic_vector(larguraDados-1 downto 0);
        signal dado_saida_reg1_EX_MEM : std_logic_vector(larguraDados-1 downto 0);
        signal dado_saida_reg1 : std_logic_vector(larguraDados-1 downto 0);
        signal saida_mux_B : std_logic_vector(larguraDados-1 downto 0);
        signal saida_ula :  std_logic_vector(larguraDados-1 downto 0);
        signal saida_ula_entrada :  std_logic_vector(larguraDados-1 downto 0);

        signal saida_ram :  std_logic_vector(larguraDados-1 downto 0);
        signal extende_signal :  std_logic_vector(larguraDados-1 downto 0);
        signal LUI :  std_logic_vector(larguraDados-1 downto 0);
        signal LUI_saida_ex :  std_logic_vector(larguraDados-1 downto 0);
        signal LUI_saida_MEM :  std_logic_vector(larguraDados-1 downto 0);
        signal saida_soma_beq :  std_logic_vector(larguraDados-1 downto 0);
        signal imediato_jump :  std_logic_vector(larguraDados-1 downto 0);
        signal Endereco_rom : std_logic_vector(larguraEnderecos-1 downto 0);
        
        signal saida_mux_final :  std_logic_vector(larguraDados-1 downto 0);
        signal saida_decoder:  std_logic_vector(19 downto 0);

        signal signal_beq : std_logic;
        signal saida_zULA : std_logic;
        
        signal BEQ : std_logic;
        signal BNE : std_logic;
        signal JR : std_logic;

        signal RE : std_logic;
        signal WR : std_logic;
        signal habilita : std_logic;
        signal habilita_final : std_logic;
        signal out_habilita : std_logic;
        signal SEL_ula_mem : std_logic_vector(1 downto 0);
        signal SEL_ula_mem_entrada : std_logic_vector(1 downto 0); 
        signal SEL_rt_imed : std_logic;
        signal SEL_rt_rd : std_logic;
        signal SEL_beq_jmp : std_logic;                                
                                
        signal in_if_id:  std_logic_vector(63 downto 0);
        signal out_if_id:  std_logic_vector(63 downto 0);
        signal in_id_ex:  std_logic_vector(189 downto 0);
        signal out_id_ex:  std_logic_vector(189 downto 0);

        signal in_ex_mem:  std_logic_vector(172 downto 0);
        signal out_ex_mem:  std_logic_vector(172 downto 0);

        signal in_mem_wb:  std_logic_vector(135 downto 0);
        signal out_mem_wb:  std_logic_vector(135 downto 0);

        signal saida_mux_beq_bne : std_logic;


begin

-- Instanciando os componentes:

-- Para simular, fica mais simples tirar o edgeDetector
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;


					  
		  
Parte_if:  entity work.parte_IF generic map (larguraDados => 32)
        port map( 
       imediato_jump => imediato_jump ,
		 SEL_beq_jmp => SEL_beq_jmp ,
		 saida_soma_beq => out_ex_mem(102 downto 71),
		 entrada_registrador => dado_saida_reg0,
		 JR => JR,
		 Saida_soma_constante => entra_soma_constante ,
		 signal_beq => signal_beq,
		 CLK => CLK ,
       Saida_rom => Saida_rom,
		 Endereco_rom => Endereco_rom
		);	
	
	
in_if_id <= saida_rom & entra_soma_constante ;




reg_if_id : entity work.registradorGenerico   generic map (larguraDados => 64)
          port map (DIN => in_if_id, DOUT => out_if_id, ENABLE => '1', CLK => CLK, RST => '0');		
		  

	

	
		
Parte_ID: entity work.Parte_ID
        generic map (
                larguraDados => 32 -- Specify your generic values here if needed
        )
        port map (
            -- Map your signals to the corresponding ports
                Saida_rom => out_if_id(63 downto 32),
                entra_soma_constante => out_if_id(31 downto 0),
                saida_mux_banco => saida_mux_banco_final,
                saida_mux_ram => saida_mux_ram,
                CLK => CLK,
                Endereco_reg0 => Endereco_reg0,
                habilita => habilita_final,
                saida_a => dado_saida_reg0,
                saida_b => dado_saida_reg1,
                extende_signal => extende_signal,
                lui => lui,
                rt => rt,
                rd => rd,
                JR => JR,
                saida_decoder => saida_decoder,
                imediato_jump => imediato_jump ,
                saida_soma_constante => Saida_soma_constante			
);
	
end_final<=saida_mux_banco_final;
end_1<=Endereco_reg0;
SEL_beq_jmp  <= saida_decoder(18);
		  
		  
in_id_ex <=  lui & extende_signal & dado_saida_reg0 & dado_saida_reg1 & rt & rd &    
        saida_decoder  & Saida_soma_constante;

reg_id_ex : entity work.registradorGenerico   generic map (larguraDados => 190)
        port map (DIN => in_id_ex, DOUT => out_id_ex, ENABLE => '1', CLK => CLK, RST => '0');		
        
-- parte 3					
parte_EX: entity work.parte_EX
        generic map (
            larguraDados => 32 -- Specify your generic values here if needed
        )
        port map (
            -- Map your signals to the corresponding ports
                dado_saida_reg0 => out_id_ex( 125 downto 94),
                dado_saida_reg1 => out_id_ex(93 downto 62),
                extende_signal => out_id_ex(157 downto 126),
                saida_decoder => out_id_ex(51 downto 32),
                saida_soma_constante => out_id_ex(31 downto 0),
                rd => out_id_ex(56 downto 52),
                rt => out_id_ex(61 downto 57),
                lui_entrada => out_id_ex(189 downto 158),
                saida_zULA => saida_zULA,
                saida_soma_beq => saida_soma_beq,
                saida_mux_banco => saida_mux_banco_entrada,
                saida_ula => saida_ula_entrada,
                wr => WR,
                re => RE,
                habilita => habilita,
                sel_ula_mem => SEL_ula_mem_entrada,
                saida_soma_constante_EX_MEM => saida_soma_constante_EX_MEM,
                dado_saida_reg1_EX_MEM => dado_saida_reg1_EX_MEM,
                lui_saida => lui_saida_ex,
                beq => BEQ,
                bne =>BNE
);

		  

in_ex_mem <=  BNE & lui_saida_ex & saida_ula_entrada & saida_mux_banco_entrada & saida_soma_beq &
                 saida_soma_constante_EX_MEM & dado_saida_reg1_EX_MEM &
                  SEL_ula_mem_entrada & BEQ & WR 
                  & RE & habilita & saida_zULA;

reg_ex_mem : entity work.registradorGenerico   generic map (larguraDados => 173)
        port map (DIN => in_ex_mem, DOUT => out_ex_mem, ENABLE => '1', CLK => CLK, RST => '0');
				  

parte_MEM: entity work.parte_MEM
generic map (
    larguraDados => 32 -- Specify your generic values here if needed
)	
port map (
        -- Map your signals to the corresponding ports
        clk => CLK,
        Saida_soma_constante => out_ex_mem(70 downto 39),
        saida_soma_beq => out_ex_mem(102 downto 71),
        saida_mux_banco_entrada => out_ex_mem(107 downto 103),
        sel_ula_mem => out_ex_mem(6 downto 5),
        signal_beq => signal_beq,
        saida_ula => out_ex_mem(139 downto 108),
        saida_zULA => out_ex_mem(0),
        dado_saida_reg1 => out_ex_mem(38 downto 7),	  
        entrada_lui => out_ex_mem(171 downto 140),
        WR => out_ex_mem(3),
        RE => out_ex_mem(2),
        BEQ => out_ex_mem(4),
        habilita => out_ex_mem(1),
        BNE => out_ex_mem(172),
        saida_mux_banco => saida_mux_banco,
        out_habilita => out_habilita,
        sel_ula_mem_saida => SEL_ula_mem,
        saida_ram => saida_ram,
        lui_saida => lui_saida_MEM,
        saida_ula_saida => saida_ula,
        saida_soma_constante_final => saida_soma_constante_final,
        saida_mux_beq_bne => saida_mux_beq_bne
);
         
--parte 5
in_mem_wb <= saida_soma_constante_final & lui_saida_MEM & saida_mux_banco  & saida_ram &
        out_habilita & SEL_ula_mem & saida_ula;

reg_mem_wb : entity work.registradorGenerico   generic map (larguraDados => 136)
        port map (DIN => in_mem_wb, DOUT => out_mem_wb, ENABLE => '1', CLK => CLK, RST => '0');

parte_WB: entity work.parte_WB
generic map (
    larguraDados => 32 -- Specify your generic values here if needed
)
port map (
        -- Map your signals to the corresponding ports
        clk => CLK,
        saida_ula =>out_mem_wb(31 downto 0),
        saida_mux_banco => out_mem_wb(71 downto 67),
        saida_ram => out_mem_wb(66 downto 35),
        SEL_ula_mem => out_mem_wb(33 downto 32),
        habilita => out_mem_wb(34),
        lui_entrada =>out_mem_wb(103 downto 72),
        saida_soma_constante_final => out_mem_wb(135 downto 104),
        saida_mux_ram => saida_mux_ram,
        saida_mux_banco_final => saida_mux_banco_final,
        habilita_final => habilita_final
);
	
habilita_end <= habilita_final;

saida_final <=saida_mux_ram;
              
--- end of instanciation

-- Mux to control the output on the displays
mux_final:  entity work.muxGenerico4x1 
generic map (larguraDados => 32)
port map( 
        entradaA_MUX => Endereco_rom,
        entradaB_MUX =>  out_id_ex(31 downto 0),
        entradaC_MUX =>  saida_ula_entrada,
        entradaD_MUX =>  saida_mux_ram,
        seletor_MUX => SW(1 downto 0),
        saida_MUX => saida_mux_final
);				  
	
-- Control display with SW1 and SW0 to visualize the following:
-- SW1 = 0 and SW0 = 0 -> display PC
-- SW1 = 0 and SW0 = 1 -> display ULA output
-- SW1 = 1 and SW0 = 0 -> display PC at EX + 4
-- SW1 = 1 and SW0 = 1 -> Write to WB (phase 5)

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

-- Display the control signals in the LEDs
LEDR(8) <= saida_mux_beq_bne;
			  
LEDR(9) <= saida_zULA;

UC <= Saida_rom(31 downto 26);
saida <= saida_ula;

pc_out <= Endereco_rom;

end architecture;