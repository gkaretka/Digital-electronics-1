# Digital-electronics-1

## My GitHub repository

[Digital-electronics-1](https://github.com/gkaretka/Digital-electronics-1)

## Lab assignment 3)

### Preparation tasks (using my Nexys 4 DDR):

Decoder truth table for common anode 7-segment display.

| **Hex** | **Inputs** | **A** | **B** | **C** | **D** | **E** | **F** | **G** |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 0011 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |
| 4 | 0100 | 1 | 0 | 0 | 1 | 1 | 0 | 0 | 
| 5 | 0101 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
| 8 | 1000 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 9 | 1001 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| A | 1010 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| b | 1011 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| C | 1100 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |
| d | 1101 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |

![Schematic of used HW](img/schematic.PNG)

### Seven-segment display decoder

#### Arcitecture code (hex_7seg.vhd)

```vhdl
architecture Behavioral of hex_7seg is
begin

    p_7seg_decoder : process(hex_i)
    begin
        case hex_i is
            when "0000" =>
                seg_o <= "0000001";     -- 0
            when "0001" =>
                seg_o <= "1001111";     -- 1
            when "0010" =>
                seg_o <= "0010010";     -- 2
            when "0011" =>
                seg_o <= "0000110";     -- 3
            when "0100" =>
                seg_o <= "1001100";     -- 4
            when "0101" =>
                seg_o <= "0100100";     -- 5
            when "0110" =>
                seg_o <= "0100000";     -- 6
            when "0111" =>
                seg_o <= "0001111";     -- 7
            when "1000" =>
                seg_o <= "0000000";     -- 8
            when "1001" =>
                seg_o <= "0000100";     -- 9
            when "1010" =>
                seg_o <= "0001000";     -- A (10)
            when "1011" =>
                seg_o <= "1100000";     -- B (11)
            when "1100" =>
                seg_o <= "0110001";     -- C (12)
            when "1101" =>
                seg_o <= "1000010";     -- D (13)
            when "1110" =>
                seg_o <= "0110000";     -- E (14)
            when others =>
                seg_o <= "0111000";     -- F (15)
        end case;
    end process p_7seg_decoder;

end Behavioral;
```

#### Testbench code (tb_hex_7seg.vhd)

```vhdl
p_stimulus : process
begin
    -- Report a note at the begining of stimulus process
    report "Stimulus process started. ---------------------------------------" severity note;
    
    -- TEST 0
    report "Testing 0 ..." severity note;
    s_hex_i <= "0000";
    wait for 10 ns;
    assert (s_seg_o = "0000001")
    report "Test failed for input combination: 0" severity error;
    
    -- TEST 1
    report "Testing 1 ..." severity note;
    s_hex_i <= "0001";
    wait for 10 ns;
    assert (s_seg_o = "1001111")
    report "Test failed for input combination: 1" severity error; 
    
    -- TEST 2
    report "Testing 2 ..." severity note;
    s_hex_i <= "0010";
    wait for 10 ns;
    assert (s_seg_o = "0010010")
    report "Test failed for input combination: 2" severity error; 
    
    -- TEST 3
    report "Testing 3 ..." severity note;
    s_hex_i <= "0011";
    wait for 10 ns;
    assert (s_seg_o = "0000110")
    report "Test failed for input combination: 3" severity error; 
    
    -- TEST 4
    report "Testing 4 ..." severity note;
    s_hex_i <= "0100";
    wait for 10 ns;
    assert (s_seg_o = "1001100")
    report "Test failed for input combination: 4" severity error; 
    
    -- TEST 5
    report "Testing 5 ..." severity note;
    s_hex_i <= "0101";
    wait for 10 ns;
    assert (s_seg_o = "0100100")
    report "Test failed for input combination: 5" severity error; 
    
    -- TEST 6
    report "Testing 6 ..." severity note;
    s_hex_i <= "0110";
    wait for 10 ns;
    assert (s_seg_o = "0100000")
    report "Test failed for input combination: 6" severity error; 
    
    -- TEST 7
    report "Testing 7 ..." severity note;
    s_hex_i <= "0111";
    wait for 10 ns;
    assert (s_seg_o = "0001111")
    report "Test failed for input combination: 7" severity error; 
    
    -- TEST 8
    report "Testing 8 ..." severity note;
    s_hex_i <= "1000";
    wait for 10 ns;
    assert (s_seg_o = "0000000")
    report "Test failed for input combination: 8" severity error; 
    
    -- TEST 9
    report "Testing 9 ..." severity note;
    s_hex_i <= "1001";
    wait for 10 ns;
    assert (s_seg_o = "0000100")
    report "Test failed for input combination: 9" severity error; 
    
    -- TEST 10 (A)
    report "Testing 10 ..." severity note;
    s_hex_i <= "1010";
    wait for 10 ns;
    assert (s_seg_o = "0001000")
    report "Test failed for input combination: 10" severity error; 
    
    -- TEST 11 (B)
    report "Testing 11 ..." severity note;
    s_hex_i <= "1011";
    wait for 10 ns;
    assert (s_seg_o = "1100000")
    report "Test failed for input combination: 11" severity error; 
    
    -- TEST 12 (C)
    report "Testing 12 ..." severity note;
    s_hex_i <= "1100";
    wait for 10 ns;
    assert (s_seg_o = "0110001")
    report "Test failed for input combination: 12" severity error; 
    
    -- TEST 13 (D)
    report "Testing 13 ..." severity note;
    s_hex_i <= "1101";
    wait for 10 ns;
    assert (s_seg_o = "1000010")
    report "Test failed for input combination: 13" severity error; 
    
    -- TEST 14 (E)
    report "Testing 14 ..." severity note;
    s_hex_i <= "1110";
    wait for 10 ns;
    assert (s_seg_o = "0110000")
    report "Test failed for input combination: 14" severity error;
    
    -- TEST 15 (F)
    report "Testing 15 ..." severity note;
    s_hex_i <= "1111";
    wait for 10 ns;
    assert (s_seg_o = "0111000")
    report "Test failed for input combination: 15" severity error;      
    
    -- Report a note at the end of stimulus process
    report "Stimulus process finished. ---------------------------------------" severity note;
    wait;       
end process p_stimulus;
```

#### Simulated waveform 

![Waveform of simulation](img/wf.PNG)

### Top (top.vhd)

```vhdl
    ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2021 09:54:21 AM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port (
        SW  :   in  std_logic_vector(4 - 1 downto 0);
        LED :   out std_logic_vector(16 - 1 downto 0);
        
        CA  :   out std_logic;
        CB  :   out std_logic;
        CC  :   out std_logic;
        CD  :   out std_logic;
        CE  :   out std_logic;
        CF  :   out std_logic;
        CG  :   out std_logic;
        
        AN  :   out std_logic_vector(8 - 1 downto 0)
    );
end top;

architecture Behavioral of top is
    signal  s_seg_o :   std_logic_vector(7 - 1 downto 0);  
begin
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i       => SW,
            seg_o       => s_seg_o
        );

    -- Connect one common anode to 3.3V
    AN  <= b"1111_1110";
    
    CA  <= s_seg_o(6);
    CB  <= s_seg_o(5);
    CC  <= s_seg_o(4);
    CD  <= s_seg_o(3);
    CE  <= s_seg_o(2);
    CF  <= s_seg_o(1);
    CG  <= s_seg_o(0);
    
    LED(15 downto 9)    <= not s_seg_o;

    -- Display input value LED
    LED(3 downto 0)     <= SW;
    
    -- Turn LED(4) on if input value is equal to 0, ie "0000"
    LED(4)              <= '1' when (SW = "0000") else '0';
    
    -- Turn LED(5) on if input value is greater than 9
    LED(5)              <= '1' when (unsigned(SW) > 9) else '0';
    
    -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    LED(6)              <= '1' when (unsigned(SW) mod 2 = 1) else '0';
    
    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
    LED(7)              <= '1' when (SW = "0001" or SW = "0010" or SW = "0100" or SW = "1000") else '0';
    
end Behavioral;

```