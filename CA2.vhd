library ieee;
use ieee.std_logic_1164.all;

entity CA2 is
    port(
        input: in std_logic_vector(3 downto 0);  -- Entrada de um número binário de 4 bits
        output: out std_logic_vector(3 downto 0)  -- Saída do número binário complementado de 4 bits
    );
end CA2;

architecture behavioral of CA2 is
    signal inverso: std_logic_vector(3 downto 0);  -- Sinal para armazenar o complemento bit a bit da entrada

    -- Declaração do componente FA4bits
    component FA4bits is
        port(
            A, B: in std_logic_vector(3 downto 0);  -- Entradas do somador de 4 bits
            Cin: in std_logic;  -- Carry de entrada do somador
            S: out std_logic_vector(3 downto 0);  -- Saída da soma do somador
            Cout, Overflow: out std_logic  -- Saídas de carry e flag de overflow do somador
        );
    end component;

begin
    -- Calcula o complemento bit a bit da entrada
    inverso <= not(input);

    -- Instancia o componente FA4bits
    -- Conecta as entradas e saídas do componente aos sinais
    -- "0000" representa um valor constante para a segunda entrada do componente FA4bits
    -- '1' representa um valor constante para a entrada carryIn do componente FA4bits
    -- As saídas open são deixadas desconectadas
    add1: FA4bits port map(inverso, "0000", '1', output, open, open);

end behavioral;
