----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2021 08:14:57 PM
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
        BTNU    :   in  std_logic;
        BTNC    :   in  std_logic;
        SW      :   in  std_logic_vector(1 - 1 downto 0);
        LED	    :   out std_logic_vector(4 - 1 downto 0)
    );
end top;

architecture Behavioral of top is
    signal  s_q     :   std_logic_vector(4 - 1 downto 0);
    signal  s_dbnc  :   std_logic_vector(4 - 1 downto 0);
begin

    --------------------------------------------------------------------
    -- Four instances (copies) of D type FF entity
    d_ff_0 : entity work.d_ff_rst
        port map(
            clk => BTNU,
            rst => BTNC,
            d   => SW(0),
            q   => s_q(0)
        );

    d_ff_1 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            d   => s_q(0),
            q   => s_q(1)
        );
        
    d_ff_2 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            d   => s_q(1),
            q   => s_q(2)
        );
        
    d_ff_3 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            d   => s_q(2),
            q   => s_q(3)
        );
        
    LED <=  s_q;
end Behavioral;
