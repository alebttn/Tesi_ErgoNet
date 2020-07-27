----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2020 17:36:02
-- Design Name: 
-- Module Name: xnor_3bit - Behavioral
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

entity xnor_3bit is
     Generic( D:integer:=48; --profondità filtri=16*3
             F:integer:=15);
    Port ( b_in1,b_in2,b_in3 : in STD_LOGIC_VECTOR (F downto 0);
           w1,w2,w3 : in STD_LOGIC_VECTOR (F downto 0);
           b : out STD_LOGIC_VECTOR (D-1 downto 0));
end xnor_3bit;

architecture Behavioral of xnor_3bit is
signal b1,b2,b3:STD_LOGIC_VECTOR (F downto 0);
begin
b1<= b_in1 xnor w1;  
b2<= b_in2 xnor w2;   
b3<= b_in3 xnor w3;

b<= b3 & b2 & b1;
end Behavioral;
