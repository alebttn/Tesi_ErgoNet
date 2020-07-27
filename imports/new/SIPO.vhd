----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2020 16:13:53
-- Design Name: 
-- Module Name: SIPO - Behavioral
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

entity SIPO is
    Generic(N:integer);
    Port ( x : in STD_LOGIC_VECTOR (N downto 0);
           y1 : out STD_LOGIC_VECTOR (N downto 0);
           y2 : out STD_LOGIC_VECTOR (N downto 0);
           y3 : out STD_LOGIC_VECTOR (N downto 0);
           y4 : out STD_LOGIC_VECTOR (N downto 0);
           y5 : out STD_LOGIC_VECTOR (N downto 0);
           y6 : out STD_LOGIC_VECTOR (N downto 0);
           y7 : out STD_LOGIC_VECTOR (N downto 0);
           y8 : out STD_LOGIC_VECTOR (N downto 0);
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC);
end SIPO;

architecture Behavioral of SIPO is
signal t1,t2,t3,t4,t5,t6,t7,t8:STD_LOGIC_VECTOR (N downto 0);
begin
process(clk, rst, x)
begin
if(rst='1') then 
y1<=(others=>'0');
y2<=(others=>'0');
y3<=(others=>'0');
y4<=(others=>'0');
y5<=(others=>'0');
y6<=(others=>'0');
y7<=(others=>'0');
y8<=(others=>'0');
else 
    if en='1' then
    if (rising_edge(clk)) then 
   t8<=x; 
--    t31<=t32; y31<=t31; t30<=t31; y30<= t30; t29<=t30; y29<=t29; t28<=t29; y28<=t28; t27<=t28; y27<= t27; t26<=t27; y26<=t26; 
--    t25<=t26; y25<=t25; t24<=t25; y24<= t24; t23<=t24; y23<=t23; t22<=t23; y22<=t22; t21<=t22; y21<=t21;
--    t20<=t21; y20<=t20; t19<=t20; y19<= t19; t18<=t19; y18<=t18; t17<=t18; y17<=t17; t16<=t17; y16<=t16;
--    t15<=t16; y15<=t15; t14<=t15; y14<= t14; t13<=t14; y13<=t13; t12<=t13; y12<=t12; t11<=t12; y11<=t11;
--    t10<=t11; y10<=t10; t9<=t10; y9<= t9; t8<=t9; 
    y8<=t8; t7<=t8; y7<=t7; t6<=t7; y6<=t6;
    t5<=t6; y5<=t5; t4<=t5; y4<= t4; t3<=t4; y3<=t3; t2<=t3; y2<=t2; t1<=t2; y1<=t1;

    end if;
    end if;
end if;
end process;
end Behavioral;
