----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2020 07:25:05
-- Design Name: 
-- Module Name: Reg_split - Behavioral
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

entity Reg_split1 is
    generic(N:integer:=720; 
            M:integer:=176;--cardinalità uscita
            P:integer:=35; --numero di ripetizioni
            B:integer:=16); --cardinalità singolo dato
    Port ( clk, rst, en : in STD_LOGIC;
           D1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Do : out STD_LOGIC_VECTOR (M-1 downto 0));
end Reg_split1;

architecture Behavioral of Reg_split1 is
signal t:STD_LOGIC_VECTOR(M-1 downto 0); 
begin
process(clk, rst, en) 
variable i:integer:=0; 
begin 
if rst='1' then 
t<= (others=>'0'); 
i:=0; 
else 
if en='1' then 
    if (rising_edge(clk)) then 
        if i= P then i:=1; else i:=i+1; end if;

        t<= D1(((N-1)-B*(i-1)) downto (N-M)-B*(i-1));

--end loop; 
        end if; 
    end if; 
end if;
DO<= t;
end process;

end Behavioral;
