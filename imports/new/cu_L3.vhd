----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2020 19:40:21
-- Design Name: 
-- Module Name: cu_L3 - Behavioral
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

entity cu_L3 is
    Port ( clk,rst,en : in STD_LOGIC;
    --CONF_l3: OUT STD_LOGIC;    
    -- rst_split,en_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
    -- rst_pop_gap,en_pop_gap, en_out_gap, rst_out_gap:out std_logic;
     cnt: out std_logic_vector(6 downto 0)); --variabile per contare fino a 33
end cu_L3;

architecture Behavioral of cu_L3 is
--SIGNAL CONF_3: STD_LOGIC:='1'; 
signal cnt_s: std_logic_vector(6 downto 0);
begin
process(clk, en, rst) 
variable aux_in: unsigned (6 downto 0):="0000000"; 

begin

if( rst='1') then
   aux_in:= "1111111";
  -- CONF_3<='0'; 
  -- rst_split<= '1';en_split<='0'; rst_pop<='1'; en_pop<='0'; rst_buff<='1'; rst_out<='1'; en_out<='0'; en_buff<='0';
  -- rst_pop_gap<='1'; rst_out_gap<='1'; en_pop_gap<='0'; en_out_gap<='0'; 
else if (en='1') then 

if rising_edge(clk) then 
    if aux_in= "0100100" then --36
    
    aux_in := "1111110"; 
--    elsif aux_in = "1111110" then
--    CONF_3<='1';
    else 
    aux_in := aux_in + "0000001"; --conf_3<='0';
    end if; 
cnt<=std_logic_vector(aux_in);
--cnt<= cnt_s;
end if;
end if; --en

end if; 
--CONF_l3<=conf_3;
end process; 
--process (cnt_s) 
--begin 
--if cnt_s="0000000" then  --partono i dati in ingresso
--rst_split<='0'; en_split<='1';
--rst_pop<='1'; en_pop<='0'; 
--en_buff<='0'; rst_buff<='1'; 
--en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0'; 

--elsif cnt_s="0000001" then --elaborazione e salvataggio primo bit
--rst_split<='0';en_split<='1'; rst_pop<='1'; en_pop<='0'; en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1';en_split<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0'; 
--elsif cnt_s="0000010" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0'; 
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0000011" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0000100" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0000101" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0000110" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0000111" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001000" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001001" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001010" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001011" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001100" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001101" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001110" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0001111" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010000" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010001" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010010" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010011" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010100" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010101" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010110" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0010111" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011000" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011001" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011010" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011011" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011100" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011101" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011110" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0011111" then 
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0100000" then 
--rst_split<='0';en_split<='1'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0100001" then --33
--rst_split<='0';en_split<='0'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0100010" then --salvataggio ed elaborazione bit 33
--rst_split<='0';en_split<='0'; rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0100011" then --parte l elaborazione del gap e il salvataggio 
--rst_split<='0'; en_split<='0';rst_pop<='0'; en_pop<='0'; en_buff<='1'; rst_buff<='0'; en_out<='1'; rst_out<='0';
--rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--elsif cnt_s="0100100" then --mostra il risultato
--rst_split<='0'; en_split<='0';rst_pop<='0'; en_pop<='0'; en_buff<='0'; rst_buff<='1'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='1'; en_out_gap<='0';
--elsif cnt_s= "1111110" then
--   rst_split<= '0';en_split<='0'; rst_pop<='0'; en_pop<='0'; rst_buff<='1'; rst_out<='0'; en_out<='0'; en_buff<='0';
--   rst_pop_gap<='0'; rst_out_gap<='0'; en_pop_gap<='1'; en_out_gap<='1'; 
--elsif cnt_s= "1111111" then
--   rst_split<= '0'; en_split<='0';rst_pop<='1'; en_pop<='0'; rst_buff<='1'; rst_out<='1'; en_out<='0'; en_buff<='0';
--   rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';  
--else
--rst_split<='0'; en_split<='1';rst_pop<='0'; en_pop<='1'; en_buff<='1'; rst_buff<='0'; en_out<='0'; rst_out<='0';
--rst_pop_gap<='1'; rst_out_gap<='0'; en_pop_gap<='0'; en_out_gap<='0';
--end if;
--end process;

end Behavioral;

