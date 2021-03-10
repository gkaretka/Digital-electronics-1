----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2021 11:18:46 AM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    generic(
        g_CNT_WIDTH :   natural := 4;         -- Number of bits for counter
        g_MAX       :   natural := 50000000;  -- Number of clk pulses to generate
        
        g_16B_WIDTH :   natural := 16;        -- Number of bits for 16bit counter
        g_16B_MAX   :   natural := 1000000    -- Number of clk pulses for enable
    );

    Port (
        CLK100MHZ   :   in    std_logic;
        BTNC        :   in    std_logic;
        BTNU        :   in    std_logic;
        BTND        :   in    std_logic;
        
        SW          :   in    std_logic_vector(2 - 1 downto 0);
        LED         :   out   std_logic_vector(16 - 1 downto 0);
        
        CA          :   out std_logic;
        CB          :   out std_logic;
        CC          :   out std_logic;
        CD          :   out std_logic;
        CE          :   out std_logic;
        CF          :   out std_logic;
        CG          :   out std_logic;
        
        AN          :   out std_logic_vector(8 - 1 downto 0)	 
    );
end top;

architecture Behavioral of top is

    -- Internal clock enable
    signal s_en_4b      : std_logic;
    -- Internal counter
    signal s_cnt_4b     : std_logic_vector(4 - 1 downto 0);
    
    signal s_cnt_16b    : std_logic_vector(16 - 1 downto 0);
    signal s_en_16b     : std_logic;
begin

    --------------------------------------------------------------------
    -- 4 bit counter instance
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX   =>  g_MAX
        )
        
        port map(
            clk     =>  CLK100MHZ,
            reset   =>  BTNU,
            ce_o    =>  s_en_4b
        );
        
    --------------------------------------------------------------------
    -- 4 bit counters clk divider
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH =>  g_CNT_WIDTH
        )
        port map(
            clk         =>  CLK100MHZ,
            reset       =>  BTNU,
            en_i        =>  s_en_4b,
            cnt_up_i    =>  SW(0),
            cnt_o       =>  s_cnt_4b
        );
        
    --------------------------------------------------------------------    
    -- 16 bit counter
    clk_en_16b : entity work.clock_enable
        generic map(
            g_MAX   =>  g_16B_MAX
        )
        
        port map(
            clk     =>  CLK100MHZ,
            reset   =>  BTND,
            ce_o    =>  s_en_16b
        );
        
    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt_16b : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH =>  g_16B_WIDTH
        )
        port map(
            clk         =>  CLK100MHZ,
            reset       =>  BTND,
            en_i        =>  s_en_16b,
            cnt_up_i    =>  SW(1),
            cnt_o       =>  s_cnt_16b
        );

    -- Display input value on LEDs
    LED(15 downto 0) <= s_cnt_16b;

    --------------------------------------------------------------------
    -- Instance m7_driver entity
    -- Drives all 7 segment displays on Nexys 4 DDR
    -- refresing period = 8*1ms = 8ms
    -- input as 32 bits of number       -- num_in
    -- with mask for unused segments    -- s_maks
    m7_driver : entity work.m7_driver
        port map(
            CLK100MHZ   =>  CLK100MHZ,
            reset       =>  BTNC,
            
            num_in(4-1 downto 0)    => s_cnt_4b,
            num_in(16-1 downto 4)   => b"0000_0000_0000",
            num_in(32-1 downto 16)  => s_cnt_16b,
            
            s_mask      => b"1111_0001",
            
            AN          => AN,
            
            t_seg_o(6)  => CA,
            t_seg_o(5)  => CB,
            t_seg_o(4)  => CC,
            t_seg_o(3)  => CD,
            t_seg_o(2)  => CE,
            t_seg_o(1)  => CF,
            t_seg_o(0)  => CG
        );

end architecture Behavioral;
