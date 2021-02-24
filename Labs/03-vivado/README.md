# Digital-electronics-1

## My GitHub repository

[Digital-electronics-1](https://github.com/gkaretka/Digital-electronics-1)

## Lab assignment 3)

### Preparation tasks (using my Nexys 4 DDR):

![Schematic of used HW](/img/schematic.PNG)

```vhdl
## Switches
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { a_i[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { a_i[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]

set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { b_i[0] }]; #IO_L6N_T0_D08_VREF_14 Sch=sw[2]
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { b_i[1] }]; #IO_L13N_T2_MRCC_14 Sch=sw[3]

set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { c_i[0] }]; #IO_L12N_T1_MRCC_14 Sch=sw[4]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { c_i[1] }]; #IO_L7N_T1_D10_14 Sch=sw[5]

set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { d_i[0] }]; #IO_L17N_T2_A13_D29_14 Sch=sw[6]
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { d_i[1] }]; #IO_L5N_T0_D07_14 Sch=sw[7]

set_property -dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS18 } [get_ports { s_i[0] }]; #IO_L24N_T3_34 Sch=sw[8]
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS18 } [get_ports { s_i[1] }]; #IO_25_34 Sch=sw[9]

## LEDs
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { f_o[0] }]; #IO_L18P_T2_A24_15 Sch=led[0]
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { f_o[1] }]; #IO_L24P_T3_RS1_15 Sch=led[1]
```

### 2bit wide 4-to-1 mux

``` vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2bit_4to1 is
    Port (
        a_i     :   in std_logic_vector(2 - 1 downto 0);
        b_i     :   in std_logic_vector(2 - 1 downto 0);
        c_i     :   in std_logic_vector(2 - 1 downto 0);
        d_i     :   in std_logic_vector(2 - 1 downto 0);
        
        s_i     :   in std_logic_vector(2 - 1 downto 0);
        
        f_o     :   out std_logic_vector(2 - 1 downto 0)
    );
end mux_2bit_4to1;

architecture Behavioral of mux_2bit_4to1 is
begin
    f_o <=  a_i when (s_i = "00") else
            b_i when (s_i = "01") else
            c_i when (s_i = "10") else
            d_i;
end Behavioral;
```

### 2bit wide 4-to-1 mux testbench

```vhdl
library ieee;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.numeric_std.all;

use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_mux_2bit_4to1 is
    -- Entity of testbench is always empty
end entity tb_mux_2bit_4to1;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_mux_2bit_4to1 is

    -- Local signals
    signal s_a           : std_logic_vector(2 - 1 downto 0);
    signal s_b           : std_logic_vector(2 - 1 downto 0);
    signal s_c           : std_logic_vector(2 - 1 downto 0);
    signal s_d           : std_logic_vector(2 - 1 downto 0);
    
    signal s_si          : std_logic_vector(2 - 1 downto 0);
    
    signal s_f_out       : std_logic_vector(2 - 1 downto 0);
    
begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    uut_comparator_2bit : entity work.mux_2bit_4to1
        port map(
            a_i     => s_a,
            b_i     => s_b,
            c_i     => s_c,
            d_i     => s_d,      
            
            s_i     => s_si,
            f_o     => s_f_out
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started. ---------------------------------------" severity note;
        s_a     <= "11";
        s_b     <= "10";
        s_c     <= "01";
        s_d     <= "00";
        
        s_si    <= "00";
        wait for 100 ns;
        assert (s_f_out = s_a)
        report "Test failed for input combination: 00" severity error;        
    	wait for 100 ns;

        s_si    <= "01";
        wait for 100 ns;
        assert (s_f_out = s_b)
        report "Test failed for input combination: 01" severity error;        
    	wait for 100 ns;

        s_si    <= "10";
        wait for 100 ns;
        assert (s_f_out = s_c)
        report "Test failed for input combination: 10" severity error;        
    	wait for 100 ns;

        s_si    <= "11";
        wait for 100 ns;
        assert (s_f_out = s_d)
        report "Test failed for input combination: 11" severity error;        
    	wait for 100 ns;
    	
    	-- test for another inputs
    	
    	s_a     <= "01";
        s_b     <= "11";
        s_c     <= "00";
        s_d     <= "10";
        
        s_si    <= "00";
        wait for 100 ns;
        assert (s_f_out = s_a)
        report "Test failed for input combination: 00" severity error;        
    	wait for 100 ns;

        s_si    <= "01";
        wait for 100 ns;
        assert (s_f_out = s_b)
        report "Test failed for input combination: 01" severity error;        
    	wait for 100 ns;

        s_si    <= "10";
        wait for 100 ns;
        assert (s_f_out = s_c)
        report "Test failed for input combination: 10" severity error;        
    	wait for 100 ns;

        s_si    <= "11";
        wait for 100 ns;
        assert (s_f_out = s_d)
        report "Test failed for input combination: 11" severity error;        
    	wait for 100 ns;
    	
        -- Report a note at the end of stimulus process
        report "Stimulus process finished. ---------------------------------------" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```

![Waveform of simulation](/img/schematic.PNG)

[<iframe width="560" height="315" src="https://www.youtube.com/embed/QcRgVIGiRpU" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>](https://youtu.be/QcRgVIGiRpU)

```bash
Note: Stimulus process started. ---------------------------------------
Time: 0 ps  Iteration: 0  Process: /tb_mux_2bit_4to1/p_stimulus  File: tb_mux_2bit_4to1.vhd
INFO: [USF-XSim-96] XSim completed. Design snapshot 'tb_mux_2bit_4to1_behav' loaded.
INFO: [USF-XSim-97] XSim simulation ran for 1000ns
launch_simulation: Time (s): cpu = 00:00:04 ; elapsed = 00:00:15 . Memory (MB): peak = 2536.414 ; gain = 17.039
run 150 us
Note: Stimulus process finished. ---------------------------------------
```

A Vivado tutorial. Submit:

Your tutorial for Vivado design flow: project creation, adding source file, adding testbench file, adding XDC constraints file, running simulation.