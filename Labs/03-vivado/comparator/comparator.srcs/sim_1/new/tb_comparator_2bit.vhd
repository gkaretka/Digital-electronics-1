library ieee;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.numeric_std.all;

use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_comparator_2bit is
    -- Entity of testbench is always empty
end entity tb_comparator_2bit;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_comparator_2bit is

    -- Local signals
    signal s_a           : std_logic_vector(2 - 1 downto 0);
    signal s_b           : std_logic_vector(2 - 1 downto 0);
    signal s_B_greater_A : std_logic;
    signal s_B_equals_A  : std_logic;
    signal s_B_less_A    : std_logic;

begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    uut_comparator_2bit : entity work.comparator_2bit
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
    variable range_of_rand : real := 3.0;
    begin
    	
        -- change for different values
        seed1 := 48684213;
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
