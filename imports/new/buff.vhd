----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2020 11:44:34
-- Design Name: 
-- Module Name: buff - Behavioral
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

entity buff is
 generic(P: integer:=34;--numero iterazioni -1
         M:integer:=34); --8 to 383, P è quante volte ciclare-2 (ad es nel primo layer 48-2=46 volte)
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC;
           b : out STD_LOGIC_VECTOR (M downto 0));
end buff;

architecture Behavioral of buff is
signal t:STD_LOGIC_VECTOR (M downto 0);
begin
process(clk, en, rst) 
variable i:integer:=P+1; 
begin

if rst= '1' then
t<= (others => '0');
i:=0; 
else
if(en = '1') then

if(rising_edge(clk)) then
if i=0 then i:=P+1; 
else i:=i-1; end if; 
t(i-1)<= a; 
--for i in 1 to P loop
--t(i)<= t(i-1);
--end loop;
end if;
end if; 
end if;
b<= t;
end process; 
end Behavioral;
