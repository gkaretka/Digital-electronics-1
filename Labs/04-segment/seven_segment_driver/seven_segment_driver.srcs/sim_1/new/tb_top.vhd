----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2021 12:08:12 PM
-- Design Name: 
-- Module Name: tb_top - Behavioral
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

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
 -- Local signals
    signal  s_SW    :   std_logic_vector(4 - 1 downto 0);
    signal  s_LED   :   std_logic_vector(16 - 1 downto 0);
    
    signal  s_CA    :   std_logic;
    signal  s_CB    :   std_logic;
    signal  s_CC    :   std_logic;
    signal  s_CD    :   std_logic;
    signal  s_CE    :   std_logic;
    signal  s_CF    :   std_logic;
    signal  s_CG    :   std_logic;
        
    signal  s_AN    :   std_logic_vector(8 - 1 downto 0);
begin

    uut_top : entity work.top
    port map(
        SW  => s_SW,
        LED => s_LED,
        CA  => s_CA,
        CB  => s_CB,
        CC  => s_CC,
        CD  => s_CD,
        CE  => s_CE,
        CF  => s_CF,
        CG  => s_CG,
        
        AN  => S_AN
    );

    -- Turn LED(4) on if input value is equal to 0, ie "0000"
    -- Turn LED(5) on if input value is greater than 9
    -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8

     p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started. ---------------------------------------" severity note;
        
        -- TEST 0
        report "Testing 0 ..." severity note;
        s_SW <= "0000";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0001")
        report "Test failed for input combination: 0" severity error;
        
        -- TEST 1
        report "Testing 1 ..." severity note;
        s_SW <= "0001";
        wait for 10 ns;
        assert (LED(7 downto 4) = "1100")
        report "Test failed for input combination: 1" severity error; 
        
        -- TEST 2
        report "Testing 2 ..." severity note;
        s_SW <= "0010";
        wait for 10 ns;
        assert (LED(7 downto 4) = "1000")
        report "Test failed for input combination: 2" severity error; 
        
        -- TEST 3
        report "Testing 3 ..." severity note;
        s_SW <= "0011";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0100")
        report "Test failed for input combination: 3" severity error; 
        
        -- TEST 4
        report "Testing 4 ..." severity note;
        s_SW <= "0100";
        wait for 10 ns;
        assert (LED(7 downto 4) = "1000")
        report "Test failed for input combination: 4" severity error; 
        
        -- TEST 5
        report "Testing 5 ..." severity note;
        s_SW <= "0101";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0100")
        report "Test failed for input combination: 5" severity error; 
        
        -- TEST 6
        report "Testing 6 ..." severity note;
        s_SW <= "0110";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0000")
        report "Test failed for input combination: 6" severity error; 
        
        -- TEST 7
        report "Testing 7 ..." severity note;
        s_SW <= "0111";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0100")
        report "Test failed for input combination: 7" severity error; 
        
        -- TEST 8
        report "Testing 8 ..." severity note;
        s_SW <= "1000";
        wait for 10 ns;
        assert (LED(7 downto 4) = "1000")
        report "Test failed for input combination: 8" severity error; 
        
        -- TEST 9
        report "Testing 9 ..." severity note;
        s_SW <= "1001";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0100")
        report "Test failed for input combination: 9" severity error; 
        
        -- TEST 10 (A)
        report "Testing 10 ..." severity note;
        s_SW <= "1010";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0010")
        report "Test failed for input combination: 10" severity error; 
        
        -- TEST 11 (B)
        report "Testing 11 ..." severity note;
        s_SW <= "1011";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0110")
        report "Test failed for input combination: 11" severity error; 
        
        -- TEST 12 (C)
        report "Testing 12 ..." severity note;
        s_SW <= "1100";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0010")
        report "Test failed for input combination: 12" severity error; 
        
        -- TEST 13 (D)
        report "Testing 13 ..." severity note;
        s_SW <= "1101";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0110")
        report "Test failed for input combination: 13" severity error; 
        
        -- TEST 14 (E)
        report "Testing 14 ..." severity note;
        s_SW <= "1110";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0010")
        report "Test failed for input combination: 14" severity error;
        
        -- TEST 15 (F)
        report "Testing 15 ..." severity note;
        s_SW <= "1111";
        wait for 10 ns;
        assert (LED(7 downto 4) = "0110")
        report "Test failed for input combination: 15" severity error;           
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished. ---------------------------------------" severity note;
        wait;       
    end process p_stimulus;
end Behavioral;
