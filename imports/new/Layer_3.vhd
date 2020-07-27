----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2020 15:41:41
-- Design Name: 
-- Module Name: Layer_3 - Behavioral
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

entity Layer_3 is
    generic(N:integer:=560; --ingresso
            G:integer:=9;--cardinalità uscita primo blocco
            M:integer:=33; --out singolo dato l3 
            S:integer:=48;--3*16
            B:integer:=16; --cardinalità singolo dato
            O:integer:=288);
    Port ( clk,rst,en : in STD_LOGIC;
            rst_o, en_o:out std_logic;
            CONF_l3: OUT STD_LOGIC; 
            D1 : in STD_LOGIC_VECTOR (N-1 downto 0);
            w1,w2,w3 : in STD_LOGIC_VECTOR (B-1 downto 0);
            do_bn : in STD_LOGIC_VECTOR (G downto 0); --G-1 più segno della batch norm 
            out_l3bn: out std_logic; --test
            cnt: out std_logic_vector(6 downto 0);
            out_L3: out STD_LOGIC_VECTOR (M-1 downto 0);
            out_GAP: out STD_LOGIC_VECTOR (O-1 downto 0);
            out_buff: out STD_LOGIC_VECTOR (M-1 downto 0);--test
            subbn: out STD_LOGIC_VECTOR (G downto 0); --test
            mean : out STD_LOGIC_VECTOR (G-1 downto 0);--test
            sum_gap: out STD_LOGIC_VECTOR (8 downto 0);
           Do : out STD_LOGIC_VECTOR (S-1 downto 0)--test
            );
end Layer_3;

architecture Behavioral of Layer_3 is
signal rst_split,en_split,rstpop_s, enpop_s,rst_buff_s,en_buff_s,bn,rstout_s, enout_s,enpopgap, rstpopgap,enoutgap,rstoutgap:STD_LOGIC;
signal out_48: STD_LOGIC_VECTOR (S-1 downto 0);
signal out_mean: STD_LOGIC_VECTOR (G-1 downto 0);
signal sub_bn: STD_LOGIC_VECTOR (G downto 0);
signal out_f,outl3: STD_LOGIC_VECTOR (M-1 downto 0);
signal sumgap:STD_LOGIC_VECTOR (8 downto 0);
component condition_3 is
    Port ( clk,rst,en: in std_logic; 
    CONF_3: OUT STD_LOGIC;
    cnt_s : in STD_LOGIC_VECTOR (6 downto 0);
rst_split,en_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
     rst_pop_gap,en_pop_gap, en_out_gap, rst_out_gap:out std_logic);
 end component;
component Reg_split1 is
    generic(N:integer:=560; 
            M:integer:=48;--cardinalità uscita
            P:integer:=33; --numero di ripetizioni
            B:integer:=16); --cardinalità singolo dato
    Port ( clk, rst,en : in STD_LOGIC;
           D1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Do : out STD_LOGIC_VECTOR (M-1 downto 0));
end component;
component mean_L3 is
    Generic(D:integer:=48; --16*3
            F:integer:=15;
            B:integer:=7); 
    Port ( rst_pop,en_pop,clk:in std_logic;
           b_in1,b_in2,b_in3 : in STD_LOGIC_VECTOR (F downto 0);
           w1,w2,w3 : in STD_LOGIC_VECTOR (F downto 0);
           mean : out STD_LOGIC_VECTOR (B+1 downto 0));
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
       generic(P: integer:=32;--numero iterazioni -1
               M:integer:=32); 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC;
           b : out STD_LOGIC_VECTOR (M downto 0));
end component;
component flipflop is
    Generic(N:integer:=33);
    Port ( clk, rst,en : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (N-1 downto 0);
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;
component GAP is
    Generic(N:integer:=33;
            O:integer:=288); --cardinalità ingresso
    Port (clk,en_pop, rst_pop, en_out, rst_out: in std_logic;
           gap_in : in STD_LOGIC_VECTOR (N-1 downto 0);
           sum_vedo: out std_logic_vector(8 downto 0); 
           uscita: out STD_LOGIC_VECTOR (O-1 downto 0));
end component;
component cu_L3 is
    Port ( clk,rst,en : in STD_LOGIC;
   -- CONF_l3: OUT STD_LOGIC; 
     --rst_split,en_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
     --rst_pop_gap,en_pop_gap, en_out_gap, rst_out_gap:out std_logic;
     cnt: out std_logic_vector(6 downto 0)); --variabile per contare fino a 33
end component;
signal cnt_s: std_logic_vector(6 downto 0);
begin
cntlogic: cu_L3 port map( clk=>clk, rst=>rst, en=>en,
--en_split=>en_split,rst_split=>rst_split,rst_pop=>rstpop_s,en_pop=>enpop_s,en_buff=>en_buff_s,
--rst_buff=>rst_buff_s, en_out=>enout_s, rst_out=>rstout_s, 
--rst_pop_gap=>rstpopgap,en_pop_gap=>enpopgap, en_out_gap=>enoutgap, rst_out_gap=>rstoutgap
cnt=>cnt_s);
cnt<= cnt_s;
con: condition_3 port map( cnt_s=>cnt_s,clk=>clk, rst=>rst, en=>en,conf_3=>conf_L3,
en_split=>en_split,rst_split=>rst_split,rst_pop=>rstpop_s,en_pop=>enpop_s,en_buff=>en_buff_s,
rst_buff=>rst_buff_s, en_out=>enout_s, rst_out=>rstout_s, 
rst_pop_gap=>rstpopgap,en_pop_gap=>enpopgap, en_out_gap=>enoutgap, rst_out_gap=>rstoutgap);
reg_in_l3: Reg_split1 port map( clk=>clk, rst=>rst_split,en=>en_split, D1=>D1, Do=>out_48); 
do<= out_48; 
meanL3: mean_L3 port map ( clk=>clk, en_pop=>enpop_s, rst_pop=>rstpop_s,w1=>w1,w2=>w2,w3=>w3,mean=>out_mean, 
b_in3=>out_48(S-1 downto (S-B)) ,b_in2=>out_48(S-1-B downto S-2*B),b_in1=>out_48(S-1-2*B downto S-3*B));
mean<=out_mean; 
sub_bn3: carry_Ripple generic map(N=>G-1) port map (x1=>out_mean, x2=>do_bn(8 downto 0), cin=>'1', sum=>sub_bn);
subbn<= sub_bn;  
bn<= sub_bn(G) xor do_bn(G); 
out_l3bn<= enpop_s; 
bufferl3: buff port map(clk=>clk, rst=>rst_buff_s, en=>en_buff_s, a=>bn, b=> out_f);
out_buff<= out_f;
reg_out:flipflop port map(clk=>clk, rst=>rstout_s, en=>enout_s, d=> out_f, q=>outL3); 
out_L3<= outl3;
global_average_pool: gap port map( clk=>clk, en_pop=>enpopgap,rst_pop=>rstpopgap, en_out=>enoutgap, rst_out=>rstoutgap,
gap_in=> outl3, sum_vedo=>sumgap, uscita=>out_GAP);
rst_o<=rstoutgap ; en_o<=enoutgap;
sum_gap<=sumgap;
end Behavioral;
