library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity placa is
	port(
		OPERATOR: in std_logic_vector(2 downto 0);
        CLOCK_50: in std_logic;
        G_HEX0: out std_logic_vector(6 downto 0);
		RESULT: out std_logic_vector(7 downto 0);
	);
end placa;

architecture behavioral of placa is
	signal counter: unsigned(3 downto 0) := "0000";
    signal const: std_logic_vector(3 downto 0);

    component counter_seconds is
        port(CLOCK_50: in std_logic;
        counter_out: out unsigned(3 downto 0) := "0000"
        );
    end component;

    component decoder7seg is
        port (
            bcd_in: in unsigned(3 downto 0) := "0000";
            seven_seg_out: out std_logic_vector(6 downto 0)
        );
    end component;

	component ula
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			operador: in std_logic_vector(2 downto 0);
			result: out std_logic_vector(3 downto 0);
			flagCarry, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;

begin
	counter0: counter_seconds port map(CLOCK_50, counter);

	const <= "0010";

	calculo: ula port map(counter, const, OPERATOR, result, flagCarry, flagNegativo, flagZero, flagOverflow);

    decoder0: decoder7seg port map(counter, G_HEX0);
	
    RESULT(3 downto 0) <= result;
    RESULT(4) <= flagOverflow;
    RESULT(5) <= flagCarry;
    RESULT(6) <= flagZero;
    RESULT(7) <= flagNegativo;	
	
end behavioral;