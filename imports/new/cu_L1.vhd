----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2020 11:59:31
-- Design Name: 
-- Module Name: cu_L1 - Behavioral
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

entity cu_L1 is
    Port ( clk,rst,en : in STD_LOGIC;
     conf_L1: out std_logic;
    rst_split,en_split, en_out, rst_out,rst_buff, en_buff:out std_logic;
     cnt: out std_logic_vector(6 downto 0));
end cu_L1;
architecture Behavioral of cu_L1 is
signal conf_1:  std_logic:='1';
begin
process(clk, en, rst) 
variable aux_in: unsigned (6 downto 0):="0000000"; 
begin
if( rst='1') then
   aux_in:= "1111110";
   conf_1<='0';
   rst_split<='1'; en_split<='0'; en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='1';
else if (en='1') then 

if rising_edge(clk) then 

    if aux_in= "0101110" then --46
    conf_1<='1';
    aux_in := "1111110"; --necessito di un ciclo di latenza per avere la media del filtro successivo all'indirizzo 0 
    
    else 
    aux_in := aux_in + "0000001"; 
    conf_1<='0';
    end if; 
cnt<=std_logic_vector(aux_in);
end if;
end if; --en
if aux_in="0000000" then 
rst_split<='0'; en_split<='1';
en_buff<='1'; rst_buff<='0'; 
en_out<='0'; rst_out<='0';

elsif aux_in="0000001" then 
rst_split<='0'; en_split<='1';
en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0000010" then 
rst_split<='0'; en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0000011" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0000100" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0000101" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0000110" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0000111" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001000" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001001" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001010" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001011" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001100" then 
rst_split<='0';en_split<='1';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001101" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001110" then 
rst_split<='0';en_split<='1';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0001111" then 
rst_split<='0';en_split<='1';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0010000" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0010001" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0010010" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0010011" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0010100" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0010101" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0010110" then 
rst_split<='0'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
en_split<='1';
elsif aux_in="0010111" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011000" then 
rst_split<='0';en_split<='1';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011001" then 
rst_split<='0'; en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011010" then 
rst_split<='0';en_split<='1';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011011" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011100" then 
rst_split<='0'; en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011101" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011110" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0011111" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0100000" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0100001" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100010" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100011" then 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0100100" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100101" then 
rst_split<='0'; en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100110" then 
rst_split<='0';en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0100111" then 
rst_split<='0'; en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0101000" then 
rst_split<='0'; en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0101001" then 
rst_split<='0'; en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0101010" then 
rst_split<='0'; en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0101011" then 
rst_split<='0'; en_split<='1';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
elsif aux_in="0101100" then 
rst_split<='0'; en_split<='0'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--elsif aux_in="0101101" then --45
--rst_split<='0';  en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0101101" then --45
rst_split<='0'; en_split<='0';en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

elsif aux_in="0101110" then --46
rst_split<='0';en_split<='0'; en_buff<='1'; rst_buff<='0'; en_out<='1'; rst_out<='0';

elsif aux_in="1111110" then --126
rst_split<='0';en_split<='0'; en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
elsif aux_in="1111111" then 
rst_split<='0';en_split<='1'; en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
--elsif aux_in="0101111" then 
--rst_split<='0'; rst_in<='0'; en_in<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--elsif aux_in="0110000" then 
--rst_split<='1'; rst_in<='1'; en_in<='0'; en_buff<='0'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--elsif aux_in="0110001" then 
--rst_split<='1'; rst_in<='1'; en_in<='0'; en_buff<='0'; rst_buff<='1'; en_out<='1'; rst_out<='0';
else 
rst_split<='0';en_split<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';

--null;
--rst_split<='1'; 
 
--en_buff<='0'; rst_buff<='1'; 
--en_out<='0'; rst_out<='0'; 
end if; 
end if; 
conf_l1<=conf_1;
end process; 



end Behavioral;
