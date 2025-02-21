
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IDecode is
    Port (
        clk : in std_logic;
        en : in std_logic;
        WD : in std_logic_vector(31 downto 0);
        RegWrite: in std_logic;
        RegDest : in std_logic;
        ExtOp : in std_logic;
        Instr : in std_logic_vector(25 downto 0);
        Rd1, Rd2 : out std_logic_vector(31 downto 0);
        extImm : out std_logic_vector(31 downto 0);
        func : out std_logic_vector(5 downto 0);
        sa : out std_logic_vector(4 downto 0)
    );
end IDecode;


architecture arh_IDecode of IDecode is
type regF_t is array (0 to 31) of std_logic_vector(31 downto 0);

signal regArray : regF_t := (others => x"00000000");
signal address : std_logic_vector(4 downto 0) := "00000";
begin

address <= Instr(15 downto 11) when RegDest = '1' else Instr(20 downto 16) when RegDest = '0' else (others => 'X');

register_file_label: process(clk)
    begin
        if rising_edge(clk) then
            if regWrite = '1' and en = '1' then
                regArray(conv_integer(address)) <= WD;
            end if;
        end if;
    end process;
        
extend : process(instr(15 downto 0), extOp)
    begin
        if extOp = '0' then
            ExtImm <= x"0000" & Instr(15 downto 0);
        elsif extOp = '1' then
            ExtImm(31 downto 16) <= (others => instr(15));
            ExtImm(15 downto 0) <= instr(15 downto 0);
        end if;
    end process;

RD1 <= regArray(conv_integer(instr(25 downto 21)));    
RD2 <= regArray(conv_integer(instr(20 downto 16)));
func <= instr(5 downto 0);
sa <= instr(10 downto 6);

end arh_IDecode;


