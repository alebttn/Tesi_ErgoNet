----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2020 17:36:02
-- Design Name: 
-- Module Name: mean_L3 - Behavioral
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

entity mean_L3 is
    Generic(D:integer:=48; --16*3
            F:integer:=15;
            B:integer:=7); --max pop+segno 
    Port ( rst_pop,en_pop,clk:in std_logic;
           bpop:out std_logic_vector(6 downto 0);
           bxor:out std_logic_vector(47 downto 0);
           bsh:out std_logic_vector(7 downto 0);
           ------------
           b_in1,b_in2,b_in3 : in STD_LOGIC_VECTOR (F downto 0);
           w1,w2,w3 : in STD_LOGIC_VECTOR (F downto 0);
           mean : out STD_LOGIC_VECTOR (B+1 downto 0));
end mean_L3;

architecture Behavioral of mean_L3 is
component xnor_3bit is
     Generic( D:integer:=48; --profondità filtri=16*3
             F:integer:=15);
    Port ( b_in1,b_in2,b_in3 : in STD_LOGIC_VECTOR (F downto 0);
           w1,w2,w3 : in STD_LOGIC_VECTOR (F downto 0);
           b : out STD_LOGIC_VECTOR (D-1 downto 0));
end component;
component popcount_L3 is
    Generic(D:integer:=48;--depth 3*16
            B:integer:= 7); --numero bit (max 48)più segno
    Port ( rst,en,clk: in STD_LOGIC;
           b_in : in STD_LOGIC_VECTOR ((D-1) downto 0);
           b_out : out STD_LOGIC_VECTOR ((B-1) downto 0));
end component;
component shift_sx is
    Generic(B:integer);--cardinalità 6
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
signal b_pop: std_logic_vector(B-1 downto 0); --su 7 bit
signal b_xnor:std_logic_vector(D-1 downto 0);
signal b_shift,vl: std_logic_vector(B downto 0); --su 8 bit  
begin
vl<= "00110000"; --48

mult: xnor_3bit port map( b_in1, b_in2,b_in3,w1,w2,w3 ,b_xnor);
count_one: popcount_L3 port map(rst=>rst_pop,clk=>clk, en=>en_pop,b_in=>b_xnor, b_out=>b_pop); 
bpop<= b_pop; 
bxor<= b_xnor;
bsh<=b_shift;
mult_for_two: shift_sx Generic map(B=>7) port map(b_in=> b_pop, b_sh=>b_shift);
sub: carry_Ripple Generic map(N=>7) port map(x1=> b_shift, x2=>vl, cin=> '1', sum=>mean);
end Behavioral;

