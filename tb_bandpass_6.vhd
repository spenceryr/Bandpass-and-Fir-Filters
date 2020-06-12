library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_bandpass is
end tb_bandpass;

architecture tb of tb_bandpass is
    type a_wave is array (0 to 19) of integer range -128 to 127;
    signal wave: a_wave := (-75, -120, -47, -29, -97,
                            -63, 113, 48, -127, 37, 
                            -70, 94, 94, -58, -110, 
                            -14, -102, -122, -21, 5
                           );
    signal clk: std_logic := '0';
    signal Xin: signed(7 downto 0) := (others => '0');
    signal Yout_1: signed(31 downto 0) := (others => '0');
    signal Yout_2: signed(31 downto 0) := (others => '0');
    signal Yout_3: signed(31 downto 0) := (others => '0');
    signal Yout_4: signed(31 downto 0) := (others => '0');
    signal Yout_5: signed(31 downto 0) := (others => '0');
    signal Yout_6: signed(31 downto 0) := (others => '0');
    signal Yout_comb: signed(31 downto 0) := (others => '0');

    signal done: std_logic := '0';
    
    component bandpasses_6
    port (clk:  in std_logic;
          Xin:  in signed(7 downto 0);
          Yout_1: inout signed(31 downto 0);
          Yout_2: inout signed(31 downto 0);
          Yout_3: inout signed(31 downto 0);
          Yout_4: inout signed(31 downto 0);
          Yout_5: inout signed(31 downto 0);
          Yout_6: inout signed(31 downto 0);
          Yout_comb: inout signed(31 downto 0)
         );
    end component;
    
begin
    uut: bandpasses_6 port map (clk  => clk,
                            Xin  => Xin,
                            Yout_1 => Yout_1,
                            Yout_2 => Yout_2,
                            Yout_3 => Yout_3,
                            Yout_4 => Yout_4,
                            Yout_5 => Yout_5,
                            Yout_6 => Yout_6,
                            Yout_comb => Yout_comb
                           );
    clock: process
    begin
        if done = '1' then
        wait;
        end if;
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;
    
    tests: process
    begin
        for i in 0 to 19 loop
            Xin <= to_signed(wave(i), Xin'length);
            wait for 2 ns;
            report "Value 1 is " & integer'image(to_integer(Yout_1));
            report "Value 2 is " & integer'image(to_integer(Yout_2));
            report "Value 3 is " & integer'image(to_integer(Yout_3));
            report "Value 4 is " & integer'image(to_integer(Yout_4));
            report "Value 5 is " & integer'image(to_integer(Yout_5));
            report "Value 6 is " & integer'image(to_integer(Yout_6));
            report "Value Comb is " & integer'image(to_integer(Yout_comb));
        end loop;
        wait for 2 ns;
        done <= '1';
        wait;
    end process;
    
end tb;
    