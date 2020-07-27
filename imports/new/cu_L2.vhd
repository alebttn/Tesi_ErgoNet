----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2020 11:53:59
-- Design Name: 
-- Module Name: cu_L2 - Behavioral
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

entity cu_L2 is
    Port ( en,clk,rst : in STD_LOGIC;
    -- rst_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
     conf_L2: out std_logic;
     cnt: out std_logic_vector(6 downto 0)); --variabile per contare fino a 36
end cu_L2;

architecture Behavioral of cu_L2 is
signal CONF_2: std_logic:='1';

begin
process(clk, en, rst) 
variable aux_in: unsigned (6 downto 0):="1111111"; 
begin
if( rst='1') then
   aux_in:= "1111111";
   conf_2<='0';
   --rst_split<= '1'; rst_pop<='1'; en_pop<='0'; rst_buff<='1'; rst_out<='1'; en_out<='0'; en_buff<='0';
else if (en='1') then 

if rising_edge(clk) then 
    if aux_in= "0100110" then --38
        conf_2<='1';
        aux_in := "1111110"; 
    else 
        aux_in := aux_in + "0000001"; conf_2<='0';
    end if; 
cnt<=std_logic_vector(aux_in);
end if;
end if; --en

end if; 
conf_l2<=conf_2;
end process; 


end Behavioral;
