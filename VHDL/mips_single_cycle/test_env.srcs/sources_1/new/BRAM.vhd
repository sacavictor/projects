----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2024 05:52:12 PM
-- Design Name: 
-- Module Name: BRAM - arh_BRAM
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
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BRAM is
  Port (
        clk : in std_logic;
        we : in std_logic;  
        addr : in std_logic_vector(5 downto 0);  
        di : in std_logic_vector(31 downto 0);  
        do : out std_logic_vector(31 downto 0)
  );
end BRAM;

architecture arh_BRAM of BRAM is
type ram_type is array (0 to 63) of std_logic_vector(31 downto 0);
signal ram : ram_type := (
    x"00000001",
    x"00000002",
    x"00000003",
    x"00000004",
    x"00000005",
    x"00000006",
    x"00000007",
    x"00000008",
    x"00000009",
    x"0000000A",
    x"0000000B",
    x"0000000C",
    x"0000000D",
    x"0000000E",
    x"0000000F",
    x"00000010",
     others => X"00000000"); 
begin

    process(clk)
    begin  
        if rising_edge(clk) then    
                if we = '1' then      
                    ram(conv_integer(addr)) <= di;      
                    do <= di;     
                else      
                    do <= ram(conv_integer(addr));     
                end if;    
        end if;  
     end process; 

end arh_BRAM;
