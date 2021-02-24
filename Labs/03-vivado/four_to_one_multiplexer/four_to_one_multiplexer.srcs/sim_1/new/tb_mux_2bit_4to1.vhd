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
