
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;


architecture Behavioral of test_env is
signal mono, mono1: std_logic := '0';
signal digits, instruction, pcInc, RD1, RD2, ext_imm, wd : std_logic_vector(31 downto 0) := x"00000000";
signal sa : std_logic_vector(4 downto 0) := "00000";
signal func : std_logic_vector(5 downto 0) := "000000";
signal regDst, regWrite, extOp, AluSrc, branch, jump, memWrite, memReg, bne : std_logic :='0';
signal aluOp : std_logic_vector(2 downto 0) := "000";
signal aluRes, aluRes1 : std_logic_vector(31 downto 0) := X"00000000";
signal zero : std_logic := '0';
signal branchAddress : std_logic_vector(31 downto 0) := x"00000002";
signal jumpAddress : std_logic_vector(31 downto 0) := x"00000000";
signal memData : std_logic_vector(31 downto 0) := x"00000000";
signal pcSrc : std_logic := '0';

type romT is array (0 to 31) of std_logic_vector(31 downto 0);
signal rom : romT := (
      x"0001",
      x"0002",
      x"0003",
      x"0004",
      x"0005",
      x"0006",
      x"0007",
      x"0008",
      x"0009",
      x"000A",
      x"000B",
      x"000C",
      x"000D",
      x"000E",
      x"000F",
      x"0010",
      x"0011",
      others => x"0000"
    );

component mpg is
    port(
        btn : in std_logic;
        clk: in std_logic;
        enable : out std_logic
    );
end component;

component SSD is
    Port(
        clk : in std_logic;
        digits : in std_logic_vector(31 downto 0);
        an : out std_logic_vector(7 downto 0);
        cat : out std_logic_vector(6 downto 0)
    );
end component;



component IFetch is
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
end component;

component IDecode is
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
end component;

component UC is
     Port (
        instr : in std_logic_vector(5 downto 0);
        regDst : out std_logic;
        extOp : out std_logic;
        aluSrc : out std_logic;
        branch : out std_logic;
        jump : out std_logic;
        aluOp : out std_logic_vector(2 downto 0);
        memWrite : out std_logic;
        memReg : out std_logic;
        regWrite : out std_logic;
        bne : out std_logic
      );
end component;

component EX is
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
end component;

component mem is
    Port (
        clk : in std_logic;
        memWrite, en : in std_logic;
        aluResIn : in std_logic_vector(31 downto 0);
        RD2 : in std_logic_vector(31 downto 0);
        memData : out std_logic_vector(31 downto 0);
        aluResOut : out std_logic_vector(31 downto 0)
    );
end component;

begin

monomimpulse : mpg port map(btn(0), clk, mono);
monoimpulse1 : mpg port map(btn(1), clk, mono1); 
afisare : SSD port map(clk, digits, an, cat);



instr: IFetch port map(clk, mono1, mono, jumpAddress, branchAddress, jump, pcSrc, pcInc, instruction);
decode: IDecode port map(clk, mono, WD, regWrite, regDst, extOp, instruction(25 downto 0), RD1, Rd2, ext_imm, func, sa);
maincontrol: UC port map(instruction(31 downto 26), regDst, extOp, aluSrc, branch, jump, aluOp, memWrite, memReg, regWrite, bne);
execute: EX port map(pcInc, Rd1, RD2, ext_imm, sa, func, aluOp, aluSrc, aluRes, branchAddress, zero);
memR: mem port map(clk, memWrite, mono, aluRes, RD2, memData, aluRes1);

with sw(7 downto 5) select 
    digits <= instruction when "000",
              pcInc when "001",
              RD1 when "010",
              RD2 when "011",
              ext_imm when "100",
              aluRes when "101",
              memData when "110",
              WD when "111";

led <= digits(15 downto 0);

WD <= aluRes1 when memReg = '0' else memData when memReg = '1' else (others =>'X');

PcSrc <= (branch and zero) or (branch and bne);


jumpAddress <= pcInc(31 downto 28) & instruction(25 downto 0) & "00";

end Behavioral;
