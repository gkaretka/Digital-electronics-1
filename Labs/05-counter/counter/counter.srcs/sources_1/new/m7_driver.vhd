----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2021 03:21:51 PM
-- Design Name: 
-- Module Name: m7_driver - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity m7_driver is
    Generic (
        g_MAX   : natural := 100000 -- update each segment every 1ms
    );

    Port (
        CLK100MHZ   :   in std_logic;     
        num_in      :   in std_logic_vector(32 - 1 downto 0);
        s_mask      :   in std_logic_vector(8 - 1 downto 0);
        
        reset       :   in std_logic;
        
        t_seg_o     :   out std_logic_vector(7 - 1 downto 0);
        AN          :   out std_logic_vector(8 - 1 downto 0)
    );
end m7_driver;

architecture Behavioral of m7_driver is

    signal  switch_segment      :   std_logic;
    signal  local_disply_num    :   std_logic_vector(4-1 downto 0);
    signal  local_cnt           :   natural;

begin
    --------------------------------------------------------------------    
    -- segment switching signal
    clk_en_16b : entity work.clock_enable
        generic map(
            g_MAX   =>  g_MAX
        )
        
        port map(
            clk     =>  CLK100MHZ,
            reset   =>  reset,    -- no reset needed
            ce_o    =>  switch_segment
        );
    
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => local_disply_num,
            seg_o(6) => t_seg_o(6),
            seg_o(5) => t_seg_o(5),
            seg_o(4) => t_seg_o(4),
            seg_o(3) => t_seg_o(3),
            seg_o(2) => t_seg_o(2),
            seg_o(1) => t_seg_o(1),
            seg_o(0) => t_seg_o(0)
        );
        
    segment_switcher : process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            if (reset = '1') then
                local_cnt   <= 0;
            elsif (switch_segment = '1') then                
                AN(local_cnt-1)     <= '1';         -- reset previous segment
                if (s_mask(local_cnt) = '1') then   -- check mask
                    AN(local_cnt)       <= '0';     -- activate current segment
                end if;
                
                -- calculate segment numbers
                local_disply_num    <= num_in((local_cnt*4)+3 downto (local_cnt*4));
                
                -- if last segment go to beginning
                if (local_cnt < 8) then
                    local_cnt           <= local_cnt + 1;
                else
                    local_cnt           <= 0;
                end if;
            end if;
        end if;
    end process segment_switcher;

end Behavioral;
