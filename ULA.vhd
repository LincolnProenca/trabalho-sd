library ieee;
use ieee.std_logic_1164.all;

entity ula is
	port(
		entrada1, entrada2: in std_logic_vector(3 downto 0);
		operador: in std_logic_vector(2 downto 0);
		result: out std_logic_vector(3 downto 0);
		flagCarry, flagNegativo, flagZero, flagOverflow: out std_logic
	);
end ula;

architecture behavioral of ula is
	signal resultFinal, resultadoSoma, resultadoSubtracao, resultadoIncremento, resultadoCA2 : std_logic_vector(3 downto 0);
	signal resultadoAnd, resultadoComparador, resultadoMultiplicacao, resultadoQuadrado: std_logic_vector(3 downto 0);
	signal carrySoma, carrySubtracao, carryIncremento: std_logic;
	signal overflowSoma, overflowSubtracao, overflowIncremento, overflowMultiplicacao, overflowQuadrado: std_logic;
	signal notEntrada2: std_logic_vector(3 downto 0);

	component incremento
		Port(
			entrada: in std_logic_vector(3 downto 0);
			resultado: out std_logic_vector(3 downto 0);
			carryOut: out std_logic;
			flagOverflow: out std_logic
		);
	end component;

	component comparador is
  	 	 Port ( 
      	        a: in std_logic_vector(3 downto 0);
         		b: in std_logic_vector(3 downto 0);
			resultado: out std_logic_vector(3 downto 0)
    		 );
	end component;

	component FA4bits is
        Port (
            A: in STD_LOGIC_VECTOR(3 downto 0);
            B: in STD_LOGIC_VECTOR(3 downto 0);
            Cin: in STD_LOGIC;
            S: out STD_LOGIC_VECTOR(3 downto 0);
            Cout: out STD_LOGIC;
            Overflow: out STD_LOGIC
        );
	end component;

	component CA2 is
        Port(
            input: in std_logic_vector(3 downto 0);
            output: out std_logic_vector(3 downto 0)
        );
	end component;

    component multiplier is 
        Port (
            x: in  std_logic_vector(3 downto 0);
            y: in  std_logic_vector(3 downto 0);
            overflow: out std_logic;
            p: out std_logic_vector(3 downto 0)
        );
	end component;

begin
	notEntrada2 <= not entrada2;

	soma: FA4bits port map(entrada1, entrada2, '0', resultadoSoma, carrySoma, overflowSoma);
	subtracao: FA4bits port map(entrada1, notEntrada2, '1', resultadoSubtracao, carrySubtracao, overflowSubtracao);
	incremento1: incremento port map(entrada1, resultadoIncremento, carryIncremento, overflowIncremento);
	ComplementoA2: CA2 port map(entrada1, resultadoCA2);
	resultadoAnd <= entrada1 and entrada2;
	compara: comparador port map(entrada1,entrada2,resultadoComparador);
	multiplica: multiplier port map(entrada1,entrada2,overflowMultiplicacao,resultadoMultiplicacao);
	quadrado: multiplier port map(entrada1,entrada1,overflowQuadrado,resultadoQuadrado);

	with operador select
		resultFinal <= resultadoSoma          when "000",
    			       resultadoSubtracao     when "001",
    			       resultadoIncremento    when "010",
    			       resultadoCA2           when "011",
    			       resultadoAnd           when "100",
    			       resultadoComparador    when "101",
    			       resultadoMultiplicacao when "110",
    			       resultadoQuadrado      when "111",
    			       "0000"                 when others;

	result <= resultFinal;

	with operador select
		flagCarry <= carrySoma               when "000",
					 carrySubtracao          when "001",
					 carryIncremento         when "010",
					 '0'                     when others;

	flagNegativo <= resultFinal(3);
	flagZero <= not(resultFinal(3) or resultFinal(2) or resultFinal(1) or resultFinal(0));

	with operador select
		flagOverflow <= overflowSoma          when "000",
		                overflowSubtracao     when "001",
						overflowIncremento    when "010",
					    overflowMultiplicacao when "110",
						overflowQuadrado      when "111",
					    '0'                   when others;
end behavioral;