----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2020 13:06:04
-- Design Name: 
-- Module Name: Prva_layer - Behavioral
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

entity Ergonomic_FCN is
    Generic (N:integer:=432;
             O1:integer:=720;--out l1
             O2:integer:=560; --out l2
             O3:integer:=33; --out l3
             Og:integer:=288; --out gap
             O4:integer:=14-- out fc
             );
             
    Port ( clk, rst, data_ready,en : in STD_LOGIC;
            a : in STD_LOGIC_VECTOR (9-1 downto 0); --S=432 9*
             --perc1: out STD_LOGIC_VECTOR (9 downto 0);
            classe:out STD_LOGIC_VECTOR (3 downto 0));
end Ergonomic_FCN;
architecture Behavioral of Ergonomic_FCN is
component PIPO_NtoM is
       generic(P: integer:=30;--numero iterazioni -2
               N: integer:=9; --cardinalità
               M:integer:=287);
    Port ( 
          clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : out STD_LOGIC_VECTOR (M downto 0));
end component;
component Layer_1 is
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
            Do_split : out STD_LOGIC_VECTOR (B-1 downto 0);--test
            sum_adder_tree: out STD_LOGIC_VECTOR (N+1 downto 0);--test
            subbn: out STD_LOGIC_VECTOR (N+2 downto 0); --test;
            out_buff: out STD_LOGIC_VECTOR (G-1 downto 0);--test
             cnt: out std_logic_vector(6 downto 0);--test
            out_l1bn:out std_logic --test
            );
end component;
component Layer_2 is
    generic(N:integer:=720; 
            M:integer:=176;--cardinalità uscita
            P:integer:=35; --numero di ripetizioni
            G:integer:=11;--cardinalità uscita primo blocco
            O:integer:= 560; --cardinalità uscita (G+1)
            B:integer:=16); --cardinalità singolo dato
    Port ( clk,rst,en: in STD_LOGIC;
    conf_L2: out std_logic;
    rst_split,rst_pop,en_pop,en_buff,rst_buff, en_out, rst_out:out std_logic; 
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
end component;
component Layer_3 is
    generic(N:integer:=560; --ingresso
            G:integer:=9;--cardinalità uscita primo blocco
            M:integer:=33; --out singolo dato l3 
            S:integer:=48;--3*16
            B:integer:=16; --cardinalità singolo dato
            O:integer:=288);
    Port ( clk,rst,en : in STD_LOGIC;
            conf_L3: out std_logic;
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
end component;
component Fully_Connected_Layer is
    generic(N:integer:= 288; --cardinalità ingresso
            P: integer:= 32; --numero pesi
            C:integer:=9; --cardinalità dati
      --      M:integer:= 449;--10*45-1
            B:integer:=14);  --cardinalità uscita adder tree
    Port ( clk, rst_sipo, en_sipo, en_out,rst_out,en_in, rst_in : in STD_LOGIC;
          -- conf_f:out std_logic;
           ingresso : in STD_LOGIC_VECTOR (N-1 downto 0);
           pesi : in STD_LOGIC_VECTOR (P-1 downto 0);
           mov : out STD_LOGIC_VECTOR (3 downto 0);
            perc1_s,perc2_s,perc3_s,perc4_s,perc5_s,perc6_s,perc7_s,perc8_s : out STD_LOGIC_VECTOR (B-1 downto 0));
end component;

component Control_unit is
    Port ( en1,en2,en3,clk,rst_1, rst_2,rst_3, en_in,rst_in,enfc, rst_fc: in STD_LOGIC; --rstmem
           CONF_L1, CONF_L2, CONF_l3,conf_f, increment_en: in std_logic; --termine elaborazione layer
           --en_L1, rst_L1,en_L2, rst_L2,en_L3, rst_L3, en_F, rst_F:out std_logic; 
           Addr_L2:out STD_LOGIC_VECTOR (4 downto 0);
           Addrbn_L2:out STD_LOGIC_VECTOR (4 downto 0);
           Addr_L1:out STD_LOGIC_VECTOR (4 downto 0);
           Addr_L3:out STD_LOGIC_VECTOR (5 downto 0);
           Adderbn_L3:out STD_LOGIC_VECTOR (5 downto 0);
           Addr_fc:out STD_LOGIC_VECTOR (3 downto 0);
           count:out STD_LOGIC_VECTOR (5 downto 0);
           end_in,end1,end2,end3,endfc: out std_logic;
          -- en_res,rst_res, en_sipo,rst_sipo: out std_logic;
           Layer:out STD_LOGIC_vector(2 downto 0));
end component;

component fms is
    Port ( rst,clk,data_ready : in STD_LOGIC;
    Layer: in std_logic_vector(2 downto 0); 
    flag: in std_logic_vector(4 downto 0); --flag contatori
    en_L1, rst_L1, en_L2, rst_L2, en_L3, rst_L3, en_f, rst_F: out std_logic; --termine elaborazione layer
    rst_cnt: out std_logic_vector(4 downto 0);--reset dei 5 contatori (fc,3,2,1,in)
    en_cnt: out  std_logic_vector(4 downto 0);--en 5 contatori 
    we,re:out  std_logic_vector(3 downto 0);--write enable delle 4 mem (fc,3,2,1)
    en_in, rst_in: out std_logic; --reg pipo ingresso
    increment_en: out std_logic;
    curr,nxstate : out STD_LOGIC);
end component;

component Rom_P1 is
     Generic(D:integer:=4; --cardinalità dato
             A:integer:=4;
             Elements:integer:=16;
             FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\Pesi_F1.data"); -- log2(cardinalità num di indirizzi)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end component;

component Rom_BN1 is
Generic(D:integer:=12; --cardinalità dato
        A:integer:=4;
        Elements:integer:=16;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\bn1.data"); -- log2(cardinalità num di indirizzi)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end component;

component Rom_P2 is
    Generic(D:integer:=176; --cardinalità dato
             A:integer:=4;
             Elements:integer:=16;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\Pesi_L2.data"); -- log2(cardinalità num di indirizzi)
    Port ( clk : in STD_LOGIC;
           ReadEnable : in STD_LOGIC;
           Addr: in STD_LOGIC_VECTOR (A-1 downto 0);
           DO: out STD_LOGIC_VECTOR (D-1 downto 0));
end component;

component Rom_BN2 is
Generic(D:integer:=12; --cardinalità dato
        A:integer:=4;
        Elements:integer:=16;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\bn2.data"); -- log2(cardinalità num di indirizzi)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end component;

component Rom_P3 is
    Generic(D:integer:=16*3; --cardinalità dato
             A:integer:=5;
             Elements:integer:=32;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\Pesi_L3.data"); -- log2(cardinalità num di indirizzi=96=3*32)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end component;

component Rom_BN3 is
    Generic(D:integer:=10; --cardinalità dato
        A:integer:=5;
        Elements:integer:=32;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\bn3.data"); -- log2(cardinalità num di indirizzi)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end component;

component Rom_FC is
Generic(D:integer:=32; --cardinalità dato
        A:integer:=3;
        Elements:integer:=8;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\Pesi_Lfc.data"); -- log2(cardinalità num di indirizzi)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end component;

component cu_fc is
    Port ( clk,rst,en : in STD_LOGIC;
    CONF_fc: OUT STD_LOGIC;  
     en_res,rst_res,en_sipo,rst_sipo: out std_logic;
     aux_in: in std_logic_vector(3 downto 0)); --variabile per contare fino a 7
end component;

signal ly:  std_logic_vector(2 downto 0);
signal fg,fg_buff, cl_count, en_count: std_logic_vector(4 downto 0); 
signal write_enable,read_enable:std_logic_vector(3 downto 0);
signal en_ingresso, reset_ingresso: std_logic;
signal enL1,enL2,enL3,rstL1,rstL2,rstL3,enL4,rstL4:std_logic;
signal en_out,rst_out,en_sipo,rst_sipo:std_logic;


signal endl1,endl2,endl3,endl4:std_logic;
signal endl1_buff,endl2_buff,endl3_buff,endl4_buff:std_logic;

signal Indirizzo_L1:STD_LOGIC_VECTOR (4 downto 0);
signal Indirizzo_L2:STD_LOGIC_VECTOR (4 downto 0);
signal Indirizzo_L2bn: STD_LOGIC_VECTOR (4 downto 0);
signal Indirizzo_L3:STD_LOGIC_VECTOR (5 downto 0);
signal Indirizzo_L3bn:STD_LOGIC_VECTOR (5 downto 0); 
signal Indirizzofc: STD_LOGIC_VECTOR (3 downto 0); 

signal out_L1_s:STD_LOGIC_VECTOR (O1-1 downto 0);
signal out_L2_s:STD_LOGIC_VECTOR (O2-1 downto 0);
signal out_gap_s:STD_LOGIC_VECTOR (Og-1 downto 0);
signal out_L4_s:STD_LOGIC_VECTOR (O4-1 downto 0);
signal p1: STD_LOGIC_VECTOR (3 downto 0);
signal bn1: STD_LOGIC_VECTOR (11 downto 0);
signal p2:STD_LOGIC_VECTOR (175 downto 0); 
signal bn2:STD_LOGIC_VECTOR (11 downto 0);
signal p3: STD_LOGIC_VECTOR (47 downto 0);
signal bn3:STD_LOGIC_VECTOR (9 downto 0);
signal p4: STD_LOGIC_VECTOR (31 downto 0);
signal ok: std_logic;
signal out_NM: STD_LOGIC_VECTOR (N-1 downto 0);
signal perc1_s, perc2_s, perc3_s,perc4_s,perc5_s,perc6_s,perc7_s,perc8_s: STD_LOGIC_VECTOR (O4-1 downto 0);

begin
Finite_state_machine: fms port map ( rst=>rst, clk=>clk, data_ready=>data_ready, Layer=>ly, flag=>fg,en_L1=>enL1, rst_L1=>rstL1, en_L2=>enL2, 
rst_L2=>rstL2, en_L3=>enL3, rst_L3=>rstL3,en_f=>enL4, rst_f=>rstL4,
rst_cnt=>cl_count, en_cnt=>en_count, we=>write_enable,re=>read_enable, en_in=>en_ingresso, rst_in=>reset_ingresso,increment_en=>ok
);

--endl1_buff<= not(not(endl1));endl2_buff<= not(not(endl2));
--endl4_buff<= not(not(endl4));endl3_buff<= not(not(endl3));
counter: Control_unit port map (clk=>clk, en_in=>en_count(0),en1=>en_count(1),en2=>en_count(2),en3=>en_count(3),enfc=>en_count(4),rst_in=>cl_count(0),rst_1=>cl_count(1),rst_2=>cl_count(2),rst_3=>cl_count(3),rst_fc=>cl_count(4),
CONF_L1=>endl1, CONF_L2=>endl2, CONF_l3=>endl3, conf_f=>endl4,increment_en=>ok,
Addr_L1=>Indirizzo_L1, Addr_L2=>Indirizzo_L2,Addrbn_L2=>Indirizzo_L2bn, 
Addr_L3=>Indirizzo_L3,Adderbn_L3=>Indirizzo_L3bn,Addr_fc=>Indirizzofc,
Layer=>ly, end_in=>fg(0),end1=>fg(1),end2=>fg(2),end3=>fg(3),endfc=>fg(4));
reg_in: PIPO_NtoM generic map(P=>46,N=>9,M=>431) port map(clk=>clk, rst=>reset_ingresso, en=>en_ingresso, a=>a, b=>out_NM);
--out_pipo_NM<= out_NM; --432
rombn1: Rom_BN1 port map(clk=>clk,  ReadEnable=>read_enable(0), Addr=>Indirizzo_L1(3 downto 0), do=>bn1);
rom1: Rom_P1 port map (clk=>clk, ReadEnable=>read_enable(0), Addr=>Indirizzo_L1(3 downto 0), do=>P1); 
L1: Layer_1 port map (clk=>clk,CONF_l1=>endl1, en=>enL1, rst=>rstL1, a=>out_NM, do_bn=>bn1, weigh=>P1, out_l1=>out_l1_s  );

rombn2: Rom_BN2 port map(clk=>clk,  ReadEnable=>read_enable(1), Addr=>Indirizzo_L2(3 downto 0), do=>bn2);
rom2: Rom_P2 port map (clk=>clk, ReadEnable=>read_enable(1), Addr=>Indirizzo_L2(3 downto 0),  do=>P2);
L2:Layer_2 port map(clk=>clk, CONF_l2=>endl2,en=>enL2, rst=>rstL2, do_bn=>bn2, d1=>out_l1_s, out_L2=>out_L2_s,
w11=>p2(175 downto 160) , w10=>p2(159 downto 144),w9=>p2(143 downto 128),w8=>p2(127 downto 112),w7=>p2(111 downto 96),w6=>p2(95 downto 80),w5=>p2(79 downto 64),w4=>p2(63 downto 48),w3=>p2(47 downto 32),w2=>p2(31 downto 16),w1=>p2(15 downto 0));

rom3: Rom_P3 port map(clk=>clk,  ReadEnable=>read_enable(2), Addr=>Indirizzo_L3(4 downto 0), do=>p3);
rombn3: Rom_BN3 port map (clk=>clk, ReadEnable=>read_enable(2), Addr=>Indirizzo_L3(4 downto 0), do=>bn3);
L3: Layer_3 port map(clk=>clk,CONF_l3=>endl3, rst=>rstL3, en=>enL3, d1=>out_l2_s, do_bn=>bn3, w3=>p3(47 downto 32) , w2=>p3(31 downto 16), w1=>p3(15 downto 0),
out_gap=>out_gap_s);

RoM4: Rom_FC port map(clk=>clk, ReadEnable=>read_enable(3), Addr=>Indirizzofc(2 downto 0), do=>P4);
cu: cu_fc port map(clk=>clk, en=>enL4, rst=>rstL4,aux_in=>Indirizzofc, conf_fc=>endl4, en_res=>en_out, rst_res=>rst_out, en_sipo=>en_sipo, rst_sipo=>rst_sipo);

fc: Fully_Connected_Layer port map(clk=>clk,ingresso=>out_gap_s, pesi=>P4, en_sipo=>en_sipo, rst_sipo=>rst_sipo, en_out=>en_out,rst_out=>rst_out,en_in=>enL4, rst_in=>rst, 
perc1_s=>perc1_s,perc2_s=>perc2_s,perc3_s=>perc3_s,perc4_s=>perc4_s,perc5_s=>perc5_s,perc6_s=>perc6_s,perc7_s=>perc7_s,perc8_s=>perc8_s,mov =>classe); 
--perc2<= perc2_s;perc3<= perc3_s;perc4<= perc4_s;perc5<= perc5_s;perc6<= perc6_s;perc7<= perc7_s;perc8<= perc8_s;


end Behavioral;
