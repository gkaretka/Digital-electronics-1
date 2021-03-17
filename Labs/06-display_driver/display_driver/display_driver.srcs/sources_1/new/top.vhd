----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2021 11:11:38 AM
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
    Port (
        CLK100MHZ   :   in    std_logic;
        BTNC        :   in    std_logic;
        
        SW          :   in    std_logic_vector(16 - 1 downto 0);
        
        CA          :   out std_logic;
        CB          :   out std_logic;
        CC          :   out std_logic;
        CD          :   out std_logic;
        CE          :   out std_logic;
        CF          :   out std_logic;
        CG          :   out std_logic;
        
        DP          :   out std_logic;
        
        AN          :   out std_logic_vector(8 - 1 downto 0)	
    );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is
begin
    --------------------------------------------------------------------
    -- Instance (copy) of driver_7seg_4digits entity
    driver_seg_4 : entity work.driver_7seg_4digits
        port map(
            clk         => CLK100MHZ,
            reset       => BTNC,
            
            data0_i(3)  => SW(3),
            data0_i(2)  => SW(2),
            data0_i(1)  => SW(1),
            data0_i(0)  => SW(0),
            
            data1_i(3)  => SW(7),
            data1_i(2)  => SW(6),
            data1_i(1)  => SW(5),
            data1_i(0)  => SW(4),
            
            data2_i(3)  => SW(11),
            data2_i(2)  => SW(10),
            data2_i(1)  => SW(9),
            data2_i(0)  => SW(8),
            
            data3_i(3)  => SW(15),
            data3_i(2)  => SW(14),
            data3_i(1)  => SW(13),
            data3_i(0)  => SW(12),
            
            data4_i(3)  => SW(3),
            data4_i(2)  => SW(2),
            data4_i(1)  => SW(1),
            data4_i(0)  => SW(0),
            
            data5_i(3)  => SW(7),
            data5_i(2)  => SW(6),
            data5_i(1)  => SW(5),
            data5_i(0)  => SW(4),
            
            data6_i(3)  => SW(11),
            data6_i(2)  => SW(10),
            data6_i(1)  => SW(9),
            data6_i(0)  => SW(8),
            
            data7_i(3)  => SW(15),
            data7_i(2)  => SW(14),
            data7_i(1)  => SW(13),
            data7_i(0)  => SW(12),
            
            seg_o(6)    => CA,
            seg_o(5)    => CB,
            seg_o(4)    => CC,
            seg_o(3)    => CD,
            seg_o(2)    => CE,
            seg_o(1)    => CF,
            seg_o(0)    => CG,
            
            dig_o(0)    => AN(0),
            dig_o(1)    => AN(1),
            dig_o(2)    => AN(2),
            dig_o(3)    => AN(3),
            
            dig_o(4)    => AN(4),
            dig_o(5)    => AN(5),
            dig_o(6)    => AN(6),
            dig_o(7)    => AN(7),

            dp_i        => "11110111",
            dp_o        => DP
        );

end architecture Behavioral;
