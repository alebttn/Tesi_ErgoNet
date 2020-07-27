----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2020 15:18:19
-- Design Name: 
-- Module Name: PIPO11_to_176 - Behavioral
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

entity PIPO_45 is 
       generic(P: integer:=14;--numero iterazioni -2
               N: integer:=45; --cardinalità
               M:integer:=719); --8 to 383, P è quante volte ciclare-2 (ad es nel primo layer 48-2=46 volte)
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : out STD_LOGIC_VECTOR (M downto 0));
end PIPO_45;

architecture Behavioral of PIPO_45 is
signal t:STD_LOGIC_VECTOR (M downto 0);
signal t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37,t38,t39,t40,t41,t42,t43,t44,t45,t46,t47,t48:STD_LOGIC_VECTOR (15 downto 0);
begin
process(clk, en, rst) 
begin
if rst= '1' then
b<= (others => '0');
else
     if(en = '1') then
        if(rising_edge(clk)) then
        t(N-1 downto 0)<= a; 
                for i in P downto 0 loop
                t(((M-N)-N*(i-1))downto ((M-(N-1))-N*i))<= t((((M-N)-N*i))downto ((M-(N-1))-N*(i+1)));
                end loop;
        end if;
    end if; 
end if;
--riordino per ottenere un vettore di 45 dati da 16 bit
for i in 1 to 16 loop --719-
t45(15-(i-1))<= t(M-(i-1)*45);
t44(15-(i-1))<= t(M-1-(i-1)*45);
t43(15-(i-1))<= t(M-2-(i-1)*45);
t42(15-(i-1))<= t(M-3-(i-1)*45);
t41(15-(i-1))<= t(M-4-(i-1)*45);
t40(15-(i-1))<= t(M-5-(i-1)*45);
t39(15-(i-1))<= t(M-6-(i-1)*45);
t38(15-(i-1))<= t(M-7-(i-1)*45);
t37(15-(i-1))<= t(M-8-(i-1)*45);
t36(15-(i-1))<= t(M-9-(i-1)*45);
t35(15-(i-1))<= t(M-10-(i-1)*45);
t34(15-(i-1))<= t(M-11-(i-1)*45);
t33(15-(i-1))<= t(M-12-(i-1)*45);
t32(15-(i-1))<= t(M-13-(i-1)*45);
t31(15-(i-1))<= t(M-14-(i-1)*45);
t30(15-(i-1))<= t(M-15-(i-1)*45);
t29(15-(i-1))<= t(M-16-(i-1)*45);
t28(15-(i-1))<= t(M-17-(i-1)*45);
t27(15-(i-1))<= t(M-18-(i-1)*45);
t26(15-(i-1))<= t(M-19-(i-1)*45);
t25(15-(i-1))<= t(M-20-(i-1)*45);
t24(15-(i-1))<= t(M-21-(i-1)*45);
t23(15-(i-1))<= t(M-22-(i-1)*45);
t22(15-(i-1))<= t(M-23-(i-1)*45);
t21(15-(i-1))<= t(M-24-(i-1)*45);
t20(15-(i-1))<= t(M-25-(i-1)*45);
t19(15-(i-1))<= t(M-26-(i-1)*45);
t18(15-(i-1))<= t(M-27-(i-1)*45);
t17(15-(i-1))<= t(M-28-(i-1)*45);
t16(15-(i-1))<= t(M-29-(i-1)*45);
t15(15-(i-1))<= t(M-30-(i-1)*45);
t14(15-(i-1))<= t(M-31-(i-1)*45);
t13(15-(i-1))<= t(M-32-(i-1)*45);
t12(15-(i-1))<= t(M-33-(i-1)*45);
t11(15-(i-1))<= t(M-34-(i-1)*45);
t10(15-(i-1))<= t(M-35-(i-1)*45);
t9(15-(i-1))<= t(M-36-(i-1)*45);
t8(15-(i-1))<= t(M-37-(i-1)*45);
t7(15-(i-1))<= t(M-38-(i-1)*45);
t6(15-(i-1))<= t(M-39-(i-1)*45);
t5(15-(i-1))<= t(M-40-(i-1)*45);
t4(15-(i-1))<= t(M-41-(i-1)*45);
t3(15-(i-1))<= t(M-42-(i-1)*45);
t2(15-(i-1))<= t(M-43-(i-1)*45);
t1(15-(i-1))<= t(M-44-(i-1)*45);

end loop; 
b<= t45&t44&t43&t42&t41&t40&t39&t38&t37&t36&t35&t34&t33&t32&t31&t30&t29&t28&t27&t26&t25&t24&t23&t22&t21&t20&t19&t18&t17&t16&t15&t14&t13&t12&t11&t10&t9&t8&t7&t6&t5&t4&t3&t2&t1;

end process;

end Behavioral;
