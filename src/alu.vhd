LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alu IS
    PORT(
		  clk: IN std_logic;
		  jneg_sig: IN std_logic;
		  buswire: IN std_logic_vector(15 DOWNTO 0);
		  add_sig: IN std_logic;
		  pc_jneg: OUT std_logic;
		  acc_reg: IN std_logic_vector(15 DOWNTO 0);
		  alu_reg: OUT std_logic_vector(15 DOWNTO 0);
		  add_done: OUT std_logic
	 );
END alu;

ARCHITECTURE alu_architecture OF alu IS
SIGNAL ireg_A: std_logic_vector(15 DOWNTO 0);  --from AC
BEGIN
	 
    pc_jneg <= '1' WHEN jneg_sig='1' AND conv_integer(alu_reg) < 0 ELSE '0';
    PROCESS(clk)
    
    BEGIN
        IF rising_edge(clk) THEN
            IF add_sig='1' THEN  --calculation
                alu_reg <= acc_reg + buswire;
                add_done <= '1';
            ELSE
                ireg_A <= acc_reg;  --input from AC
                alu_reg <= (OTHERS=>'0');
                add_done <= '0';
            END IF;
        END IF;
    END PROCESS;

END alu_architecture;