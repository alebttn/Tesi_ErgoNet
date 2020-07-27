----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.05.2020 13:13:43
-- Design Name: 
-- Module Name: Adder_tree_last_ly - Behavioral
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

entity Adder_tree_last_ly is
  Generic(D:integer:=32;--numero di dati in ingresso 
          C:integer:=9; --cardinalità dati
          BS1:integer:=36; --cardinalità dati del primo blocco di somme (9bit*4 dati) 
          S1:integer:=88; --((C+2)*(D/4)); --cardinalità somma 1 
          BS2: integer:=44; --cardinalità ingresso secondo adder tree*4 = 11*4=44
          S2:integer:=26; --uscita secondo adder tree  *2 (entrano 11 bit, escono 11+2=13*2=26)
         B:integer:=14); --numero bit
    Port ( 
           ingresso : in STD_LOGIC_VECTOR ((D*C-1) downto 0);--32*9 288
           s:out std_logic_vector(B-1 downto 0));
end Adder_tree_last_ly;

architecture Behavioral of Adder_tree_last_ly is
component Adder_Tree is
    Generic(N:integer);--cardinalità-1 ingressi 
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           x3 : in STD_LOGIC_VECTOR (N downto 0);
           x4 : in STD_LOGIC_VECTOR (N downto 0);
           sum : out STD_LOGIC_VECTOR (N+2 downto 0));--10 bit
end component;
component carry_Ripple is
    generic(N:integer);
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           cin : in STD_LOGIC; 
           sum : out STD_LOGIC_VECTOR (N+1 downto 0);
           cout : out STD_LOGIC);
end component;
signal sum1: std_logic_vector(S1-1 downto 0); --11 bit per 8 (numero dati/4 ingressi) , 87
signal sum2: std_logic_vector(S2-1 downto 0); --uscita secondo adder tree  *2 (entrano 11 bit, escono 11+2=13*2=26)
begin

Ramo1: for i in 1 to (D/4) generate 
begin
add1:component Adder_Tree generic map(N=>C-1) port map(
x4=>ingresso((D*C-1)-BS1*(i-1) downto (D*C-C)-BS1*(i-1)), 
x3=>ingresso((D*C-1-C)-BS1*(i-1)downto (D*C-2*C)-BS1*(i-1)),
x2=>ingresso(((D*C-1-2*C)-BS1*(i-1))downto ((D*C-3*C)-BS1*(i-1))), 
x1=>ingresso(((D*C-1-3*C)-BS1*(i-1)) downto ((D*C-4*C)-BS1*(i-1))), sum=>sum1(S1-1-(C+2)*(i-1) downto (S1-(C+2))-(C+2)*(i-1))); 
end generate;
Ramo2: for i in 1 to (D/16) generate 
begin
add2:component Adder_Tree generic map(N=>(C-1)+2) port map( --11bit
x4=>sum1((S1-1)-BS2*(i-1) downto (S1-(C+2))-BS2*(i-1)), 
x3=>sum1((S1-1-(C+2))-BS2*(i-1)downto (S1-2*(C+2))-BS2*(i-1)),
x2=>sum1(((S1-1-2*(C+2))-BS2*(i-1))downto ((S1-3*(C+2))-BS2*(i-1))), 
x1=>sum1(((S1-1-3*(C+2))-BS2*(i-1)) downto ((S1-4*(C+2))-BS2*(i-1))), sum=>sum2((S2-1-(C+4)*(i-1)) downto (S2-(C+4)-(C+4)*(i-1)))); 
end generate;
Ramo3:carry_Ripple generic map (N=>12) port map (cin=>'0', x1=>sum2(S2-1-(C+4) downto 0), x2=> sum2(S2-1 downto S2-(C+4)), sum=>s);
end Behavioral;
