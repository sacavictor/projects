

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;



entity mpg is
    port(
        btn : in std_logic;
        clk: in std_logic;
        enable : out std_logic
    );
end mpg;

architecture Behavioral of mpg is
signal Q1, Q2, Q3 : std_logic;
signal cnt_init : std_logic_vector(16 downto 0);
signal en : std_logic;
begin

count: process(clk)
begin
    if clk = '1' and clk'event then
        cnt_init <= cnt_init + 1;
    end if;
end process;

cnt_and: process(clk)
begin
    if en = '1' then
    if rising_edge(clk) then
            Q1 <= btn;
         end if;
         end if;
end process;

bistabile: process(clk)
begin
    if rising_edge(clk) then
        Q2 <= Q1;
        Q3 <= Q2;
    end if;
end process;

enable <= Q2 and (not Q3);
with cnt_init select
    en <= '1' when x"FFFF",
          '0' when others;

end Behavioral;