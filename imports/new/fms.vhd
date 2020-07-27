----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2020 09:19:35
-- Design Name: 
-- Module Name: fms - Behavioral
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

entity fms is
    Port ( rst,clk,data_ready : in STD_LOGIC;
    Layer: in std_logic_vector(2 downto 0); 
    flag: in std_logic_vector(4 downto 0); --flag contatori
    en_L1, rst_L1, en_L2, rst_L2, en_L3, rst_L3, en_f, rst_F: out std_logic; --termine elaborazione layer
    rst_cnt: out std_logic_vector(4 downto 0);--reset dei 5 contatori (fc,3,2,1,in)
    en_cnt: out  std_logic_vector(4 downto 0);--en 5 contatori 
    we,re:out  std_logic_vector(3 downto 0);--write enable delle 4 mem (fc,3,2,1)
    en_in, rst_in: out std_logic; --reg pipo ingresso
    increment_en: out std_logic; --enable all'incremento dei contatori quando lo stato è store 
    curr,nxstate : out STD_LOGIC);
end fms;

architecture Behavioral of fms is
type stato is (Reset,store,L1,L2,L3,FC,NEW_IN); --store
signal cs, ns: stato; 
begin
seq: process(clk, rst) 
begin
if rst='1' then 
cs<= Reset; 
else 
if rising_edge(clk) then 
cs<= ns; 
end if; 
end if;
end process; 

comb: process(cs, flag, Layer) 
begin
case cs is 
when Reset => 
curr<='1'; nxstate<='1'; 
rst_cnt<= "11111";
en_cnt<= "00000"; 
we<="0000";re<="0000";
increment_en<='0';
    en_in<= '0'; rst_in<='1';
    en_L1<='0'; rst_L1<='1';
    en_L2<='0'; rst_L2<='1';
    en_L3<='0'; rst_L3<='1'; 
    en_F<='0'; rst_F<='1';
--prevedere un altro segnale per indicare se cambiare i pesi o meno (Store o newin) 
if( data_ready = '1' and Layer = "000") then ns<= STORE; --carico i pesi e le bn in memoria 
--elsif (data_ready = '0' and Layer = "000") then ns<= NEW_IN; 
else ns<= reset; 
end if; 


when STORE => 
 
curr<='0'; nxstate<='0';
rst_cnt<= "00000";
en_cnt<= "11111"; 
increment_en<='1'; 
we<="1111";re<="0000";
    en_in<= '1'; rst_in<='0'; 
    en_L1<='0'; rst_L1<='1';
    en_L2<='0'; rst_L2<='1';
    en_L3<='0'; rst_L3<='1'; 
    en_F<='0'; rst_F<='1';
    --se utilizzassimo ram invece di rom per non sovrascrivere
if flag(1)='1' then we(0)<='0'; end if; 
if flag(2)='1' then we(1)<='0'; end if; 
if flag(3)='1' then we(2)<='0'; end if; 
if flag(4)='1' then we(3)<='0';end if; 
if flag(0)='1' then rst_cnt<="00010"; --areset cnt 1 ma transizione we1=1 perchè flag1=0
 end if; 
if(data_ready = '0' and Layer = "001") then ns<= L1; --diventa 1 dopo il 48 esimo clock del caricamento dell igresso
--else ns<= reset;
else ns<= STORE; 
end if;

--il layer L1 abilita il contatore "ram1" che conta fino a 16. L'incremento di i avviene quando termina l'elaborazione del filtro i-esimo, i cui parametri sono all'indirizzo i-esimo della ram
--abilita anche il parallel input paralle output che accumula i 45x16bit risultati e li riordina in 16 dati da 45 bit per il layer successiovo 
when L1 => 
curr<='1'; nxstate<='0';
increment_en<='0'; 
    rst_cnt<= "11101"; --abbasso le flag
    en_cnt<= "00010"; 
    we<="0000";re<="0001";
    en_L1<='1'; rst_L1<='0';
    en_L2<='0'; rst_L2<='1';
    en_L3<='0'; rst_L3<='1'; 
    en_F<='0'; rst_F<='1';
    en_in<= '0'; rst_in<='0'; 
if(data_ready = '0' and Layer = "010") then ns<= L2; en_cnt<= "00100";  
else ns<= L1; end if;

--L2 abbassa flag 1 riportando a zero il contatore 1, abilita il contatore "ram due" che conta fino a 176, a ogni ciclo di clock restituisce 11 indirizzi (corrispondenti agli 11 pesi della memoria) quindi dopo 16 (176/11) cicli termina l'elaborazione 
--abilita anche il popcount di meanL2 e la sua uscita pipo_35 che accumula 35x16bit e li riordina in 16 dati da 35 bit ciascuno per il layer 3
when L2=> 
curr<='0'; nxstate<='1';
increment_en<='0'; 
    rst_cnt<= "11011";
    en_cnt<= "00100"; 
    we<="0000";re<="0010";
    en_in<= '0'; rst_in<='0'; 
     en_L1<='0'; rst_L1<='1';
    en_L2<='1'; rst_L2<='0';
    en_L3<='0'; rst_L3<='1'; 
    en_F<='0'; rst_F<='1';
    
if(data_ready = '0' and Layer = "011") then ns<= L3; 
else ns<= L2; end if;

--L3 conta fino a 96 e a ogni ciclo restituisce 3 indirizzi corrispondenti ai 3 pesi di ciascun filtro, quindi dopo 32 (96/3) cicli di clock termina l'elaborazione
--ripulisce il cntatore 2 e il registo pipo_45 di L1 , abilita il suo popcount e la sua uscita che è un ff tra L3 e GAP
--
when L3=> 
curr<='1'; nxstate<='0';
increment_en<='0'; 
    rst_cnt<= "10111";
    en_cnt<= "01000"; 
    we<="0000";re<="0100";
    en_in<= '0'; rst_in<='0'; 
    en_L1<='0'; rst_L1<='1';
    en_L2<='0'; rst_L2<='1';
    en_L3<='1'; rst_L3<='0'; 
    en_F<='0'; rst_F<='1';


if(data_ready = '0' and Layer = "100") then ns<= FC; 
else ns<= L3; end if;


when FC=> 
curr<='0'; nxstate<='1';
increment_en<='0';
    rst_cnt<= "00111";
    en_cnt<= "10000"; --abilito contatore fc
    we<="0000";re<="1000";
    en_in<= '0'; rst_in<='0';
    en_L1<='0'; rst_L1<='1';
    en_L2<='0'; rst_L2<='1';
    en_L3<='0'; rst_L3<='0'; 
    en_F<='1'; rst_F<='0';

--if flag(4)='1' then en_pipo<="0000";end if;  --mantieni l'uscita corretta
if (data_ready = '0' and Layer="101") then ns<= NEW_IN; 
else ns<= FC; end if;


when NEW_IN=> 
curr<='1'; nxstate<='0';
increment_en<='1'; 
we<="0000";rst_cnt<= "11111";en_cnt<= "00000";re<="0000";
    en_in<= '0'; rst_in<='1';
    en_L1<='0'; rst_L1<='1';
    en_L2<='0'; rst_L2<='1';
    en_L3<='0'; rst_L3<='1'; 
    en_F<='0'; rst_F<='0';
    ns<=NEW_IN;
if data_ready='1' then 
        
        en_cnt<= "00001"; --abilito count in 
        rst_cnt<= "00000";
        en_in<= '1'; rst_in<='0';
    if( Layer = "001") then 
        ns<= L1; 
    else 
        ns<=NEW_IN;
    end if; 
 end if; 
end case; end process; 
end Behavioral;
