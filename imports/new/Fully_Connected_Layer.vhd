----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2020 08:19:42
-- Design Name: 
-- Module Name: Fully_Connected_Layer - Behavioral
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

entity Fully_Connected_Layer is
    generic(N:integer:= 288; --cardinalità ingresso
            P: integer:= 32; --numero pesi
            C:integer:=9; --cardinalità dati
      --      M:integer:= 449;--10*45-1
            B:integer:=14);  --cardinalità uscita adder tree
    Port ( clk, rst_sipo, en_sipo, en_out,rst_out, en_in, rst_in : in STD_LOGIC;
           --conf_f:out std_logic; 
           ingresso : in STD_LOGIC_VECTOR (N-1 downto 0);
           pesi : in STD_LOGIC_VECTOR (P-1 downto 0);
           t_s :out  STD_LOGIC_VECTOR (N-1 downto 0);--test
           sum_s : out STD_LOGIC_VECTOR (B-1 downto 0);-- test
           mov : out STD_LOGIC_VECTOR (3 downto 0);
           perc1_s,perc2_s,perc3_s,perc4_s,perc5_s,perc6_s,perc7_s,perc8_s : out STD_LOGIC_VECTOR (B-1 downto 0));
end Fully_Connected_Layer;

architecture Behavioral of Fully_Connected_Layer is
signal class_s:  STD_LOGIC_VECTOR(13 downto 0); 
signal perc1,perc2,perc3,perc4,perc5,perc6,perc7,perc8 :  STD_LOGIC_VECTOR (B-1 downto 0);

function max_tree_reduction(x1,x2,x3,x4,x5,x6,x7,x8 : STD_LOGIC_VECTOR)
return std_logic_vector is 
   type my_type is array(0 to 7) of signed (x1'range);
   variable in1,in2,in3,in4,in5,in6,in7,in8  : signed(13 downto 0); 
   variable tmp: my_type;
   variable i,j : integer;
begin
  in1:=signed(x1);in2:=signed(x2);in3:=signed(x3);in4:=signed(x4);in5:=signed(x5);in6:=signed(x6);in7:=signed(x7);in8:=signed(x8); 
  tmp := (in1,in2,in3,in4,in5,in6,in7,in8);
  for lvl  in 0 to tmp'right/2 loop -- should be log2(tmp'right)
      for itm in 0 to tmp'right loop
           i := 2**(lvl+1) * itm;
           j := i + 2**lvl;
           next when ((i > tmp'right) or (j > tmp'right));
           if (tmp(j) > tmp(i)) then
               tmp(i) := tmp(j);

            end if; 
           
       end loop;
    end loop;
    return std_logic_vector(tmp(0));
end max_tree_reduction;

component SIPO is
    Generic(N:integer);
    Port ( x : in STD_LOGIC_VECTOR (N downto 0);
           y1,y2,y3,y4,y5,y6,y7, y8: out STD_LOGIC_VECTOR (N downto 0);
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;
component mux_sign is
    Generic (N:integer; --cardinalità-1 dell'ingresso
             M:integer:=3); --sempre 3 
    Port ( weigh : in STD_LOGIC_VECTOR (M downto 0);
           x0 : in STD_LOGIC_VECTOR (N downto 0);
           y0 : out STD_LOGIC_VECTOR (N downto 0);
           x1 : in STD_LOGIC_VECTOR (N downto 0);
           y1 : out STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           y2 : out STD_LOGIC_VECTOR (N downto 0);
           x3 : in STD_LOGIC_VECTOR (N downto 0);
           y3 : out STD_LOGIC_VECTOR (N downto 0));
end component;
component Adder_tree_last_ly is
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
end component;
component Class is
    Port ( clk, rst,en : in STD_LOGIC;
           perc1,perc2,perc3,perc4,perc5,perc6,perc7,perc8,class_s: in STD_LOGIC_VECTOR (13 downto 0);
           classe: out STD_LOGIC_VECTOR(3 downto 0));
end component;
component flipflop is
    Generic(N:integer:=288);
    Port ( clk, rst,en : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (N-1 downto 0);
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;
signal t,ingresso_s :  STD_LOGIC_VECTOR (N-1 downto 0);
signal sum :  STD_LOGIC_VECTOR (B-1 downto 0);--14-1
signal classe: std_logic_vector(3 downto 0); 

begin

elaboration: for i in 1 to 8 generate
begin
--N 288, M=449 B=8 P=32
regin: flipflop port map (clk=>clk, rst=>rst_in, en=>en_in, d=>ingresso, q=>ingresso_s); 
mux:component mux_sign generic map(N=>C-1) port map(weigh=>pesi(((P-1)-4*(i-1))downto (P-4*i)), 
x3=>ingresso_s(N-1-(4*C)*(i-1) downto (N-C)-(4*C)*(i-1)),             y3=>t(N-1-(4*C)*(i-1) downto (N-C)-(4*C)*(i-1)), 
x2=>ingresso_s(((N-1-C)-(4*C)*(i-1))downto ((N-2*C)-(4*C)*(i-1))),    y2=>t(((N-1-C)-(4*C)*(i-1))downto ((N-2*C)-(4*C)*(i-1))),
x1=>ingresso_s(((N-1-2*C)-(4*C)*(i-1))downto ((N-3*C)-(4*C)*(i-1))),  y1=>t(((N-1-2*C)-(4*C)*(i-1))downto ((N-3*C)-(4*C)*(i-1))), 
x0=>ingresso_s(((N-1-3*C)-(4*C)*(i-1)) downto ((N-4*C)-(4*C)*(i-1))), y0=>t(((N-1-3*C)-(4*C)*(i-1)) downto ((N-4*C)-(4*C)*(i-1)))); 
end generate elaboration;
adder: Adder_tree_last_ly port map ( ingresso=>t, s=>sum); 
sipo_r: SIPO GENERIC MAP(N=>B-1) port map (clk=>clk, en=>en_sipo, rst=>rst_sipo, x=>sum, y1=>perc1,y2=>perc2,y3=>perc3,y4=>perc4,y5=>perc5,y6=>perc6,y7=>perc7,y8=>perc8);
--dal filtro 1 all 8
t_s<= t;
sum_s<=sum;


--process(perc1,perc2,perc3,perc4,perc5,perc6,perc7,perc8) 
--begin 
class_s<= max_tree_reduction(perc1,perc2,perc3,perc4,perc5,perc6,perc7,perc8);
reg_out: class port map(en=>en_out, rst=>rst_out, clk=>clk, class_s=>class_s, classe=>mov, perc1=>perc1,perc2=>perc2,perc3=>perc3,perc4=>perc4,perc5=>perc5,perc6=>perc6,perc7=>perc7,perc8=>perc8);
 
perc1_s<=perc1;perc2_s<=perc2;perc3_s<=perc3;perc4_s<=perc4;
perc5_s<=perc5;perc6_s<=perc6;perc7_s<=perc7;perc8_s<=perc8;
end Behavioral;
