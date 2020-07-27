----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2020 20:05:27
-- Design Name: 
-- Module Name: GAP - Behavioral
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

entity GAP is
    Generic(N:integer:=33;
            O:integer:=288); --cardinalità ingresso
    Port (clk,en_pop, rst_pop, en_out, rst_out: in std_logic;
           gap_in : in STD_LOGIC_VECTOR (N-1 downto 0);
           sum_vedo: out std_logic_vector(8 downto 0); 
           uscita: out STD_LOGIC_VECTOR (O-1 downto 0));
end GAP;

architecture Behavioral of GAP is
signal media:STD_LOGIC_VECTOR (6 downto 0);--al massimo può contare fino a 33 elementi 
signal media_2,vl:STD_LOGIC_VECTOR (7 downto 0);--media shiftata 
signal sum_s:STD_LOGIC_VECTOR (8 downto 0);
component popcount_L3 is
 Generic(D:integer;
         B:integer); 
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
component PIPO_NtoM is --con M=(P+2)*N
    generic(P: integer;--numero iterazioni -2
               N: integer; --cardinalità
               M:integer); --8 to 383, P è quante volte ciclare-2 (ad es nel primo layer 48-2=46 volte)
    Port ( 
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : out STD_LOGIC_VECTOR (M downto 0));
end component;

begin
vl<= "00100001";--33
conta: popcount_L3 generic map(D=>33, B=>7) port map(clk=>clk, rst=>rst_pop, en=>en_pop, b_in=>gap_in, b_out=>media);
mol_due:shift_sx generic map(B=>7) port map(b_in=>media, b_sh=>media_2);
sub:carry_Ripple generic map(N=>7) port map(x1=>media_2, x2=>vl, cin=>'1', sum=>sum_s);
sum_vedo<= sum_s;  
--somma su 7 bit= 32*8=256
reg_out_gap:PIPO_NtoM generic map(N=>9,P=>30, M=>287) port map (clk=>clk, rst=>rst_out, en=>en_out, a=>sum_s, b=>uscita);

end Behavioral;
