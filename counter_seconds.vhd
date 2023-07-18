library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity counter_seconds is
    generic(t_max : integer := 100000000); 
    port(CLOCK_50: in std_logic;
    counter_out: out unsigned(3 downto 0) := "0000"
    );
end counter_seconds;

architecture behavioral of counter_seconds is

signal counter_temp: unsigned(3 downto 0) := "0000";

begin
    counter_label: process (CLOCK_50)
    variable slow_clock: integer range t_max downto 0 := 0;
    begin
       if (CLOCK_50'event and CLOCK_50='1') then
        if (slow_clock <= t_max) then
            slow_clock := slow_clock + 1;
        else
            counter_temp <= counter_temp + 1;
            slow_clock := 0;
        
        end if;
       end if;
    end process;
    counter_out <= counter_temp;
end behavioral;
