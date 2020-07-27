----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.06.2020 19:32:38
-- Design Name: 
-- Module Name: condition_1 - Behavioral
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

entity condition_3 is
    Port ( clk,en,rst: in std_logic;
    cnt_s : in STD_LOGIC_VECTOR (6 downto 0);
    CONF_3: OUT STD_LOGIC; 
rst_split,en_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
     rst_pop_gap,en_pop_gap, en_out_gap, rst_out_gap:out std_logic);
 end condition_3;

architecture Behavioral of condition_3 is
--SIGNAL CONF_3: STD_LOGIC:='1';
begin
          
process (clk, en, rst) 
begin 
if rst = '1' then 
 rst_split<= '1';en_split<='0'; rst_pop<='1'; en_pop<='0'; rst_buff<='1'; rst_out<='1'; en_out<='0'; en_buff<='0';
   rst_pop_gap<='1'; rst_out_gap<='1'; en_pop_gap<='0'; en_out_gap<='0'; 
   CONF_3<='0';
   else if en= '1' then 
    if rising_edge(clk) then 
if cnt_s="0000000" then  --partono i dati in ingresso
rst_split<='0'; en_split<='1';
rst_pop<='1'; en_pop<='0'; 
en_buff<='0'; rst_buff<='1'; 
en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
CONF_3<='0'; 

elsif cnt_s="0000001" then --elaborazione e salvataggio primo bit
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='1'; en_pop<='0'; en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1';en_split<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0'; 
elsif cnt_s="0000010" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0'; 
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0000011" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0000100" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0000101" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0000110" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0000111" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001000" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001001" then
CONF_3<='0'; 
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001010" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001011" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001100" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001101" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001110" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0001111" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010000" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010001" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010010" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010011" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010100" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010101" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010110" then
CONF_3<='0'; 
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0010111" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011000" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011001" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011010" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011011" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011100" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011101" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011110" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0011111" then 
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0100000" then 
CONF_3<='0';
rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0100001" then --33
CONF_3<='0';
rst_split<='0';en_split<='0'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
elsif cnt_s="0100010" then --salvataggio ed elaborazione bit 33
CONF_3<='0';
rst_split<='0';en_split<='0'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
CONF_3<='0';
elsif cnt_s="0100011" then --parte l elaborazione del gap e il salvataggio 
rst_split<='0'; en_split<='0';rst_pop<='0'; en_pop<='0'; en_buff<='1'; rst_buff<='0'; en_out<='1'; rst_out<='0';
rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
CONF_3<='0';
elsif cnt_s="0100100" then --mostra il risultato
rst_split<='0'; en_split<='0';rst_pop<='0'; en_pop<='0'; en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='1'; en_out_gap<='0';
CONF_3<='0';
elsif cnt_s= "1111110" then
   rst_split<= '0';en_split<='0'; rst_pop<='0'; en_pop<='0'; rst_buff<='1'; rst_out<='0'; en_out<='0'; en_buff<='0';
   rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='1'; en_out_gap<='1'; 
   CONF_3<='1';
elsif cnt_s= "1111111" then
CONF_3<='0';
   rst_split<= '0'; en_split<='0';rst_pop<='1'; en_pop<='0'; rst_buff<='1'; rst_out<='1'; en_out<='0'; en_buff<='0';
   rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';  
else
CONF_3<='0';
rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
end if;
    end if;
  end if;
end if;
end process;

end Behavioral;
