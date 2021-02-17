# Digital-electronics-1

## Lab 2: Combinational logic

## Preparation tasks (done before the lab at home)

*Digital* or *Binary comparator* compares the digital signals A, B presented at input terminal and produce outputs depending upon the condition of those inputs. Complete the truth table for 2-bit *Identity comparator* (B equals A), and two *Magnitude comparators* (B is greater than A, B is less than A). Note that, such a digital device has four inputs and three outputs/functions.

| **Dec. equivalent** | **B[1:0]** | **A[1:0]** | **B is greater than A** | **B equals A** | **B is less than A** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 0 | 0 0 | 0 | 1 | 0 |
| 1 | 0 0 | 0 1 | 0 | 0 | 1 |
| 2 | 0 0 | 1 0 | 0 | 0 | 1 |
| 3 | 0 0 | 1 1 | 0 | 0 | 1 |
| 4 | 0 1 | 0 0 | 1 | 0 | 0 |
| 5 | 0 1 | 0 1 | 0 | 1 | 0 |
| 6 | 0 1 | 1 0 | 0 | 0 | 1 |
| 7 | 0 1 | 1 1 | 0 | 0 | 1 |
| 8 | 1 0 | 0 0 | 1 | 0 | 0 |
| 9 | 1 0 | 0 1 | 1 | 0 | 0 |
| 10 | 1 0 | 1 0 | 0 | 1 | 0 |
| 11 | 1 0 | 1 1 | 0 | 0 | 1 |
| 12 | 1 1 | 0 0 | 1 | 0 | 0 |
| 13 | 1 1 | 0 1 | 1 | 0 | 0 |
| 14 | 1 1 | 1 0 | 1 | 0 | 0 |
| 15 | 1 1 | 1 1 | 0 | 1 | 0 |

```verilog
eq_sop = (~b1 * ~b0 * ~a1 * ~a0) + (b1 * ~b0 * a1 * ~a0) + (~b1 * b0 * ~a1 * ~a0) + (b1 * b0 * a1 * a0);

blta_pos = (b1 + b0 + a1 + a0) * (b1 + ~b0 + a1 + a0) * (b1 + ~b0 + a1 + ~a0) * (~b1 + b0 + a1 + a0) * (~b1 + b0 + a1 + ~a0) * 
            (~b1 + b0 + ~a1 + a0) * (~b1 + ~b0 + a1 + a0) * (~b1 + ~b0 + a1 + ~a0) * (~b1 + ~b0 + ~a1 + a0) * (~b1 + ~b0 + ~a1 + ~a0);

bgta_pos = (b1 + b0 + a1 + a0) * (b1 + b0 + a1 + ~a0) * (b1 + ~b0 + ~a1 + a0) * (b1 + b0 + ~a1 + ~a0) * (b1 + ~b0 + a1 + ~a0) * 
            (b1 + ~b0 + a1 + ~a0) * (b1 + ~b0 + ~a1 + ~a0) * (~b1 + b0 + ~a1 + a0) * (~b1 + b0 + ~a1 + ~a0) * (~b1 + ~b0 + ~a1 + ~a0);
```

## K-maps

### indexes

| x  | 00 | 01 | 11 | 10 |
| :-: | :-: | :-: | :-: | :-: |
| 00 | 0  | 1  | 3  | 2 |
| 01 | 4  | 5  | 7  | 6 |
| 11 | 12  | 13  | 15  | 14 |
| 10 | 8  | 9  | 11  | 10 |

### B == A

| x  | 00 | 01 | 11 | 10 |
| :-: | :-: | :-: | :-: | :-: |
| 00 | 1 |   |   |   |
| 01 |   | 1 |   |   |
| 11 |   |   | 1 |   |
| 10 |   |   |   | 1 |

### B > A

| x  | 00 | 01 | 11 | 10 |
| :-: | :-: | :-: | :-: | :-: |
| 00 |   |   |   |   |
| 01 | 1 |   |   |   |
| 11 | 1 | 1 |   | 1 |
| 10 | 1 | 1 |   |   |

- first group is 12, 13, 8, 9: B1 * ~A1

- second group is 14, 12: B1 * B0 * ~A0

- third group is 12, 4: B0 * ~A0 * ~A1

```verilog
eq = (B1 * ~A1) + (B1 * B0 * ~A0) + (B0 * ~A0 * ~A1)
```

### A > B

| x  | 00 | 01 | 11 | 10 |
| :-: | :-: | :-: | :-: | :-: |
| 00 | 0 |   |   |   |
| 01 | 0 | 0 |   |   |
| 11 | 0 | 0 | 0 | 0 |
| 10 | 0 | 0 |   | 0 |

- first group is 12, 13, 8, 9: ~B1 + A1

- second group is 4, 5, 12, 13: ~B0 + A1

- third group is 0, 4, 8, 12: A0 + A1

- fourth group is 12, 13, 14, 15: ~B1 + ~B0

- fifth ground is 8, 12, 10, 14: ~B1 + A0

```verilog
eq = (~B1 + A1) * (~B0 + A1) * (A0 + A1) * (~B1 + ~B0) * (~B1 + A0)
```

## 4-bit comparator code

```vhdl
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for 4-bit binary comparator
------------------------------------------------------------------------
entity comparator_4bit is
    port(
        a_i           : in  std_logic_vector(4 - 1 downto 0);
        b_i           : in  std_logic_vector(4 - 1 downto 0);
        
        B_greater_A_o  : out std_logic;     -- A is less than B
        B_equals_A_o  : out std_logic;      -- B equals A
        B_less_A_o    : out std_logic       -- B is less than A
    );
end entity comparator_4bit;

------------------------------------------------------------------------
-- Architecture body for 4-bit binary comparator
------------------------------------------------------------------------
architecture Behavioral of comparator_4bit is
begin
    B_less_A_o   <= '1' when (b_i < a_i) else '0';
	B_equals_A_o <= '1' when (b_i = a_i) else '0';
    B_greater_A_o <= '1' when (b_i > a_i) else '0';
end architecture Behavioral;
```

## 4-bit comparator test bench code

```vhdl
library ieee;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.numeric_std.all;

use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_comparator_4bit is
    -- Entity of testbench is always empty
end entity tb_comparator_4bit;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_comparator_4bit is

    -- Local signals
    signal s_a           : std_logic_vector(4 - 1 downto 0);
    signal s_b           : std_logic_vector(4 - 1 downto 0);
    signal s_B_greater_A : std_logic;
    signal s_B_equals_A  : std_logic;
    signal s_B_less_A    : std_logic;

begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    uut_comparator_4bit : entity work.comparator_4bit
        port map(
            a_i           => s_a,
            b_i           => s_b,
            B_greater_A_o => s_B_greater_A,
            B_equals_A_o  => s_B_equals_A,
            B_less_A_o    => s_B_less_A
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    variable seed1, seed2: positive;
    variable rand1, rand2: real;
    variable range_of_rand : real := 15.0;
    begin
    	
        seed1 := 24156461;
        seed2 := 45646546;
        
        -- Report a note at the begining of stimulus process
        report "Stimulus process started. Check 0..9 random numbers. Fail on purpose on 10th." severity note;
        
        for I in 0 to 10 loop -- generate 10 random changes and 11th fails
            uniform(seed1, seed2, rand1);
            uniform(seed1, seed2, rand2);
            s_a <= std_logic_vector(to_unsigned(integer(rand1*range_of_rand), s_a'length));
            s_b <= std_logic_vector(to_unsigned(integer(rand2*range_of_rand), s_b'length));
    	    wait for 100 ns;
            
            report "Run cnt: " & integer'image(I) & ", checking a: " 
            & integer'image(to_integer(unsigned(s_a))) & ", b: " 
            & integer'image(to_integer(unsigned(s_b))) severity note;
            
            if (I = 10) then -- fail on purpose
                if (s_a = s_b) then
                    assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
                    report "Test failed for input combination:"
                    & integer'image(to_integer(unsigned(s_a))) & ", " 
                    & integer'image(to_integer(unsigned(s_b))) & " " severity error;
                 elsif (s_a > s_b) then
                    assert ((s_B_greater_A = '1') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
                    report "Test failed for input combination:"
                    & integer'image(to_integer(unsigned(s_a))) & ", " 
                    & integer'image(to_integer(unsigned(s_b))) & " " severity error;
                 elsif (s_b > s_a) then
                    assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '1'))
                    report "Test failed for input combination:"
                    & integer'image(to_integer(unsigned(s_a))) & ", " 
                    & integer'image(to_integer(unsigned(s_b))) & " " severity error;
                 end if;
            elsif (s_a = s_b) then -- check for generated s_a == s_b
                assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
                report "Test failed for input combination:"
                & integer'image(to_integer(unsigned(s_a))) & ", " 
                & integer'image(to_integer(unsigned(s_b))) & " " severity error;
            elsif (s_b > s_a) then -- check for generated s_b > s_a
                assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
                report "Test failed for input combination:" 
                & integer'image(to_integer(unsigned(s_a))) & ", " 
                & integer'image(to_integer(unsigned(s_b))) & " " severity error;
            elsif (s_a > s_b) then -- check for generated s_a > s_b
                assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
                report "Test failed for input combination:" 
                & integer'image(to_integer(unsigned(s_a))) & ", " 
                & integer'image(to_integer(unsigned(s_b))) & " " severity error;
            end if;
        end loop;        
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```

## Test bench output

```bash
[2021-02-17 09:32:09 EST] ghdl -i design.vhd testbench.vhd  && ghdl -m  tb_comparator_4bit && ghdl -r  tb_comparator_4bit   --vcd=dump.vcd && sed -i 's/^U/X/g; s/^-/X/g; s/^H/1/g; s/^L/0/g' dump.vcd 
analyze design.vhd
analyze testbench.vhd
elaborate tb_comparator_4bit
testbench.vhd:51:9:@0ms:(report note): Stimulus process started. Check 0..9 random numbers. Fail on purpose on 10th.
testbench.vhd:60:13:@100ns:(report note): Run cnt: 0, checking a: 2, b: 0
testbench.vhd:60:13:@200ns:(report note): Run cnt: 1, checking a: 7, b: 14
testbench.vhd:60:13:@300ns:(report note): Run cnt: 2, checking a: 7, b: 8
testbench.vhd:60:13:@400ns:(report note): Run cnt: 3, checking a: 3, b: 8
testbench.vhd:60:13:@500ns:(report note): Run cnt: 4, checking a: 10, b: 15
testbench.vhd:60:13:@600ns:(report note): Run cnt: 5, checking a: 2, b: 4
testbench.vhd:60:13:@700ns:(report note): Run cnt: 6, checking a: 6, b: 12
testbench.vhd:60:13:@800ns:(report note): Run cnt: 7, checking a: 5, b: 11
testbench.vhd:60:13:@900ns:(report note): Run cnt: 8, checking a: 8, b: 12
testbench.vhd:60:13:@1us:(report note): Run cnt: 9, checking a: 8, b: 8
testbench.vhd:60:13:@1100ns:(report note): Run cnt: 10, checking a: 14, b: 6
testbench.vhd:71:21:@1100ns:(assertion error): Test failed for input combination:14, 6 
testbench.vhd:100:9:@1100ns:(report note): Stimulus process finished
Finding VCD file...
./dump.vcd
[2021-02-17 09:32:10 EST] Opening EPWave...
Done
```

[EDA playground](https://www.edaplayground.com/x/RD2x)
