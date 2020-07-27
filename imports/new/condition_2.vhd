----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.06.2020 09:16:10
-- Design Name: 
-- Module Name: condition_2 - Behavioral
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

entity condition_2 is
    Port ( clk, en ,rst : in STD_LOGIC;
            rst_split,en_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
            aux_in: in std_logic_vector(6 downto 0));
end condition_2;

architecture Behavioral of condition_2 is

begin
process (clk, en, rst) 
begin
if rst='1' then 
rst_split<= '1';en_split<= '0';  rst_pop<='1'; en_pop<='0'; rst_buff<='1'; rst_out<='1'; en_out<='0'; en_buff<='0';
else
    if en= '1' then 
        if rising_edge(clk) then 
    if aux_in="0000000" then 
rst_split<='0'; 
rst_pop<='0';en_split<= '1'; en_pop<='1'; 
en_buff<='0'; rst_buff<='0'; 
en_out<='0'; rst_out<='0';
elsif aux_in="0000001" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='0'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0000010" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0'; 
elsif aux_in="0000011" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0000100" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0000101" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0000110" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0000111" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001000" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001001" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001010" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001011" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001100" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001101" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001110" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0001111" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010000" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010001" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010010" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010011" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010100" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010101" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010110" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0010111" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011000" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011001" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011010" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011011" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011100" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011101" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011110" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0011111" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100000" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100001" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100010" then 
rst_split<='0';en_split<= '0'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100011" then --35
rst_split<='0';en_split<= '0'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100100" then 
rst_split<='0';en_split<= '0'; rst_pop<='0'; en_pop<='1';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100101" then 
rst_split<='0';en_split<= '0'; rst_pop<='0'; en_pop<='1';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100110" then --38
rst_split<='0';en_split<= '0'; rst_pop<='0'; en_pop<='1';en_buff<='0'; rst_buff<='0'; en_out<='1'; rst_out<='0';
elsif aux_in="1111110" then 
rst_split<='0';en_split<= '0'; rst_pop<='0'; en_pop<='1';en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
elsif aux_in="1111111" then 
rst_split<='0';en_split<= '1'; rst_pop<='0'; en_pop<='1';en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
else 
rst_split<='0';en_split<= '0'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
end if;
--null;
--rst_split<='0'; 
--rst_pop<='0'; en_pop<='1'; 
--en_buff<='0'; rst_buff<='0'; 
--en_out<='0'; rst_out<='0'; 
        end if;  
     end if; 
end if; 
end process;
    

end Behavioral;
