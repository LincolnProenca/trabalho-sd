library ieee;
use ieee.std_logic_1164.all;

entity FA4bits is
    Port (
        A: in STD_LOGIC_VECTOR(3 downto 0);
        B: in STD_LOGIC_VECTOR(3 downto 0);
        Cin: in STD_LOGIC;
        S: out STD_LOGIC_VECTOR(3 downto 0);
        Cout: out STD_LOGIC;
        Overflow: out STD_LOGIC
    );
end FA4bits;

architecture Behavioral of FA4bits is

    -- Declaração do componente Full Adder em VHDL
    component FA
        Port (
            A: in STD_LOGIC;
            B: in STD_LOGIC;
            Cin: in STD_LOGIC;
            S: out STD_LOGIC;
            Cout: out STD_LOGIC
        );
    end component;

    -- Declaração do sinal intermediário de carry
    signal c1, c2, c3, c4: STD_LOGIC;

begin

    -- Mapeamento de portas do Full Adder 4 vezes
    FA1: FA port map(A(0), B(0), Cin, S(0), c1);
    FA2: FA port map(A(1), B(1), c1, S(1), c2);
    FA3: FA port map(A(2), B(2), c2, S(2), c3);
    FA4: FA port map(A(3), B(3), c3, S(3), c4);
    Cout <= c4;
    Overflow <= c3 xor c4;

end Behavioral;
