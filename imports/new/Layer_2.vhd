----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2020 07:58:48
-- Design Name: 
-- Module Name: Layer_2 - Behavioral
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

entity Layer_2 is
    generic(N:integer:=720; 
            M:integer:=176;--cardinalità uscita
            P:integer:=35; --numero di ripetizioni
            G:integer:=11;--cardinalità uscita primo blocco
            O:integer:= 560; --cardinalità uscita (G+1)
            B:integer:=16); --cardinalità singolo dato
    Port ( clk,rst,en: in STD_LOGIC;
    rst_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic; 
    conf_L2: out std_logic;
    do_bn : in STD_LOGIC_VECTOR (G downto 0); --cardinalità G-1 +bit segno 
    w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11 : in STD_LOGIC_VECTOR (B-1 downto 0);
    D1 : in STD_LOGIC_VECTOR (N-1 downto 0);
    out_L2: out STD_LOGIC_VECTOR (O-1 downto 0);
    count: out std_logic_vector(6 downto 0); --test
    out_f: out STD_LOGIC_VECTOR (P-1 downto 0);--test
    out_l2bn: out STD_LOGIC; --bit segno scita
    sub_bn: out STD_LOGIC_VECTOR (G downto 0);--test
    Do : out STD_LOGIC_VECTOR (M-1 downto 0);-- test
    mean : out STD_LOGIC_VECTOR (G-1 downto 0) --test
    );
end Layer_2;

architecture Behavioral of Layer_2 is
signal out_176: STD_LOGIC_VECTOR (M-1 downto 0);
signal out_mean: STD_LOGIC_VECTOR (G-1 downto 0);
signal bn: std_logic; --uscita binarizzata 
signal sum_s: STD_LOGIC_VECTOR (G downto 0); --uscita sottrattore con media mobile
signal out_filtro: STD_LOGIC_VECTOR (P-1 downto 0); --uscita del filtro N a 35 bit

component Reg_split1 is
    generic(N:integer:=720; 
            M:integer:=176;--cardinalità uscita
            P:integer:=35; --numero di ripetizioni
            B:integer:=16); --cardinalità singolo dato
    Port ( clk, rst,en : in STD_LOGIC;
           D1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Do : out STD_LOGIC_VECTOR (M-1 downto 0));
end component;
component mean_L2 is
    Generic(D:integer:=176; --11*16
            F:integer:=15;
            G:integer:=10);--cardinlità uscita
    Port ( rst_pop,en_pop,clk: in STD_LOGIC;
           b_in1, b_in2,b_in3,b_in4,b_in5, b_in6, b_in7, b_in8, b_in9, b_in10, b_in11: in STD_LOGIC_VECTOR (F downto 0);
           w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11 : in STD_LOGIC_VECTOR (F downto 0);
           mean : out STD_LOGIC_VECTOR (G downto 0));
end component;
component carry_Ripple is
    generic(N:integer); --10
    Port ( x1 : in STD_LOGIC_VECTOR (N downto 0);
           x2 : in STD_LOGIC_VECTOR (N downto 0);
           cin : in STD_LOGIC; 
           sum : out STD_LOGIC_VECTOR (N+1 downto 0);
           cout : out STD_LOGIC);
end component;
component buff is
       generic(P: integer:=34;--numero iterazioni -1
               M:integer:=34); --8 to 383, P è quante volte ciclare-2 (ad es nel primo layer 48-2=46 volte)
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC;
           b : out STD_LOGIC_VECTOR (M downto 0));
end component;
component PIPO_35 is
       generic(P: integer:=14;--numero iterazioni -2
               N: integer:=35; --cardinalità
               M:integer:=559); 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : out STD_LOGIC_VECTOR (M downto 0));
end component;
component cu_L2 is
    Port ( en,clk,rst : in STD_LOGIC;
    conf_L2: out std_logic;
    -- rst_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
     cnt: out std_logic_vector(6 downto 0)); --variabile per contare fino a 36
end component;
component condition_2 is
    Port ( clk, en ,rst : in STD_LOGIC;
            rst_split,en_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic;
            aux_in: in std_logic_vector(6 downto 0));
end component;
signal rstsplit_s,en_split_s,rstpop_s,enpop_s,enbuff_s,rstbuff_s, enout_s, rstout_s:std_logic;
signal count_s: std_logic_vector(6 downto 0);
begin
control_unit_L2: cu_L2 port map(clk=>clk, rst=>rst,en=>en, conf_L2=>conf_L2, 
--rst_split=>rstsplit_s,rst_pop=>rstpop_s,en_pop=>enpop_s,en_buff=>enbuff_s,rst_buff=>rstbuff_s, en_out=>enout_s, rst_out=>rstout_s,
 cnt=>count_s);
 count<= count_s; 
 cond: condition_2 port map(clk=>clk, rst=>rst,en=>en, rst_split=>rstsplit_s,en_split=>en_split_s,rst_pop=>rstpop_s,en_pop=>enpop_s,en_buff=>enbuff_s,rst_buff=>rstbuff_s, en_out=>enout_s, rst_out=>rstout_s, 
 aux_in=>count_s);
reg_in_l2: Reg_split1 port map(clk=>clk,en=>en_split_s, rst=>rstsplit_s, D1=>D1, Do=>out_176); 
do<= out_176; 
meanL2: mean_l2 port map (rst_pop=>rstpop_s, en_pop=>enpop_s,clk=>clk, w1=>w1,w2=>w2,w3=>w3,w4=>w4,w5=>w5,w6=>w6,w7=>w7,w8=>w8,w9=>w9,w10=>w10,w11=>w11,
b_in11=> out_176(M-1 downto M-B),b_in10=> out_176(M-1-B downto M-2*B), b_in9=> out_176(M-1-2*B downto M-3*B),
b_in8=> out_176(M-1-3*B downto M-4*B),b_in7=> out_176(M-1-4*B downto M-5*B),b_in6=> out_176(M-1-5*B downto M-6*B),
b_in5=> out_176(M-1-6*B downto M-7*B),b_in4=>out_176(M-1-7*B downto M-8*B),b_in3=> out_176(M-1-8*B downto M-9*B),
b_in2=> out_176(M-1-9*B downto M-10*B),b_in1=> out_176(M-1-10*B downto M-11*B), 
mean=>out_mean);
mean<= out_mean; 
subBN: component carry_Ripple generic map(N=>(G-1)) port map(x1=>out_mean, x2=> do_bn(10 downto 0), cin=> '1', sum=>sum_s);
sub_bn<= sum_s;  
bn<= sum_s(G) xor do_bn(G); 
out_l2bn<= enpop_s; 
buffer_uscita_filtro: buff port map (clk=>clk, en=>enbuff_s, rst=>rstbuff_s, a=>bn, b=>out_filtro);
out_f<=out_filtro; 
buffer_out_l2: PIPO_35 port map(clk=>clk, rst=>rstout_s, en=>enout_s, a=>out_filtro, b=>out_L2); 

rst_split<=rstsplit_s; rst_pop<=rstpop_s;en_pop<=enpop_s;en_buff<=enbuff_s;rst_buff<=rstbuff_s; en_out<=enout_s; rst_out<=rstout_s;

end Behavioral;
