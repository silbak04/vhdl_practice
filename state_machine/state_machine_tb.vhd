library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;

entity state_mach_tb is
    end entity state_mach_tb;

architecture test_state of state_mach_tb is

    component state_mach is
        generic(
            time_out    : integer := 2**3       -- defines maximum time
        );
        port(
            reset_n     : in std_logic;
            clock       : in std_logic;
            led         : out std_logic_vector (2 downto 0)
        );
    end component;

    constant half_clock_period  : time      := 4.787 ns;        -- define clock cycle
    constant num_bits           : integer   := 200;             -- number of iterations

    signal reset_n          : std_logic;
    signal clock            : std_logic;
    signal led              : std_logic_vector (2 downto 0);
    signal time_out         : integer := 2**3;      
    signal timer            : integer range 0 to time_out;

begin

    states : state_mach
    port map(
        reset_n         => reset_n,
        clock           => clock,
        led             => led
    );

    gen_clock : process
    begin

        reset_n <= '0';
        wait for 10 ns;
        reset_n <= '1';

        for i in 1 to num_bits loop
            clock <= '0';
            wait for half_clock_period;
            clock <= '1';
            wait for half_clock_period;
        end loop;
    end process;
end test_state;
