LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY acc IS
    PORT(
		  alu_reg: IN std_logic_vector(15 DOWNTO 0);
		  add_done: IN std_logic;
		  reset_sig: IN std_logic;
		  clk: IN std_logic;
		  store_sig: IN std_logic;
		  load_sig: IN std_logic;
		  acc_reg: OUT std_logic_vector(15 DOWNTO 0);
		  buswire: INOUT std_logic_vector(15 DOWNTO 0)
	 );
END acc;

ARCHITECTURE acc_architecture OF acc IS
SIGNAL ireg: std_logic_vector(15 DOWNTO 0);
BEGIN
	 
    acc_reg <= ireg;  --output to ALU
    buswire <= ireg WHEN store_sig='1' ELSE (OTHERS=>'Z');  --write to buswire
	 
    PROCESS(clk,reset_sig) 
    BEGIN
        IF reset_sig='1' THEN
            ireg <= "0000000000000000";
        ELSIF rising_edge(clk) THEN
            IF load_sig='1' THEN
                ireg <= buswire;  --get content at memory address
            ELSIF add_done='1' THEN 
                ireg <= alu_reg;  --refresh when ADD complete
            END IF;
        END IF;
    END PROCESS;
	 
END acc_architecture;