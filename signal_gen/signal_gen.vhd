--===========================================================================--
--===============================  VHDL  ====================================--
--===========================================================================--
--                                                                           --
-- FILE NAME:     signal_gen.vhd                                             --
--                                                                           --
-- DATE:          4/17/2012                                                  --
--                                                                           --
-- DESIGNER:      Samir Silbak                                               --
--                                                                           --
-- DESCRIPTION:   signal generator                                           --
--                                                                           --
--                                                                           --
--===========================================================================--
--===============================  VHDL  ====================================--
--===========================================================================--

library ieee;
library work;
use ieee.std_logic_1164.all;

--===========================================================================--
--===============================  I/O Ports  ===============================--
--===========================================================================--

entity signal_gen is 
    port(
        reset_n         : in std_logic;
        clock           : in std_logic;
        signal_out      : out std_logic
    );
end signal_gen;
        
--===========================================================================--
--=============================  Main Function  =============================--
--===========================================================================--

architecture rtl of signal_gen is

    signal shift_reg    : std_logic_vector (22 downto 0);

begin

    generate_sig : process(reset_n, clock)
    begin
        if(reset_n = '0')
        then 
            shift_reg   <= (others => '1');
            signal_out  <= '0';
        elsif rising_edge(clock)
        then
            shift_reg(22 downto 1) <= shift_reg(21 downto 0);       -- shift bits one unit to left
            shift_reg(0)    <= (shift_reg(17) xor shift_reg(22));   -- xor bit 18 and 23 and feed it back in input
            signal_out      <= shift_reg(22);
        end if;
    end process;

end rtl;

