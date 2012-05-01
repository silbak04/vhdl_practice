library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity signal_gen_tb is
end entity signal_gen_tb;

architecture test_signal of signal_gen_tb is

    component signal_gen is
        port(
            reset_n         : in std_logic;
            clock           : in std_logic;
            signal_out      : out std_logic
        );
    end component;

constant half_clock_period  : time      :=  4.787 ns;
constant num_bits           : integer   :=  200;

signal  reset_n     : std_logic;
signal  clock       : std_logic;
signal  shift_reg   : std_logic_vector (22 downto 0);
signal  signal_out  : std_logic;

begin


    sq_wave : signal_gen
    port map(
        reset_n     => reset_n,
        clock       => clock,
        signal_out  => signal_out
    );

    gen_clock : process
    begin

        reset_n <= '0';
        wait for 10 ns;
        reset_n <= '1';
        
        for ii in 1 to num_bits loop
            clock <= '0';
            wait for half_clock_period;
            clock <= '1';
            wait for half_clock_period;
        end loop;
        wait;

    end process;
end test_signal;
