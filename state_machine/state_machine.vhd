--===========================================================================--
--===============================  VHDL  ====================================--
--===========================================================================--
--                                                                           --
-- FILE NAME:     state_machine.vhd                                          --
--                                                                           --
-- DATE:          4/20/2011                                                  --
--                                                                           --
-- DESIGNER:      Samir Silbak                                               --
--                                                                           --
-- DESCRIPTION:   state machine                                              --
--                                                                           --
--===========================================================================--
--===============================  VHDL  ====================================--
--===========================================================================--

library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--===========================================================================--
--===============================  I/O Ports  ===============================--
--===========================================================================--

entity state_mach is
    generic(
        time_out    : integer   := 2**27     -- maximum counter for board
        --time_out    : integer   := 2**3      -- maximum counter for simulation
    );
    port(
        reset_n     : in std_logic;
        clock       : in std_logic;
        led         : out std_logic_vector (3 downto 0)
    );
end state_mach;

--===========================================================================--
--=============================  Main Function  =============================--
--===========================================================================--

architecture rtl of state_mach is

signal  reset_time_out  : std_logic := '0';
signal  timer           : integer range 0 to time_out;

type led_single_state is (
                 state_0, 
                 state_1,
                 state_2
             );
signal led_state    : led_single_state;
    
begin
    state_machine : process(reset_n, clock)
    begin
        -- button is now pressed
        if(reset_n = '0') then
            led (0 to 2)     <= (others => '0');    -- initialize all leds off
            reset_time_out  <= '1';                 -- set reset timer flag high so we start timer at 0
            led_state <= state_0;                   -- button is pressed, start machine state
            timer <= 0;
            -- once clock is high...
        elsif rising_edge(clock) then
            -- start led machine state
            case led_state is                       

--==============================  First State  ==============================--

                when state_0 =>
                    led(0)  <= '1';                  -- turn first led on
                    if(reset_time_out = '1') then    -- reset the timer back to 0 
                        timer <= 0;                  -- since timer has resetted, we set the reset timer flag low
                        reset_time_out  <= '0';
                    elsif (timer = time_out) then    -- once timer has reached maximum count
                        led(0)  <= '0';              -- turn first led off
                        reset_time_out <= '1';       -- restart the timer
                        led_state <= state_1;        -- move to the next state
                    else
                        timer <= timer + 1;          -- if timer has not reached maximum count
                    end if;                          -- then keep counting, go back to original state (line is not necessary - ease of readability)

--=============================  Second State  ==============================--

                when state_1 =>
                    led(1)  <= '1';                  -- turn second led on
                    if(reset_time_out = '1') then    -- reset the timer back to 0
                        timer <= 0;                  -- since timer has been resetted, we set the reset timer flag low
                        reset_time_out  <= '0';
                    elsif(timer = time_out) then     -- once timer has reached maximum count
                        led(1)  <= '0';              -- turn second led off
                        reset_time_out <= '1';       -- restart the timer
                        led_state <= state_2;        -- move to the next state
                    else
                        timer <= timer + 1;          -- if timer has not reached maximum count
                    end if;                          -- then keep counting, go back to original state (line is not necessary - ease of readability)

--==============================  Third State  ==============================--

                when state_2 =>
                    led(2)  <= '1';                  -- turn third led on
                    if(reset_time_out = '1') then    -- reset the timer back to 0
                        timer <= 0;                  -- since timer has been resetted, we set the reset timer flag low
                        reset_time_out  <= '0';                                                                                                    
                        led_state <= state_2;        -- go back to original state
                    elsif(timer = time_out) then     -- once timer has reached maximum count
                        led(2)  <= '0';              -- turn third led off
                        reset_time_out <= '1';       -- restart the timer
                        led_state <= state_0;        -- move to the next state
                    else                                                                                                                           
                        timer <= timer + 1;          -- if timer has not reached maximum count
                    end if;                          -- then keep counting, go back to original state (line is not necessary - ease of readability)
            end case;
        end if;
    end process;
end rtl;
