----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2020 20:20:21
-- Design Name: 
-- Module Name: Layer_1 - Behavioral
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

entity Layer_1 is
      generic(N:integer:=9; --ingresso
            G:integer:=45;--cardinalità outL1 /ciclo
            M:integer:=4; --numero di pesi primo layer per ciclo
            S:integer:=432;--9*48
            B:integer:=36; --uscita primo blocco
            O:integer:=720);
    Port ( en,rst,clk : in STD_LOGIC;
            conf_L1: out std_logic;
            a : in STD_LOGIC_VECTOR (S-1 downto 0);
            do_bn:  in STD_LOGIC_VECTOR (N+2 downto 0);
            weigh : in STD_LOGIC_VECTOR (M-1 downto 0);
            out_L1: out STD_LOGIC_VECTOR (O-1 downto 0);
            --out_pipo_NM: out std_logic_vector(S-1 downto 0);--test
            Do_split : out STD_LOGIC_VECTOR (B-1 downto 0);--test
            sum_adder_tree: out STD_LOGIC_VECTOR (N+1 downto 0);--test
            subbn: out STD_LOGIC_VECTOR (N+2 downto 0); --test;
            out_buff: out STD_LOGIC_VECTOR (G-1 downto 0);--test
             cnt: out std_logic_vector(6 downto 0);--test
            out_l1bn:out std_logic --test
            );
end Layer_1;

architecture Behavioral of Layer_1 is
signal rst_split,en_split, en_out, rst_out,rst_buff_s, en_buff_s: std_logic; 
--signal out_NM: std_logic_vector(S-1 downto 0);
signal outsplit: STD_LOGIC_VECTOR (B-1 downto 0);
signal y1_s, y2_s, y3_s,y4_s:STD_LOGIC_VECTOR (N-1 downto 0);
signal sum_tree: STD_LOGIC_VECTOR (N+1 downto 0);
signal sub_bn: STD_LOGIC_VECTOR (N+2 downto 0);
signal bn,bn_2: std_logic;
signal out_f:STD_LOGIC_VECTOR (G-1 downto 0);

component Reg_split1 is
    generic(N:integer:=432; 
            M:integer:=36;--cardinalità uscita 9*4
            P:integer:=45; --numero di ripetizioni 
            B:integer:=9); --cardinalità singolo dato
    Port ( clk, rst,en : in STD_LOGIC;
           D1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Do : out STD_LOGIC_VECTOR (M-1 downto 0));
end component;
component PIPO_45 is --M=(P+2)*N
       generic(P: integer:=14; --numero filtri -2
               N: integer:=45; --cardinalità ingressi
               M:integer:=719); --cardinalità uscita-1
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : out STD_LOGIC_VECTOR (M downto 0));
end component;

component mux_sign is
    Generic (N:integer:=8; --cardinalità-1 dell'ingresso
             M:integer:=3); --ingressi di selezione -1 (pesi) 
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

component Adder_Tree is
    Generic(N:integer:= 8);--cardinalità-1 ingressi 
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           x3 : in STD_LOGIC_VECTOR (N downto 0);
           x4 : in STD_LOGIC_VECTOR (N downto 0);
           sum : out STD_LOGIC_VECTOR (N+2 downto 0));--11 bit
end component;

component carry_Ripple is
    generic(N:integer);
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           cin : in STD_LOGIC; 
           sum : out STD_LOGIC_VECTOR (N+1 downto 0);
           cout : out STD_LOGIC);
end component;
component buff is
       generic(P: integer:=44;--numero iterazioni -1
               M:integer:=44); 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC;
           b : out STD_LOGIC_VECTOR (M downto 0));
end component;
component cu_L1 is
    Port ( clk,rst,en : in STD_LOGIC;
    conf_L1: out std_logic;
    rst_split,en_split, en_out, rst_out,rst_buff, en_buff:out std_logic;
     cnt: out std_logic_vector(6 downto 0));
end component;

--component condition_1 is
--    Port ( aux_in : in STD_LOGIC_VECTOR (6 downto 0);
--           rst_split,en_out,rst_out,rst_buff,en_buff : out STD_LOGIC);
--end component;
signal cnt_s:STD_LOGIC_VECTOR (6 downto 0);
begin
cul1: cu_l1 port map (clk=>clk, en=>en, rst=>rst,conf_L1=>conf_L1,cnt=>cnt,en_split=>en_split,rst_split=>rst_split, en_out=>en_out, rst_out=>rst_out,rst_buff=>rst_buff_s,en_buff=>en_buff_s); 
--con: condition_1 port map(aux_in=>cnt_s,rst_split=>rst_split, en_out=>en_out, rst_out=>rst_out,rst_buff=>rst_buff_s,en_buff=>en_buff_s);

split: Reg_split1 port map (clk=>clk, rst=>rst_split,en=>en_split, d1=>a, do=>outsplit); 
do_split<=outsplit; 
mult_wei: mux_sign port map (weigh=>weigh, x3=>outsplit(B-1 downto B-N), x2=>outsplit(B-1-N downto B-2*N),x1=>outsplit(B-1-2*N downto B-3*N),x0=>outsplit(B-1-3*N downto B-4*N),
y3=>y4_s, y2=>y3_s, y1=>y2_s, y0=>y1_s); 
addertree: Adder_Tree port map (x4=>y4_s,x3=>y3_s,x2=>y2_s,x1=>y1_s, sum=>sum_tree);
sum_adder_tree<= sum_tree; 
subatch: carry_Ripple generic map(N=>10) port map (x1=>sum_tree, x2=>do_bn(N+1 downto 0), cin=>'1', sum=>sub_bn); 
subbn<=sub_bn; 
bn<= sub_bn(N+2) xor do_bn(N+2); 
out_l1bn<= rst_split; 
--bn_2<= not(not(bn));
bufferl3: buff port map(clk=>clk, rst=>rst_buff_s, en=>en_buff_s, a=>bn, b=> out_f);
out_buff<= out_f;
reg_out:PIPO_45 port map (clk=>clk, rst=>'0', en=>en_out, a=>out_f, b=>out_L1); 
end Behavioral;
