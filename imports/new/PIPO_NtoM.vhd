----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2020 12:44:08
-- Design Name: 
-- Module Name: PIPO_NtoM - Behavioral
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

entity PIPO_NtoM is
       generic(P: integer:=30;--numero iterazioni -2
               N: integer:=9; --cardinalità
               M:integer:=287);
    Port ( 
          clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : out STD_LOGIC_VECTOR (M downto 0));
end PIPO_NtoM;

architecture Behavioral of PIPO_NtoM is
signal t:STD_LOGIC_VECTOR (M downto 0);
begin
process(en, rst, clk)
--variable i:integer:=P+1;  
begin

if rst= '1' then
t<= (others => '0');
--i:=P+2; 
else --m 287, n 9 p 30
    if(en = '1') then
     
        if(rising_edge(clk)) then
        
--            if i=0 then i:=P+1; 
--            else i:=i-1; 
--            end if; 
            
           for i in P downto 0 loop
            t(((M-N)-N*(i-1))downto ((M-(N-1))-N*i))<= t((((M-N)-N*i))downto ((M-(N-1))-N*(i+1)));
           end loop;
            t(N-1 downto 0)<= a;
        end if;
     end if; 
end if;
b<= t;

end process;

end Behavioral;
