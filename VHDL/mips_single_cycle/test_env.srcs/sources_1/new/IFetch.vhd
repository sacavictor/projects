
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity IFetch is
    port(
        clk: in std_logic;
        rst: in std_logic;
        en: in std_logic;
        jumpAdress: in std_logic_vector(31 downto 0);
        branchAdress: in std_logic_vector(31 downto 0);
        jump, pcSrc: in std_logic;
        pcPlus4 : out std_logic_vector(31 downto 0);
        instruction : out std_logic_vector(31 downto 0)
    );
end IFetch;

architecture Behavioral of IFetch is
signal PC : std_logic_vector(31 downto 0) := x"00000000";
signal adress : std_logic_vector(31 downto 0) := x"00000000";
signal branch: std_logic_vector(31 downto 0) := x"00000000";
signal aluResult: std_logic_vector(31 downto 0) := x"00000000";
type romT is array(0 to 30) of std_logic_vector(31 downto 0);
signal rom_array : romT :=(
    B"100011_01000_00000_0000000000010000", --8D000010
    B"100011_01001_00000_0000000000000000", --8D200000
    B"000000_01001_01000_10000_00000_100010",--1288022
    B"000001_10000_00000_0000000000000110", --6000006
    B"001000_01001_10001_0000000000000001",--21310001
    B"001000_01000_10010_1111111111111111",--21310001
    B"000101_01000_01001_0000000000000010",--15090002
    B"000010_00000000000000000000010000", --8000010
    B"101011_01010_00101_0000000000000000",--AD450000
    B"00000000000000000000000000000000",--0
  others => x"00000000"
);

begin

PCreg: process(clk, rst)
    begin
    
    if rst = '1' then
        adress <= x"00000000";
    elsif rising_edge(clk) then
        if en = '1' then
            adress <= PC;
        end if;
    end if;
    end process;
    
muxuri: process(branchAdress, aluresult, pcSrc)
    begin
        case pcSrc is
            when '0' => branch <= aluResult;
            when '1' => branch <= branchAdress;
            when others => branch <= (others => 'X');
         end case;
end process;

process(jump, branch, jumpAdress)
begin
         case jump is
            when '0' => PC <= branch;
            when '1' => PC <= jumpAdress;
            when others => branch <= (others => 'X');
         end case;
    end process;
    
Romtt: instruction <= rom_array(conv_integer(adress(6 downto 2)));

sumator: pcPlus4 <= adress + 4;
aluResult <= adress + 4;
end Behavioral;
