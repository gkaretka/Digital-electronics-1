# Digital-electronics-1

## Lab assignment 2)

### Truth table

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

### design.vhd

```vhdl
library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations

------------------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------------------
entity gates is
    port(
        a_i    : in  std_logic;     -- Data input
        b_i    : in  std_logic;    	-- Data input
        c_i	   : in  std_logic;		-- Data input
        
        f1_o   : out std_logic;
        fand_o : out std_logic;
        for_o  : out std_logic
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
    f1_o 		<= ((not b_i) and a_i) or ((not c_i) and (not b_i)); 					-- original
    for_o		<= (not (b_i or (not a_i))) or (not (c_i or b_i));	 					-- or only
    fand_o		<= not ((not ((not b_i) and a_i)) and not ((not c_i) and (not b_i))); 	-- and only
end architecture dataflow;

```

### Waveform
IN:
s_a, s_b, s_c

OUT:
f1_o    -- is the original function given using and/or/not.
for_o   -- is function using only or/not
fand_o  -- is function using only and/not

![waveform](Labs/01-tools/cap1.PNG)

[link to EDA Playground](https://www.edaplayground.com/x/v9TN)

## Lab assignment 3)