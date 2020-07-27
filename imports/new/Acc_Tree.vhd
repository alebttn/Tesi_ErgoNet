----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2020 16:41:57
-- Design Name: 
-- Module Name: carry_Ripple - Behavioral
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
--modulo a 9 bit
entity carry_Ripple is
    generic(N:integer);
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           cin : in STD_LOGIC; --nn serve: gli in sono a 8bit se entrano a 9 sicuramento il bit segno in out è 0 e il modulo finale non riceve altri cin
           sum : out STD_LOGIC_VECTOR (N+1 downto 0);
           cout : out STD_LOGIC);
end carry_Ripple;

architecture Behavioral of carry_Ripple is
signal x_s2: std_logic_vector(N downto 0); 
signal prop, gen,x_s1, xss_2: std_logic_vector(N+1 downto 0); 
--vettore dei carry out
signal aux: std_logic_vector(N+2 downto 1); 

function valuta ( 
b: in STD_LOGIC_VECTOR (N downto 0);
op: in std_logic) 
return STD_LOGIC_VECTOR is 
variable bb:STD_LOGIC_VECTOR (N downto 0); 
begin 
if( op= '0') then 
bb:= b; 
else 
bb:= not(b);
end if;
return bb; 
end valuta; 
begin
x_s2 <= valuta (x2, cin);
xss_2<= x_s2(N) & x_s2;
x_s1<= x1(N) & x1;
prop    <= x_s1 xor xss_2; 
gen     <= x_s1 and xss_2; 
--if cin=0 aux(0) <= gen(0) 
aux(1)  <= gen(0) or (prop(0) and cin); 
sum(0)  <= x_s1(0) xor xss_2(0) xor cin;
process( x_s1, xss_2) 
begin
    for i in 2 to N+2 loop
        aux(i)  <= gen(i-1) or (prop(i-1) and aux(i-1)); 
        sum(i-1) <= x_s1(i-1) xor xss_2(i-1) xor aux(i-1); 
    end loop; 
cout    <= aux(N+2); 
end process; 

end Behavioral;
