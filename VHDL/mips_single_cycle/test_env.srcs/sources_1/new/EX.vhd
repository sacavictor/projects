
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity EX is
    Port (
        Pcp4 :  in std_logic_vector(31 downto 0);
        RD1 : in std_logic_vector(31 downto 0);
        RD2 : in std_logic_vector(31 downto 0);
        ext_imm : in std_logic_vector(31 downto 0);
        sa : in std_logic_vector(4 downto 0);
        func : in std_logic_Vector(5 downto 0);
        AluOp: in std_logic_vector(2 downto 0);
        AluSrc : in std_logic;
        AluRes : out std_logic_vector(31 downto 0);
        branchAddress : out std_logic_vector(31 downto 0);
        zero : out std_logic;
        notZero : out std_logic
    );
end EX;

architecture Behavioral of EX is
signal res : std_logic_vector(31 downto 0) := x"00000000";
signal scndIn : std_logic_vector(31 downto 0) := x"00000000";
signal ext_imm_shift : std_logic_vector(31 downto 0) := x"00000000";
signal AluCtrl : std_logic_vector(2 downto 0) := "000";
signal funct : std_logic_vector(2 downto 0) := "000";
signal registerResult : std_logic_vector(31 downto 0) := x"00000000";
signal result : std_logic_vector(31 downto 0) := x"00000000";
begin

scndIn <= RD2 when AluSrc = '0' else ext_imm when AluSrc = '1' else (others => 'X');

ext_imm_shift <= ext_imm(29 downto 0) & "00";

branchAddress <= ext_imm_shift + Pcp4;

zero <= '1' when result = x"00000000" else '0';
notZero <= '0' when result = x"00000000" else '1';

funct <=      "000" when func = "000000" --add
         else "001" when func = "000001" --sub
         else "010" when func = "000010" --sll
         else "011" when func = "000011" --slr
         else "100" when func = "000100" --and
         else "101" when func = "000101" --or
         else "110" when func = "000110"--slt
         else "111" when func = "000111"--noop
         else "XXX";

ALU_CTRL: process(func, AluOp, funct)
    begin
    case AluOp is
        when "000" => AluCtrl <= funct;
        when "001" => AluCtrl <= "000"; --addi, lw, sw
        when "010" => AluCtrl <= "001"; --branch
        when "101" => AluCtrl <= "100"; --and
        when "110" => AluCtrl <= "101"; -- or
        when others => AluCtrl <= "XXX";
    end case;
end process;

ALU: process(AluCtrl, Rd1, Rd2, AluSrc, ext_imm, sa)
begin
    case AluCtrl is
        when "000" => result <= RD1 + scndIn;
        when "001" => result <= RD1 - scndIn;
        when "010" => result <= to_stdlogicvector(to_bitvector(scndIn) sll conv_integer(sa));
        when "011" => result <= to_stdlogicvector(to_bitvector(scndIn) srl conv_integer(sa));
        when "100" => result <= RD1 and scndIn;
        when "101" => result <= RD1 or scndIn;
        when "110" => if signed(RD1) < signed(scndIn) then result <= x"00000001"; else result <= x"00000000"; end if;
        when "111" => result <= x"00000000";
        when others => result <= (others => 'X');
    end case;
end process;

aluRes <= result;
end Behavioral;
