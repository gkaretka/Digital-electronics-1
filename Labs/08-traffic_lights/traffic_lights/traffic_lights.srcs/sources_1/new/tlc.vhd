----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2021 10:27:28 AM
-- Design Name: 
-- Module Name: tlc - Behavioral
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

entity tlc is
    Port (
    clk     :   in  std_logic;
    reset   :   in  std_logic;
    
    south_o :   out std_logic_vector(3 - 1 downto 0);
    west_o  :   out std_logic_vector(3 - 1 downto 0)
    );
end tlc;

architecture Behavioral of tlc is
    type    t_state is (STOP1, WEST_GO, WEST_WAIT, STOP2, SOUTH_GO, SOUTH_WAIT);
    
    signal  s_state :   t_state;
    
    signal  s_en    :   std_logic;
    
    signal  s_cnt   :   unsigned(5 - 1 downto 0);
    
    constant c_DELAY_GO     :   unsigned(5 - 1 downto 0)  := b"1_0000";
    constant c_DELAY_WAIT   :   unsigned(5 - 1 downto 0)  := b"0_1000";
    constant c_DELAY_1S     :   unsigned(5 - 1 downto 0)  := b"0_0100";
    constant c_ZERO         :   unsigned(5 - 1 downto 0)  := b"0_0000";
begin


end Behavioral;
