----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2020 07:23:08
-- Design Name: 
-- Module Name: Control_unit - Behavioral
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

entity Control_unit is
    Port ( en1,en2,en3,clk,rst_1, rst_2,rst_3, en_in,rst_in,enfc, rst_fc: in STD_LOGIC; --rstmem
           CONF_L1, CONF_L2, CONF_l3,conf_f,increment_en: in std_logic; --termine elaborazione layer
           Addr_L2:out STD_LOGIC_VECTOR (4 downto 0);
           Addrbn_L2:out STD_LOGIC_VECTOR (4 downto 0);
           Addr_L1:out STD_LOGIC_VECTOR (4 downto 0);
           Addr_L3:out STD_LOGIC_VECTOR (5 downto 0);
           Adderbn_L3:out STD_LOGIC_VECTOR (5 downto 0);
           Addr_fc:out STD_LOGIC_VECTOR (3 downto 0);
           count:out STD_LOGIC_VECTOR (5 downto 0);
           end_in,end1,end2,end3,endfc: out std_logic;
         --  en_res,rst_res, en_sipo,rst_sipo: out std_logic;
           Layer:out STD_LOGIC_vector(2 downto 0));
end Control_unit;

architecture Behavioral of Control_unit is

signal flagin, flag1,flag2,flag3,flagfc: std_logic:='0';
signal layer_s:  STD_LOGIC_vector(2 downto 0);
begin
ram1:process(clk,CONF_L1,en1,rst_1)
variable aux_L1: unsigned (4 downto 0); --per contare fino a 15
begin
if(rst_1='1' ) then
   aux_L1:= "00000";
   flag1<= '0';
else if(en1='1') then 
if (rising_edge(clk)) then

if aux_L1 ="01111" then 
flag1<= '1'; 
elsif aux_L1 ="10000" then 
aux_L1 := "00000"; flag1<= '0'; 
else
    if(conf_L1='1' or increment_en='1') then
aux_L1 := aux_L1 + "00001";
    else aux_L1 := aux_L1;
    end if;
end if; 
Addr_L1<=std_logic_vector(aux_L1);
end if; --reset
end if; 
end if; 
end process;

ram2: process(clk,CONF_L2,en2,rst_2)
variable aux_L2: unsigned (4 downto 0); --per contare fino a 15

begin
    if(rst_2='1') then
   aux_L2:= "00000";
   flag2<= '0';
else if (en2='1') then 
if(rising_edge(clk)) then

    if aux_L2="01111" then  
    flag2<= '1';
    elsif aux_L2="10000" then 
    aux_L2:="00000";
    else
    if(conf_L2='1' or increment_en='1') then aux_L2:= aux_L2 + "00001";  end if;
    end if; 
Addr_L2<=std_logic_vector(aux_L2); --0
Addrbn_L2<=std_logic_vector(aux_L2);
end if;
end if;
end if; 
end process;

ram3: process(clk,CONF_L3,en3,rst_3)
variable aux_L3: unsigned (5 downto 0); --per contare fino a 31
begin
if( rst_3='1') then
   aux_L3:="000000";
   flag3<= '0';
else if (en3='1') then
if rising_edge(clk) then 
         
if aux_L3="011111" then flag3<= '1';
elsif aux_L3="100000" then 
aux_L3:="000000";  
 else if(conf_L3='1' or increment_en='1') then
 aux_L3:= aux_L3 + "000001";  end if;
end if; 
Addr_L3<=std_logic_vector(aux_L3); --0,3, ...93
--Addr2_L3<=std_logic_vector(aux_L3+"0000001");
--Addr3_L3<=std_logic_vector(aux_L3+"0000010");
Adderbn_L3<=std_logic_vector(aux_L3);

end if;
end if; --we
end if; 
end process; 

ingresso: process(clk,en_in, rst_in)
variable aux_in: unsigned (5 downto 0):="000000"; --per contare fino a 48  110000
begin
if( rst_in='1') then
   aux_in:= "111111";
   flagin<= '0';
else if (en_in='1') then 
if rising_edge(clk) then 

    if aux_in= "0101101" then --45 
    flagin<= '1'; 

    aux_in := "000000"; 
    else 
    aux_in := aux_in + "000001"; 
    end if; 
count<=std_logic_vector(aux_in);
end if;
end if; --we
end if; 
end process; 

ramfc:process(clk, enfc, rst_fc)
variable aux_fc: unsigned (3 downto 0); --per contare fino a 7
begin
if(rst_fc='1' ) then
   aux_fc:= "1111";
   flagfc<= '0';
else 
    if(enfc='1') then
        if (rising_edge(clk)) then
        
            if aux_fc ="1010" then --10
            flagfc<= '1'; 
            elsif aux_fc ="1011" then
                aux_fc := "0000";
            else
                aux_fc := aux_fc + "0001";
            end if; 
                Addr_fc<=std_logic_vector(aux_fc);
            end if; 

    end if;--en
end if;--rst
end process;
Stato: process (flag1,flag2,flag3,flagfc,flagin,clk) 
begin
if (rising_edge(clk)) then 
if flagin='1' and flag1='0' and flag2='1' and flag3='1' and flagfc='1' then 
    Layer<= "001";
    
elsif flagin='0' and flag2='0' and flag3='0' and flag1='1'and flagfc='0' and conf_L1='1' then 
    Layer<= "010"; 
   
elsif flagin='0' and flag1='0' and flag2='1' and conf_L2='1' and flag3='0' and flagfc='0' then 
    Layer<= "011"; 
    
elsif flagin='0' and flag1='0' and flag2='0' and flag3='1' and conf_L3='1' and flagfc='0' then 
    Layer<= "100"; 
     
elsif flagin='0' and flag1='0' and flag2='0' and flag3='1' and flagfc='1' and conf_f='1'   then 
    Layer<= "101"; 
elsif flagin='1' and flag1='0' and flag2='0' and flag3='0' and flagfc='0' then 
    Layer<= "001"; 
else  Layer<= "000"; 

end if; 
end if; 
end process;

end_in<= flagin; 
end1<=flag1; end2<=flag2; end3<=flag3; endfc<= flagfc;
end Behavioral;

