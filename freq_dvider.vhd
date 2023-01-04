LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY freq_dvider IS
    PORT(
	     clock: IN std_logic;
	     reset: IN std_logic;
	     clk: OUT std_logic
	 );
END freq_dvider;

ARCHITECTURE freq_dvider_architecture OF freq_dvider IS
SIGNAL reg: INTEGER RANGE 0 TO 24999999;
SIGNAL i_clk: std_logic;
BEGIN

    PROCESS(reset,clock)
    BEGIN
        IF reset='0' THEN
            reg <= 0;
            i_clk <= '0';
        ELSIF rising_edge(clock) THEN
            IF reg=24999999 THEN
                i_clk <= not i_clk;
                reg <= 0;
            ELSE
                reg <= reg + 1;
            END IF;
        END IF;
    END PROCESS;
	 
    clk <= i_clk;

END freq_dvider_architecture;