

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity SSD is
    
    Port(
        clk : in std_logic;
        digits : in std_logic_vector(31 downto 0);
        an : out std_logic_vector(7 downto 0);
        cat : out std_logic_vector(6 downto 0)
    );

end SSD;

architecture arh_SSD of SSD is
signal sel : std_logic_Vector(2 downto 0) := "000";
signal cnt : std_logic_vector(16 downto 0) :="00000000000000000";
signal muxOutCa : std_logic_vector(3 downto 0) := "0000";
begin

counter: process(clk)
begin
    if rising_edge(clk) then
        cnt <= cnt + 1;
    end if;
end process;

sel <= cnt(16 downto 14);

muxCatod : process(sel, digits)
begin
    case sel is
        when "000" => muxOutCa <= digits(3 downto 0);
        when "001" => muxOutCa <= digits(7 downto 4);
        when "010" => muxOutCa <= digits(11 downto 8);
        when "011" => muxOutCa <= digits(15 downto 12);
        when "100" => muxOutCa <= digits(19 downto 16);
        when "101" => muxOutCa <= digits(23 downto 20);
        when "110" => muxOutCa <= digits(27 downto 24);
        when "111" => muxOutCa <= digits(31 downto 28);
        when others => muxOutCa <= "XXXX";
    end case;
end process;

muxAnod : process(sel)
begin
    case sel is
        when "000" => an <= "11111110";
        when "001" => an <= "11111101";
        when "010" => an <= "11111011";
        when "011" => an <= "11110111";
        when "100" => an <= "11101111";
        when "101" => an <= "11011111";
        when "110" => an <= "10111111";
        when "111" => an <= "01111111";
        when others => an <= "XXXXXXXX";
    end case;
end process;

with muxOutCa select cat <=
        "1000000" when x"0",
        "1111001" when x"1",
        "0100100" when x"2",
        "0110000" when x"3",
        "0011001" when x"4",
        "0010010" when x"5",
        "0000010" when x"6",
        "1111000" when x"7",
        "0000000" when x"8",
        "0011000" when x"9",
        "0001000" when x"A",
        "0000011" when x"B",
        "0100011" when x"C",
        "0100001" when x"D",
        "0000110" when x"E",
        "0001110" when x"F",
        "1111111" when others;

end arh_SSD;
