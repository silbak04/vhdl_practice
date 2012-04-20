--===========================================================================--
--===============================  VHDL  ====================================--
--===========================================================================--
--                                                                           --
-- FILE NAME:     full_adder_tb.vhd                                          --
--                                                                           --
-- DATE:          4/12/2011                                                  --
--                                                                           --
-- DESIGNER:      Samir Silbak                                               --
--                                                                           --
-- DESCRIPTION:   test bench for 1-bit full adder                            --
--                                                                           --
--===========================================================================--
--===============================  VHDL  ====================================--
--===========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity fa_test_bench is
end entity fa_test_bench;

architecture test_adder of fa_test_bench is

    component full_adder
        port(
            a           : in  std_logic;
            b           : in  std_logic;
            cin         : in  std_logic;
            s           : out std_logic;
            cout        : out std_logic
        );
    end component;

--===========================================================================--
--===============================  Interface  ===============================--
--===========================================================================--

signal  a           : std_logic;
signal  b           : std_logic;
signal  cin         : std_logic;
signal  s           : std_logic;
signal  cout        : std_logic;

begin

   bit_adder : full_adder
   port map(
        a           => a,
        b           => b,
        cin         => cin,
        s           => s,
        cout        => cout
    );

--===========================================================================--
--===============================  Data Flow  ===============================--
--===========================================================================--

   process
   begin
       -- initialize input signals
       a    <=  '0';
       b    <=  '0';
       cin  <=  '0';  

       wait for 10 ns;
       -- cehck if outputs are correct, else report error
       assert (s = '0') 
       report "incorrect sum value, case 0" severity error;
       assert (cout = '0')
       report "incorrect carry bit value, case 0" severity error;

       wait for 40 ns;
       -- initialize input signals
       a    <=  '0';
       b    <=  '0';
       cin  <=  '1';  

       wait for 10 ns;
       -- check if outputs are correct, elese report error
       assert (s = '1')
       report "incorrect sum value, case 1" severity error;
       assert (cout = '0')
       report "incorrect carry bit value, case 1" severity error;

       wait for 40 ns;
       -- initialize input signals
       a    <=  '0';
       b    <=  '1';
       cin  <=  '0';  

       wait for 10 ns;
       -- check if outputs are correct, elese report error
       assert (s = '1')
       report "incorrect sum value, case 2" severity error;
       assert (cout = '0')
       report "incorrect carry bit value, case 2" severity error;

       wait for 40 ns;
       -- initialize input signals
       a    <=  '0';
       b    <=  '1';
       cin  <=  '1';  

       wait for 10 ns;
       -- check if outputs are correct, elese report error
       assert (s = '0')
       report "incorrect sum value, case 3" severity error;
       assert (cout = '1')
       report "incorrect carry bit value, case 3" severity error;
       
       wait for 40 ns;
       -- initialize input signals
       a    <=  '1';
       b    <=  '0';
       cin  <=  '0';  

       wait for 10 ns;
       -- check if outputs are correct, elese report error
       assert (s = '1')
       report "incorrect sum value, case 4" severity error;
       assert (cout = '0')
       report "incorrect carry bit value, case 4" severity error;

       wait for 40 ns;
       -- initialize input signals
       a    <=  '1';
       b    <=  '0';
       cin  <=  '1';  

       wait for 10 ns;
       -- check if outputs are correct, elese report error
       assert (s = '0')
       report "incorrect sum value, case 5" severity error;
       assert (cout = '1')
       report "incorrect carry bit value, case 5" severity error;

       wait for 40 ns;
       -- initialize input signals
       a    <=  '1';
       b    <=  '1';
       cin  <=  '0';  

       wait for 10 ns;
       -- check if outputs are correct, elese report error
       assert (s = '0')
       report "incorrect sum value, case 6" severity error;
       assert (cout = '1')
       report "incorrect carry bit value, case 6" severity error;

       wait for 40 ns;
       -- initialize input signals
       a    <=  '1';
       b    <=  '1';
       cin  <=  '1';  

       wait for 10 ns;
       -- check if outputs are correct, elese report error
       assert (s = '1')
       report "incorrect sum value, case 7" severity error;
       assert (cout = '1')
       report "incorrect carry bit value, case 7" severity error;

       wait for 40 ns;

   end process;

end test_adder;
