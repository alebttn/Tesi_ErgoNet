----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2020 11:14:02
-- Design Name: 
-- Module Name: Class - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Class is
    Port ( clk, rst,en : in STD_LOGIC;
           perc1,perc2,perc3,perc4,perc5,perc6,perc7,perc8,class_s: in STD_LOGIC_VECTOR (13 downto 0);
           classe: out STD_LOGIC_VECTOR(3 downto 0));
end Class;
architecture Behavioral of Class is

begin

process(clk,en) 
begin 
if(rst='1') then classe<="0000";
else 
    if(en='1') then 
        if(rising_edge(clk)) then 
if class_s=perc1 then classe<="0001"; 
elsif class_s=perc2 then classe<="0010"; 
elsif class_s=perc3 then classe<="0011"; 
elsif class_s=perc4 then classe<="0100"; 
elsif class_s=perc5 then classe<="0101"; 
elsif class_s=perc6 then classe<="0110"; 
elsif class_s=perc7 then classe<="0111"; 
elsif class_s=perc8 then classe<="1000"; 
else classe<="1111"; 
end if; 
        end if;
    end if; 
end if;
end process; 
end Behavioral;
