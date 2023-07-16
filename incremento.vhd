library ieee;
use ieee.std_logic_1164.all;

entity incremento is
    port(
        entrada: in std_logic_vector(3 downto 0);  -- Entrada de 4 bits
        resultado: out std_logic_vector(3 downto 0);  -- Resultado incrementado de 4 bits
        carryOut: out std_logic;  -- Saída de carry
        flagOverflow: out std_logic  -- Sinal de flag de overflow
    );
end incremento;

architecture behavioral of incremento is
    component FA4bits is
        port(
            A, B: in std_logic_vector(3 downto 0);  -- Entradas do somador de 4 bits
            Cin: in std_logic;  -- Carry de entrada do somador
            S: out std_logic_vector(3 downto 0);  -- Saída da soma do somador
            Cout, Overflow: out std_logic  -- Saídas de carry e flag de overflow do somador
        );
    end component;
begin

    -- Instanciação do componente FA4bits
    -- Conecta as entradas e saídas do componente aos sinais
    -- A entrada "0000" representa um valor constante para a segunda entrada do componente FA4bits
    -- O valor '1' representa um valor constante para a entrada de carryIn do componente FA4bits
    add1: FA4bits port map(entrada, "0000", '1', resultado, carryOut, flagOverflow);

end behavioral;
