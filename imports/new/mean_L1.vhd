----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2020 16:09:52
-- Design Name: 
-- Module Name: mean_L1 - Behavioral
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

entity mean_L2 is
    Generic(D:integer:=176; --11*16
            F:integer:=15;
            G:integer:=10);--cardinlità uscita
    Port ( rst_pop,en_pop,clk: in STD_LOGIC;
           bpop:out STD_LOGIC_VECTOR (D-1 downto 0);

           b_in1, b_in2,b_in3,b_in4,b_in5, b_in6, b_in7, b_in8, b_in9, b_in10, b_in11: in STD_LOGIC_VECTOR (F downto 0);
           w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11 : in STD_LOGIC_VECTOR (F downto 0);
           mean : out STD_LOGIC_VECTOR (G downto 0));
end mean_L2;

architecture Behavioral of mean_L2 is
signal b_xnor, b_xnor_s:STD_LOGIC_VECTOR (D-1 downto 0);
signal b_pop:STD_LOGIC_VECTOR (G-2 downto 0);
signal b_shift,vl:STD_LOGIC_VECTOR (G-1 downto 0);--vector lenght
component xnor_11bit is
    Generic(F:integer; --numero pesi-1
            D:integer); --profondità filtri=16*11
    Port ( b_in1, b_in2,b_in3,b_in4,b_in5, b_in6, b_in7, b_in8, b_in9, b_in10, b_in11: in STD_LOGIC_VECTOR (F downto 0);
           w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11 : in STD_LOGIC_VECTOR (F downto 0);
           b : out STD_LOGIC_VECTOR ((D-1) downto 0));
end component;

component popcount_L3 is
 Generic(D:integer;--depth 176
         B:integer:=9); --numero bit
    Port ( rst,en,clk: in STD_LOGIC;
           b_in : in STD_LOGIC_VECTOR ((D-1) downto 0);
           b_out : out STD_LOGIC_VECTOR ((B-1) downto 0));
end component;

component shift_sx is
    Generic(B:integer);--cardinalità
    Port ( b_in : in STD_LOGIC_VECTOR ((B-1) downto 0);
           b_sh : out STD_LOGIC_VECTOR (B downto 0));
end component;

component carry_Ripple is
    generic(N:integer);
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           cin : in STD_LOGIC; --nn serve: gli in sono a 8bit se entrano a 9 sicuramento il bit segno in out è 0 e il modulo finale non riceve altri cin
           sum : out STD_LOGIC_VECTOR (N+1 downto 0);
           cout : out STD_LOGIC);
end component;
component flipflop is
    Generic(N:integer:=176);
    Port ( clk, rst,en : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (N-1 downto 0);
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;

begin
vl<=std_logic_vector(to_unsigned(D,10));-- "0010110000"; --176

mult: xnor_11bit  Generic map(F=>15, D=>176) port map( b_in1, b_in2,b_in3,b_in4,b_in5, b_in6, b_in7, b_in8, b_in9, b_in10, b_in11, w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11 ,b_xnor);
fll: flipflop port map( clk=>clk, en=>en_pop, rst=>rst_pop, d=>b_xnor, q=>b_xnor_s);
count_one: popcount_L3 Generic map(B=>9, D=>176) port map(clk=>clk,rst=>rst_pop, en=>en_pop, b_in=>b_xnor_s, b_out=>b_pop); 
mult_for_two: shift_sx Generic map(B=>9) port map(b_in=> b_pop, b_sh=>b_shift);
sub: carry_Ripple Generic map(N=>9) port map(x1=> b_shift, x2=>vl, cin=> '1', sum=>mean);
bpop<= b_xnor_s;

end Behavioral;
