library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fir_4tap is
end tb_fir_4tap;

architecture tb of tb_fir_4tap is
    type a_wave is array (0 to 19) of integer range -128 to 127;
    signal wave: a_wave := (-75, -120, -47, -29, -97,
                            -63, 113, 48, -127, 37, 
                            -70, 94, 94, -58, -110, 
                            -14, -102, -122, -21, 5
                           );
    signal clk: std_logic := '0';
    signal Xin: signed(7 downto 0) := (others => '0');
    signal Yout: signed(15 downto 0) := (others => '0');
    
    component fir_4tap
    port (clk:  in std_logic;
          Xin:  in signed(7 downto 0);
          Yout: out signed(15 downto 0)
         );
    end component;
    
begin
    uut: fir_4tap port map (clk  => clk,
                            Xin  => Xin,
                            Yout => Yout
                           );
    clock: process
    begin
        clk <= '0';
        wait for 500 ps;
        clk <= '1';
        wait for 500 ps;
    end process;
    
    tests: process
    begin
        for i in 0 to 19 loop
            Xin <= to_signed(wave(i), Xin'length);
            report "Value is " & integer'image(to_integer(Yout));
            wait for 1 ns;
        end loop;
        wait;
    end process;
    
end tb;
    