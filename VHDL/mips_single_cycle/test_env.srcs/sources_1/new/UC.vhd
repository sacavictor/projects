

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UC is
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
        bne: out std_logic
      );
end UC;

architecture Behavioral of UC is

begin
process(instr)
    begin
    case instr is
        when "000000" => 
             regDst <= '0';
             extOp <= '1';
             aluSrc <= '0';
             branch <= '0';
             jump <= '0';
             aluOp <= "000";
             memWrite <= '0';
             memReg <= '0';
             regWrite <= '1';
             bne <= '0';
        when "001000" => --addi
             regDst <= '0';
             extOp <= '1';
             aluSrc <= '1';
             branch <= '0';
             jump <= '0';
             aluOp <= "001";
             memWrite <= '0';
             memReg <= '0';
             regWrite <='1';
             bne <= '0';
        when "100011" =>    --lw 
             RegDst   <= '0';
             ExtOp    <= '1';
             ALUSrc   <= '1';
             Branch   <= '0';
             Jump     <= '0';
             ALUOp    <= "000"; -- adunare
             MemWrite <= '0';
             memReg <= '1';
             RegWrite <= '1';
             bne <= '0';
        when "101011" =>        --sw
             regDst <= 'X';
             extOp <= '1';
             aluSrc <= '1';
             branch <= '0';
             jump <= '0';
             aluOp <= "000";
             memWrite <= '1';
             memReg <= 'X';
             regWrite <='0';
             bne <= '0';
        when "000111" =>        --beq
             regDst <= 'X';
             extOp <= '1';
             aluSrc <= '0';
             branch <= '1';
             jump <= '0';
             aluOp <= "001";
             memWrite <= '0';
             memReg <= 'X';
             regWrite <='0';
             bne <= '0';
         when "000101" =>       --bne
             regDst <= 'X';
             extOp <= '1';
             aluSrc <= '0';
             branch <= '1';
             jump <= '0';
             aluOp <= "001";
             memWrite <= '0';
             memReg <= 'X';
             regWrite <='1';
             bne <= '1';
         when others => 
             regDst <= 'X';
             extOp <= 'X';
             aluSrc <= 'X';
             branch <= 'X';
             jump <= 'X';
             aluOp <= "XXX";
             memWrite <= 'X';
             memReg <= 'X';
             regWrite <='X';
             bne <= 'X';
  end case;
  end process;
end Behavioral;
