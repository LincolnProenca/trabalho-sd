library ieee;
use ieee.std_logic_1164.all;

entity multiplier is 
    port (
        x: in  std_logic_vector(3 downto 0);
        y: in  std_logic_vector(3 downto 0);
        overflow: out std_logic;
        p: out std_logic_vector(3 downto 0)
    );
end entity multiplier;

architecture Behavioral of multiplier is
    component FA4bits
        port ( 
            A:      in  std_logic_vector(3 downto 0);
            B:      in  std_logic_vector(3 downto 0);
            Cin:    in  std_logic;
            S:      out std_logic_vector(3 downto 0);
            Cout:   out std_logic;
            Overflow: out STD_LOGIC
        );
    end component;

    -- Termos de produto AND:
    signal G0, G1, G2:  std_logic_vector(3 downto 0);
    -- Entradas B (B0 tem três bits do produto AND)
    signal B0, B1, B2:  std_logic_vector(3 downto 0);
    -- Auxiliar
    signal aux:  std_logic_vector(7 downto 0);

begin

    -- Produtos AND para y(1) até y(3), atribuição por agregados:
    G0 <= (x(3) and y(1), x(2) and y(1), x(1) and y(1), x(0) and y(1));
    G1 <= (x(3) and y(2), x(2) and y(2), x(1) and y(2), x(0) and y(2));
    G2 <= (x(3) and y(3), x(2) and y(3), x(1) and y(3), x(0) and y(3));
    -- Produtos AND para y(0) (e y0(3) como '0'):
    B0 <= ('0', x(3) and y(0), x(2) and y(0), x(1) and y(0));

    -- Associação nomeada:
FA1: 
    FA4bits 
        port map (
            A => G0,
            B => B0,
            Cin => '0',
            Cout => B1(3),  -- Associação nomeada pode estar em qualquer ordem
            S(3) => B1(2),  -- Elementos individuais de S, todos são associados
            S(2) => B1(1),  -- Todos os membros formais devem ser fornecidos de forma contígua
            S(1) => B1(0),
            S(0) => aux(1),
            Overflow => open
        );
FA2: 
    FA4bits 
        port map (
            A => G1,
            B => B1,
            Cin => '0',
            Cout => B2(3),
            S(3) => B2(2),
            S(2) => B2(1),
            S(1) => B2(0),
            S(0) => aux(2),
            Overflow => open
        );
FA3: 
    FA4bits 
        port map (
            A => G2,
            B => B2,
            Cin => '0',
            Cout => aux(7),
            S => aux(6 downto 3),  -- Elementos correspondentes para membros formais
            Overflow => open
        );
    aux(0) <= x(0) and y(0); 
    overflow <= aux(3) xor x(3) xor y(3);
    p <= aux(3 downto 0);
end architecture Behavioral;
