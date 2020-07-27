----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2020 09:37:20
-- Design Name: 
-- Module Name: Adder_Tree - Behavioral
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
--adder con moduli sommatori cardinalità 9
entity Adder_Tree is
    Generic(N:integer);--cardinalità-1 ingressi 
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           x3 : in STD_LOGIC_VECTOR (N downto 0);
           x4 : in STD_LOGIC_VECTOR (N downto 0);
           sum : out STD_LOGIC_VECTOR (N+2 downto 0));--10 bit
end Adder_Tree;

architecture Behavioral of Adder_Tree is
--signal x1_s, x2_s, x3_s, x4_s: STD_LOGIC_VECTOR (N+1 downto 0); --9 bit
signal add1, add2: STD_LOGIC_VECTOR (N+1 downto 0); --9 bit
signal riporto1, riporto2: std_logic;
component carry_Ripple is
    generic(N:integer);
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           cin : in STD_LOGIC; 
           sum : out STD_LOGIC_VECTOR (N+1 downto 0);
           cout : out STD_LOGIC);
end component;
begin

--cout dei primi due carry sempre 0 
primo_adder:carry_Ripple generic map (N=> N) port map( x1=> x1, x2=> x2, cin=>'0', sum=> add1, cout=> riporto1); 
secondo_adder:carry_Ripple generic map (N=> N) port map( x1=> x3, x2=> x4, cin=>'0', sum=> add2, cout=> riporto2); 
terzo_adder:carry_Ripple generic map (N=> N+1) port map( x1=> add1, x2=> add2, cin=>'0', sum=> sum); 

end Behavioral;
