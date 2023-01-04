LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY p_cnt IS
    PORT(
        reset_sig: IN std_logic;
        state_Sig: IN std_logic_vector(1 DOWNTO 0);
        pc_jneg: IN std_logic;
        jump_sig: IN std_logic;
        clk: IN std_logic;
        ir_addr: IN std_logic_vector(7 DOWNTO 0);
        pc_addr: OUT std_logic_vector(7 DOWNTO 0)
        );
END p_cnt;

ARCHITECTURE p_cnt_architecture OF p_cnt IS
SIGNAL pc: std_logic_vector(7 DOWNTO 0);
BEGIN

    PROCESS(clk,reset_sig)
    BEGIN
        IF reset_sig='1' THEN  --reset program counter
            pc <= "00000000";
        ELSIF rising_edge(clk) THEN  
            IF state_Sig(1) = '1' THEN  --pc add 1 when exec_s
                pc <= pc + '1';
            ELSIF jump_sig='1' OR pc_jneg='1' THEN  --pc jump
                pc <= ir_addr;
            END IF;
        END IF;
    END PROCESS;
    pc_addr <= pc;  --give address to MIF

END p_cnt_architecture;