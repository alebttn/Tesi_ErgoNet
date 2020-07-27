----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.06.2020 18:13:06
-- Design Name: 
-- Module Name: Rom_BN3 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;
use IEEE.math_real.all;
use ieee.std_logic_textio.all;

entity Rom_BN3 is
    Generic(D:integer:=10; --cardinalit� dato
        A:integer:=5;
        Elements:integer:=32;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\bn3.data"); -- log2(cardinalit� num di indirizzi)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end Rom_BN3;

architecture Behavioral of Rom_BN3 is

type rom_type is array (0 to Elements -1) of std_logic_vector (D-1 downto 0);
    impure function InitRomFromFile (RomFileName : in string) return rom_type is
        FILE romfile : text is in RomFileName;
        variable RomFileLine : line;
        variable rom : rom_type;
    begin
        for i in rom_type'range loop
            readline(romfile, RomFileLine);
            read(RomFileLine, rom(i));
        end loop;
        
        return rom;
    end function;   
    
    signal rom : rom_type := InitRomFromFile(FileName); 
    
begin

    process(clk,ReadEnable,Addr)
    begin
        if rising_edge(clk) and ReadEnable ='1' then
            
                Do <= rom(conv_integer(Addr));
         end if;
     end process;


end Behavioral;
