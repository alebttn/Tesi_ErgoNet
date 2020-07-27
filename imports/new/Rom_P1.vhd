----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.06.2020 15:13:58
-- Design Name: 
-- Module Name: Rom_P1 - Behavioral
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

entity Rom_P1 is
Generic(D:integer:=4; --cardinalità dato
        A:integer:=4;
        Elements:integer:=16;
        FileName    : string  := "C:\Users\Alessia\Desktop\Tesi\parametri\Pesi_F1.data"); -- log2(cardinalità num di indirizzi)
     Port  (clk, ReadEnable:in std_logic; 
            Addr: in std_logic_vector(A-1 downto 0);
            DO:out std_logic_vector(D-1 downto 0));
end Rom_P1;

architecture Behavioral of Rom_P1 is

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
