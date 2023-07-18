library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity placa is
    port(
        OPERATOR: in std_logic_vector(2 downto 0); -- Seleção do operador
        CLOCK_50: in std_logic; -- Sinal de clock de 50 MHz
        G_HEX0: out std_logic_vector(6 downto 0); -- Saída para o display de 7 segmentos
        RESULT: out std_logic_vector(7 downto 0) -- Saída para o resultado e as bandeiras
    );
end placa;

architecture behavioral of placa is
    signal counterAux: unsigned(3 downto 0) := "0000"; -- Sinal para o contador auxiliar
    signal counter: std_logic_vector(3 downto 0) := "0000"; -- Sinal para o contador
    signal flagCarry, flagNegativo, flagZero, flagOverflow: std_logic; -- Sinais para as bandeiras
    signal resultOp: std_logic_vector(3 downto 0); -- Sinal para o resultado da operação
    signal const: std_logic_vector(3 downto 0); -- Sinal para a constante utilizada

    component counter_seconds is
        port (
            CLOCK_50: in std_logic;
            counter_out: out unsigned(3 downto 0) := "0000"
        );
    end component;

    component decoder7seg is
        port (
            entrada: in std_logic_vector(3 downto 0) := "0000";
            numeroDisplay: out std_logic_vector(6 downto 0)
        );
    end component;

    component ula is
        port (
            entrada1, entrada2: in std_logic_vector(3 downto 0);
            operador: in std_logic_vector(2 downto 0);
            result: out std_logic_vector(3 downto 0);
            flagCarry, flagNegativo, flagZero, flagOverflow: out std_logic
        );
    end component;

begin
    -- Contador
    counter0: counter_seconds port map(CLOCK_50, counterAux);
    counter <= std_logic_vector(counterAux);

    -- Constante
    const <= "0010";

    -- ULA
    calculo: ula port map(counter, const, OPERATOR, resultOp, flagCarry, flagNegativo, flagZero, flagOverflow);

    -- Decodificador de 7 segmentos
    decoder0: decoder7seg port map(counter, G_HEX0);

    -- Saídas
    RESULT(3 downto 0) <= resultOp;
    RESULT(4) <= flagOverflow;
    RESULT(5) <= flagCarry;
    RESULT(6) <= flagZero;
    RESULT(7) <= flagNegativo;  

end behavioral;
