----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2020 16:28:34
-- Design Name: 
-- Module Name: mux_sign - Behavioral
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

entity mux_sign is
    Generic (N:integer; --cardinalità-1 dell'ingresso
             M:integer); --sempre 3
    Port ( weigh : in STD_LOGIC_VECTOR (M downto 0);
           x0 : in STD_LOGIC_VECTOR (N downto 0);
           y0 : out STD_LOGIC_VECTOR (N downto 0);
           x1 : in STD_LOGIC_VECTOR (N downto 0);
           y1 : out STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           y2 : out STD_LOGIC_VECTOR (N downto 0);
           x3 : in STD_LOGIC_VECTOR (N downto 0);
           y3 : out STD_LOGIC_VECTOR (N downto 0));
end mux_sign;

architecture Behavioral of mux_sign is
signal x1_not, x2_not, x3_not, x0_not, uno : STD_LOGIC_VECTOR (N downto 0);
signal un: STD_LOGIC_VECTOR (N-1 downto 0);
begin
un<= (others=> '0'); 
uno <= un & '1';
x0_not<= std_logic_vector(unsigned(not(x0)) + unsigned(uno));
x1_not<= std_logic_vector(unsigned(not(x1)) + unsigned(uno));
x2_not<= std_logic_vector(unsigned(not(x2)) + unsigned(uno));
x3_not<= std_logic_vector(unsigned(not(x3)) + unsigned(uno));

with weigh(0) select 
y0<= x0 when '1', 
    x0_not when '0',
   ( others=>'-') when others;
with weigh(1) select 
y1<= x1 when '1', 
    x1_not when '0',
    ( others=>'-') when others;
with weigh(2) select 
y2<= x2 when '1', 
    x2_not when '0',
    ( others=>'-') when others;
with weigh(3) select 
y3<= x3 when '1', 
    x3_not when '0',
    ( others=>'-') when others;


end Behavioral;
