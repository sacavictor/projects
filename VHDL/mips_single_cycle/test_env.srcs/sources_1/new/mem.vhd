
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity mem is
    Port (
        clk : in std_logic;
        memWrite, en : in std_logic;
        aluResIn : in std_logic_vector(31 downto 0);
        RD2 : in std_logic_vector(31 downto 0);
        memData : out std_logic_vector(31 downto 0);
        aluResOut : out std_logic_vector(31 downto 0)
    );
end mem;

architecture Behavioral of mem is
type ramT is array(0 to 63) of std_logic_vector(31 downto 0);
signal ramArray : ramT := (x"00000000", x"00000001", x"0000002", x"0000001", x"00000000", others => x"11111111");
begin

process(clk)
    begin
    
    if rising_edge(clk) then 
        if memWrite = '1' and en = '1' then
            ramArray(conv_integer(AluResIn(7 downto 2))) <= RD2;
        end if;
    end if;
end process;
aluResOut <= aluResIn;
memData <= ramArray(conv_integer(aluResIn));

end Behavioral;
