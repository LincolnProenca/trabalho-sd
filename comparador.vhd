library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity comparador is
    Port (       
        a: in std_logic_vector(3 downto 0); -- Entrada de 4 bits a
        b: in std_logic_vector(3 downto 0); -- Entrada de 4 bits b
        resultado: out std_logic_vector(3 downto 0) -- Saída de 4 bits resultado
    );
end comparador;

architecture behavioral of comparador is
    signal aux1, aux2, aux3: std_logic; 

begin

-- Verifica se a é igual a b
aux1 <= (a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) xnor b(1)) and (a(0) xnor b(0));

-- Verifica se a é maior que b
aux2 <= ((not a(3)) and b(3)) or ((a(3) xnor b(3)) and ((not b(2)) and a(2))) or ((a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) and (not b(1)))) or ((a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) xnor b(1)) and (not b(0)) and a(0));

resultado(0) <= aux1; -- a = b 
resultado(1) <= (aux1 nor aux2); -- a < b
resultado(2) <= aux2; -- a > b
resultado(3) <= '0';

end behavioral;
