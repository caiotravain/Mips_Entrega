library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_1bit is


  port   (
    -- Input ports
    SLT  :  in  std_logic;
    A  : in  std_logic;
    B     : in  std_logic;
	 inverte_B, inverte_A    : in  std_logic;
	vem1     : in  std_logic;
	selecao     :  in STD_LOGIC_VECTOR(1 downto 0);

    -- Output ports
    resultado :  out std_logic ;
	 vai1 :  out std_logic 
  );
end entity;


architecture arch_name of ula_1bit is

signal saida_muxb : std_logic;
signal saida_muxa : std_logic;

signal saida_fulladder: std_logic;
signal selecao0 : std_logic;
signal selecao1 : std_logic;
signal selecao2 : std_logic;
signal selecao3 : std_logic;

begin





full_add:  entity work.full_adder
        port map( Vem1 => vem1,
                 A =>  saida_muxa,
                 B =>  saida_muxb,
                 Soma => saida_fulladder,
					  vai1 => vai1);
					  
saida_muxb <= NOT(b) when inverte_B = '1' else B;					  
saida_muxa <= NOT(a) when inverte_A = '1' else A;	
selecao0 <= saida_muxb and saida_muxa;
selecao1 <= saida_muxb or saida_muxa;
selecao2 <= saida_fulladder;
selecao3 <= SLT;

resultado <= selecao0 when (selecao = "00") else
				selecao1 when (selecao = "01") else
				selecao2 when (selecao = "10") else
				selecao3;
end architecture;
