----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2020 16:00:01
-- Design Name: 
-- Module Name: shift_sx - Behavioral
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

entity shift_sx is
    Generic(B:integer);--cardinalità
    Port ( b_in : in STD_LOGIC_VECTOR ((B-1) downto 0);
           b_sh : out STD_LOGIC_VECTOR (B downto 0));
end shift_sx;

architecture Behavioral of shift_sx is

begin
b_sh<= b_in & '0';

end Behavioral;
