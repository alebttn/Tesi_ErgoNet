----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2020 15:33:40
-- Design Name: 
-- Module Name: xnor_11bit - Behavioral
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

entity xnor_11bit is
    Generic( D:integer:=176; --profondità filtri=16*11
             F:integer:=15);
    Port ( 
        --  b_in: in STD_LOGIC_VECTOR ((D-1) downto 0); --sono 11 word da 16 bit, da 0 a 15 b0, da 16 a 24 b1 ecc
          b_in1, b_in2,b_in3,b_in4,b_in5, b_in6, b_in7, b_in8, b_in9, b_in10, b_in11: in STD_LOGIC_VECTOR (F downto 0);
          w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11 : in STD_LOGIC_VECTOR (F downto 0);
         -- w:in STD_LOGIC_VECTOR ((D-1) downto 0);
          b : out STD_LOGIC_VECTOR ((D-1) downto 0));
end xnor_11bit;

architecture Behavioral of xnor_11bit is
signal b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11:STD_LOGIC_VECTOR (F downto 0);
begin
b1<= b_in1 xnor w1; b7<= b_in7 xnor w7;  
b2<= b_in2 xnor w2; b8<= b_in8 xnor w8;  
b3<= b_in3 xnor w3; b9<= b_in9 xnor w9;  
b4<= b_in4 xnor w4; b10<= b_in10 xnor w10;  
b5<= b_in5 xnor w5; b11<= b_in11 xnor w11; 
b6<= b_in6 xnor w6; 
--b<= b_in xnor w;
b<= b11 & b10 & b9 & b8 & b7 & b6 & b5 & b4 & b3 & b2 & b1;
end Behavioral;
