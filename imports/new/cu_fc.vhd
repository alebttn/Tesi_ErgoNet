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

entity cu_fc is
    Port ( clk,rst,en : in STD_LOGIC;
    CONF_fc: OUT STD_LOGIC;  
     en_res,rst_res,en_sipo,rst_sipo: out std_logic;
     aux_in: in std_logic_vector(3 downto 0)); --variabile per contare fino a 7
end cu_fc;

architecture Behavioral of cu_fc is
--SIGNAL CONF_fc: STD_LOGIC:='1'; 

begin
process(clk, en, rst) 
--variable aux_in: unsigned (3 downto 0):="1111"; 
begin
if( rst='1') then
   
   CONF_fc<='0'; 
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '1'; en_sipo<='0';  
else 
    if (en='1') then 

        if rising_edge(clk) then 
           
if aux_in="0000" then  --partono i dati in ingresso
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1'; conf_fc<= '0';

elsif aux_in="0001" then --elaborazione e salvataggio primo bit
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1'; conf_fc<= '0';
elsif aux_in="0010" then 
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1'; conf_fc<= '0';
elsif aux_in="0011" then 
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';conf_fc<= '0';
elsif aux_in="0100" then 
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';conf_fc<= '0';
elsif aux_in="0101" then --5
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';conf_fc<= '0';
elsif aux_in="0110" then --6
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';conf_fc<= '0';
elsif aux_in="0111" then --7
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';conf_fc<= '0';
elsif aux_in="1000" then --8
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';conf_fc<= '0';
elsif aux_in="1001" then --9
   rst_res<= '1'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='0';conf_fc<= '0';
elsif aux_in="1010" then --10
   rst_res<= '0'; en_res<='1';
   rst_sipo<= '0'; en_sipo<='0';
   conf_fc<= '1';
elsif aux_in="1111" then --15
   rst_res<= '0'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';
   conf_fc<= '0';
else
   rst_res<= '0'; en_res<='0';
   rst_sipo<= '0'; en_sipo<='1';
   conf_fc<= '0'; 

end if; 

end if; 
end if;
end if;
end process; 


end Behavioral;

