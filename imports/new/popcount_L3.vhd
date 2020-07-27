----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2020 18:15:24
-- Design Name: 
-- Module Name: popcount_L3 - Behavioral
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

entity popcount_L3 is
 Generic(D:integer:=48;--depth 176
         B:integer:=6); --numero bit 9
    Port ( rst,en,clk: in STD_LOGIC;
           b_in : in STD_LOGIC_VECTOR ((D-1) downto 0);
           b_out : out STD_LOGIC_VECTOR ((B-1) downto 0));
end popcount_L3;

architecture Behavioral of popcount_L3 is
begin

process(rst, en,clk)
variable count : unsigned(B-1 downto 0):= (others=>'0');
variable cnt: unsigned(B-2 downto 0):= (others=>'0');
begin
if rst='1' then 
 count := (others=>'0');   --initialize count variable.
 cnt := (others=>'0');
 b_out<= std_logic_vector(count);--(others=>'0');
 else if en='1' then
 if(rising_edge(clk)) then 
  for i in 0 to (D-1) loop   --for all the bits.
        count := count + (cnt & b_in(i));   --Add the bit to the count. 
    end loop;

 -- b_out <= std_logic_vector(count);    --assign the count to output.
end if;
end if;
end if;
b_out <= std_logic_vector(count);
    count := (others=>'0');
    cnt := (others=>'0');
end process;
end Behavioral;
