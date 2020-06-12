library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_4tap is
generic (t0: integer := -2;
         t1: integer := -1;
         t2: integer := 3;
         t3: integer := 4;
         in_width: integer := 8;
         out_width: integer:= 16
        );
port (clk:  in std_logic;
      Xin:  in signed(in_width-1 downto 0);
      Yout: out signed(out_width - 1 downto 0)
     );
end fir_4tap;

architecture behavior_1 of fir_4tap is
    signal insamp: signed((in_width * 3)-1 downto 0) := (others => '0');
    signal result: signed(out_width-1 downto 0) := (others => '0');
begin
    process(clK)
        variable r0: signed(out_width-1 downto 0) := (others => '0'); 
        variable r1: signed(out_width-1 downto 0) := (others => '0');
        variable r2: signed(out_width-1 downto 0) := (others => '0');
        variable r3: signed(out_width-1 downto 0) := (others => '0');
    begin
        if (clk'event and clk='1') then
            r0 := resize(t0 * Xin((in_width - 1) downto 0), r0'length);
            r1 := resize(t1 * insamp((in_width * 3)-1 downto (in_width * 2)), r1'length);
            r2 := resize(t2 * insamp((in_width * 2) - 1 downto in_width), r2'length);
            r3 := resize(t3 * insamp((in_width - 1) downto 0), r3'length);
            result <= r0 + r1 + r2 + r3;

            insamp <= (Xin((in_width - 1) downto 0) & insamp((in_width * 3) - 1 downto in_width));
        end if;
    end process;

    Yout <= result;


end behavior_1;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity bandpass is
generic (b_in_width: integer := 8;
		 b_inter_width: integer := 16;
		 b_out_width: integer := 32
        );
port (clk:  in std_logic;
      Xin:  in signed(b_in_width-1 downto 0);
      Yout: out signed(b_out_width-1 downto 0)
     );
end bandpass;

architecture structural of bandpass is
	component fir_4tap
    generic (t0: integer := -2;
         t1: integer := -1;
         t2: integer := 3;
         t3: integer := 4;
         in_width: integer := 8;
         out_width: integer := 16
        );
    port (clk:  in std_logic;
          Xin:  in signed(in_width - 1 downto 0);
          Yout: out signed(out_width - 1 downto 0)
         );
    end component;
    
    signal Y_inter: signed(b_inter_width - 1 downto 0) := (others => '0');
begin
    lowpass: fir_4tap generic map (t0 => 1,
                                   t1 => 2,
                                   t2 => -2,
                                   t3 => -3,
                                   in_width => b_in_width,
                                   out_width => b_inter_width
                                  )
                      port map (clk => clk,
                                Xin => Xin,
                                Yout => Y_inter
                               );
	highpass: fir_4tap generic map (t0 => -2,
                                    t1 => -1,
                                    t2 => 3,
                                    t3 => 4,
                                    in_width => b_inter_width,
                                    out_width => b_out_width
                                  )
                       port map (clk => clk,
                                 Xin => Y_inter,
                                 Yout => Yout
                                );
end structural;


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity bandpasses_6 is
port (clk:  in std_logic;
      Xin:  in signed(7 downto 0);
      Yout_1: inout signed(31 downto 0);
      Yout_2: inout signed(31 downto 0);
      Yout_3: inout signed(31 downto 0);
      Yout_4: inout signed(31 downto 0);
      Yout_5: inout signed(31 downto 0);
      Yout_6: inout signed(31 downto 0);
      Yout_comb: out signed(31 downto 0)
     );
end bandpasses_6;

architecture structural of bandpasses_6 is
	component bandpass
    generic (b_in_width: integer := 8;
    		 b_inter_width: integer := 16;
             b_out_width: integer := 32
            );
    port (clk:  in std_logic;
          Xin:  in signed(b_in_width - 1 downto 0);
          Yout: inout signed(b_out_width - 1 downto 0)
         );
    end component;
begin
    bandpass_1: bandpass generic map (b_in_width => 8,
    								  b_inter_width => 16,
    							      b_out_width => 32
                                  	 )
                          port map (clk => clk,
                                    Xin => Xin,
                                    Yout => Yout_1
                                   );
	bandpass_2: bandpass generic map (b_in_width => 8,
    								  b_inter_width => 16,
    							      b_out_width => 32
                                  	 )
                          port map (clk => clk,
                                    Xin => Xin,
                                    Yout => Yout_2
                                   );
	bandpass_3: bandpass generic map (b_in_width => 8,
    								  b_inter_width => 16,
    							      b_out_width => 32
                                  	 )
                          port map (clk => clk,
                                    Xin => Xin,
                                    Yout => Yout_3
                                   );
	bandpass_4: bandpass generic map (b_in_width => 8,
    								  b_inter_width => 16,
    							      b_out_width => 32
                                  	 )
                          port map (clk => clk,
                                    Xin => Xin,
                                    Yout => Yout_4
                                   );
	bandpass_5: bandpass generic map (b_in_width => 8,
    								  b_inter_width => 16,
    							      b_out_width => 32
                                  	 )
                          port map (clk => clk,
                                    Xin => Xin,
                                    Yout => Yout_5
                                   );
	bandpass_6: bandpass generic map (b_in_width => 8,
    								  b_inter_width => 16,
    							      b_out_width => 32
                                  	 )
                          port map (clk => clk,
                                    Xin => Xin,
                                    Yout => Yout_6
                                   );
    Yout_comb <= Yout_1 + Yout_2 + Yout_3 + Yout_4 + Yout_5 + Yout_6;
	
     
end structural;