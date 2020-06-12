library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_4tap is
generic (t0: integer := -2;
         t1: integer := -1;
         t2: integer := 3;
         t3: integer := 4
        );
port (clk:  in std_logic;
      Xin:  in signed(7 downto 0);
      Yout: out signed(15 downto 0)
     );
end fir_4tap;

architecture behavior_1 of fir_4tap is
    signal insamp: signed(23 downto 0) := (others => '0');
    signal result: signed(15 downto 0) := (others => '0');
begin
    process(clK)
        variable r0: signed(15 downto 0) := (others => '0');
        variable r1: signed(15 downto 0) := (others => '0');
        variable r2: signed(15 downto 0) := (others => '0');
        variable r3: signed(15 downto 0) := (others => '0');
    begin
        if (clk'event and clk='1') then
            r0 := t0 * Xin(7 downto 0);
            r1 := t1 * insamp(23 downto 16);
            r2 := t2 * insamp(15 downto 8);
            r3 := t3 * insamp(7 downto 0);
            result <= r0 + r1 + r2 + r3;

            insamp <= (Xin(7 downto 0) & insamp(23 downto 8));
        end if;
    end process;

    Yout <= result;


end behavior_1;