library ieee;
use ieee.std_logic_1164.all;

entity FA is
    Port (
        A: in STD_LOGIC;
        B: in STD_LOGIC;
        Cin: in STD_LOGIC;
        S: out STD_LOGIC;
        Cout: out STD_LOGIC
    );
end FA;

architecture Behavioral of FA is
begin

    -- Saída da soma (S) é calculada usando a operação de OU exclusivo (XOR) entre A, B e Cin
    S <= A XOR B XOR Cin;

    -- Saída de carry (Cout) é calculada usando operações de E (AND) e OU (OR) lógico entre A, B e Cin
    Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B);

end Behavioral;
