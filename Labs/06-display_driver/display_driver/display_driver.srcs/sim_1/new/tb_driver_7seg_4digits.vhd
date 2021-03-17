----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2021 10:49:01 AM
-- Design Name: 
-- Module Name: tb_driver_7seg_4digits - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_driver_7seg_4digits is
--  Port ( );
end tb_driver_7seg_4digits;

architecture Behavioral of tb_driver_7seg_4digits is

    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    signal s_clk : std_logic;
    signal s_reset : std_logic;
    
    signal s_data0 : std_logic_vector(4-1 downto 0);
    signal s_data1 : std_logic_vector(4-1 downto 0);
    signal s_data2 : std_logic_vector(4-1 downto 0);
    signal s_data3 : std_logic_vector(4-1 downto 0);

    signal s_dp_i : std_logic_vector(4-1 downto 0);
    signal s_dp_o : std_logic;
    
    signal s_seg_o : std_logic_vector(7-1 downto 0);
    
    signal s_dig_o : std_logic_vector(4-1 downto 0);
begin

    uut_driver_7seg_4digits : entity work.driver_7seg_4digits
    port map(
        clk     => s_clk,
        reset   => s_reset,
        
        -- 4-bit input values for individual digits
        data0_i => s_data0,
        data1_i => s_data1,
        data2_i => s_data2,
        data3_i => s_data3,
        -- 4-bit input value for decimal points
        dp_i    => s_dp_i,
        -- Decimal point for specific digit
        dp_o    => s_dp_o,
        -- Cathode values for individual segments
        seg_o   => s_seg_o,
        -- Common anode signals to individual displays
        dig_o   => s_dig_o
    );
    
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 16 ms loop         -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 12 ns;
        s_reset <= '1';                 -- Reset activated
        wait for 73 ns;
        s_reset <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus: process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started. ---------------------------------------" severity note;
        
        -- dispaly number 3.142
        s_data3 <= "0011"; -- store 3 to 4
        s_data2 <= "0001"; -- store 1 to 3
        s_data1 <= "0100"; -- store 4 to 2
        s_data0 <= "0010"; -- store 2 to 1
        
        s_dp_i  <= "0111"; -- decimal point only for the first one
        
        
        wait for 500 us; -- wait for transitions to go away                
        -- assert segment digit = 2
        assert(s_seg_o = "0010010")
        report "First segment wrong digit." severity note;
        
        wait for 4 ms;   
        -- assert segment digit = 4
        assert(s_seg_o = "1001100")
        report "Second segment wrong digit." severity note;
        
        wait for 4 ms;   
        -- assert segment digit = 1
        assert(s_seg_o = "1001111")
        report "Third segment wrong digit." severity note;
        
        wait for 4 ms;   
        -- assert decimal point
        assert(s_dp_o = '0')
        report "Decimal point on wrong digit." severity note;
        -- assert segment digit = 3
        assert(s_seg_o = "0000110")
        report "Last segment wrong digit." severity note;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished. ---------------------------------------" severity note;
        wait;
    end process p_stimulus;


end Behavioral;
