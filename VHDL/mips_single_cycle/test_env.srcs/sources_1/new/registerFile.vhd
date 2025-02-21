
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity registerFile is
    Port(
        ra1 : in std_logic_vector(4 downto 0);
        ra2: in std_logic_vector(4 downto 0);
        wa : in std_logic_vector(4 downto 0);
        btn : in std_logic;
        clk : in std_logic;
        digits : out std_logic_vector(31 downto 0)
    );
end registerFile;

architecture arh_registerFile of registerFile is
signal enable2 : std_logic;
type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
signal reg_file : reg_array := (  others => X"00000000"); 
signal rd1, rd2, digits_signal : std_logic_vector(31 downto 0);


component mpg is
    port(
        btn : in std_logic;
        clk: in std_logic;
        enable : out std_logic
    );
end component;
begin
buton3 : mpg port map (btn, clk, enable2);

process(clk)
  begin
     if rising_edge(clk) then
        if enable2 = '1' then
             reg_file(conv_integer(wa)) <= digits_signal;
        end if;
    end if;  
 end process;   
 
 digits_signal <= reg_file(conv_integer(ra1)) + reg_file(conv_integer(ra2));
 digits <= digits_signal;

end arh_registerFile;
