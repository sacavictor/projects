----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2024 10:18:53 PM
-- Design Name: 
-- Module Name: simulationTestBench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simulationTestBench is
end simulationTestBench;

architecture Behavioral of simulationTestBench is
signal clk : STD_LOGIC := '0';
signal btn : STD_LOGIC_VECTOR (4 downto 0):= (others => '0');
signal sw : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal led : STD_LOGIC_VECTOR(15 downto 0);
signal an : std_logic_Vector(7 downto 0);
signal cat : std_logic_Vector(6 downto 0);
component test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;
begin
comp : test_env port map(clk, btn, sw, led, an, cat);
 clk_process: process
    begin
        while now < 100 ns loop
            clk <= not clk;
            wait for 5 ns;
        end loop;
        wait;
    end process clk_process;

    stimulus_process: process
    begin
        wait for 10 ns; -- Initial wait time
        btn <= "00000";
        sw <= "0001100110001000";
        wait for 20 ns;

        btn <= "10000";
        sw <= "0101000101101001";
        wait for 20 ns;

        btn <= "10000";
        sw <= "1010100111000100";
        wait;
    end process stimulus_process;
end Behavioral;
