----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2021 10:27:28 AM
-- Design Name: 
-- Module Name: tlc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tlc is
    Port (
    clk     :   in  std_logic;
    reset   :   in  std_logic;
    
    south_o :   out std_logic_vector(3 - 1 downto 0);
    west_o  :   out std_logic_vector(3 - 1 downto 0)
    );
end tlc;

architecture Behavioral of tlc is
    type    t_state is (STOP1, WEST_GO, WEST_WAIT, STOP2, SOUTH_GO, SOUTH_WAIT);
    
    signal  s_state :   t_state;
    
    signal  s_en    :   std_logic;
    
    signal  s_cnt   :   std_logic_vector(5 - 1 downto 0);
    
    constant c_DELAY_4SEC   :   unsigned(5 - 1 downto 0)  := b"1_0000";
    constant c_DELAY_2SEC   :   unsigned(5 - 1 downto 0)  := b"0_1000";
    constant c_DELAY_1SEC   :   unsigned(5 - 1 downto 0)  := b"0_0100";
    constant c_ZERO         :   unsigned(5 - 1 downto 0)  := b"0_0000";
begin
    
    e_en : entity work.clock_enable
    generic map(
        g_MAX =>  4000000
    )
    Port map (
        clk         =>  clk,
        reset       =>  reset,
        ce_o        =>  s_en
    );
    
    p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= std_logic_vector(c_ZERO);      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (unsigned(s_cnt) < c_DELAY_1SEC) then
                            s_cnt <= std_logic_vector(unsigned(s_cnt) + 1);
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= std_logic_vector(c_ZERO);
                        end if;

                    when WEST_GO =>
                        if (unsigned(s_cnt) < c_DELAY_4SEC) then
                            s_cnt <= std_logic_vector(unsigned(s_cnt) + 1);
                        else
                            s_state <= WEST_WAIT;
                            s_cnt   <= std_logic_vector(c_ZERO);
                        end if;
                        
                    when WEST_WAIT =>
                        if (unsigned(s_cnt) < c_DELAY_2SEC) then
                            s_cnt <= std_logic_vector(unsigned(s_cnt) + 1);
                        else
                            s_state <= STOP2;
                            s_cnt   <= std_logic_vector(c_ZERO);
                        end if;
                        
                    when STOP2 =>
                        if (unsigned(s_cnt) < c_DELAY_1SEC) then
                            s_cnt <= std_logic_vector(unsigned(s_cnt) + 1);
                        else
                            s_state <= SOUTH_GO;
                            s_cnt   <= std_logic_vector(c_ZERO);
                        end if;
                        
                    when SOUTH_GO =>
                        if (unsigned(s_cnt) < c_DELAY_4SEC) then
                            s_cnt <= std_logic_vector(unsigned(s_cnt) + 1);
                        else
                            s_state <= SOUTH_WAIT;
                            s_cnt   <= std_logic_vector(c_ZERO);
                        end if;
                        
                    when SOUTH_WAIT =>
                        if (unsigned(s_cnt) < c_DELAY_2SEC) then
                            s_cnt <= std_logic_vector(unsigned(s_cnt) + 1);
                        else
                            s_state <= STOP1;
                            s_cnt   <= std_logic_vector(c_ZERO);
                        end if;
                    
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;

    p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "100";   -- Red (RGB = 100)
                
            when WEST_GO =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "010";   -- Red (RGB = 010)
                
            when WEST_WAIT =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "110";   -- Red (RGB = 011)
            
            when STOP2 =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "100";   -- Red (RGB = 100)
                
            when SOUTH_GO =>
                south_o <= "010";   -- Red (RGB = 010)
                west_o  <= "100";   -- Red (RGB = 100)
                
            when SOUTH_WAIT =>
                south_o <= "110";   -- Red (RGB = 011)
                west_o  <= "100";   -- Red (RGB = 100)                

            when others =>
                south_o <= "100";   -- Red
                west_o  <= "100";   -- Red
        end case;
    end process p_output_fsm;

end Behavioral;
