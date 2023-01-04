LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY instr_reg IS
    PORT(
		  state_Sig: IN std_logic_vector(1 DOWNTO 0);
		  clk: IN std_logic;
		  buswire: IN std_logic_vector(15 DOWNTO 0);
		  ir_addr: OUT std_logic_vector(7 DOWNTO 0);
		  ir_ev: OUT std_logic;
		  add_sig: OUT std_logic;
		  store_sig: OUT std_logic;
		  load_sig: OUT std_logic;
		  jump_sig: OUT std_logic;
		  jneg_sig: OUT std_logic
	 );
END instr_reg;

ARCHITECTURE instr_reg_architecture OF instr_reg IS
SIGNAL op: std_logic_vector(7 DOWNTO 0);
SIGNAL iaddr: std_logic_vector(7 DOWNTO 0);
SIGNAL ev: std_logic;
SIGNAL decode_done: std_logic := '0';
BEGIN
	 
    --output to MIF
    ir_addr <= iaddr;
    ir_ev <= decode_done;
	 
    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF state_Sig = "00" THEN  --reset_s
                ev <= '0';
                iaddr <= (OTHERS=>'0');
                op <= (OTHERS=>'0');
            ELSIF state_Sig = "01" THEN  --fetch_s
                ev <= '0';
            ELSIF state_Sig = "10" THEN  --execute_s
                ev <= '1';
                iaddr <= buswire(7 DOWNTO 0);  --get address
                op <= buswire(15 DOWNTO 8);  --get op code
            END IF;
        END IF;
    END PROCESS;
	 
    PROCESS(ev)  --decode process
    BEGIN
        add_sig <= '0';  --reset output signal
        store_sig <= '0';
        load_sig <= '0';
        jump_sig <= '0';
        jneg_sig <= '0';
        decode_done <= '0';
        IF ev='1' THEN
            decode_done <= '1';
            CASE op IS
                WHEN "00000000" =>  --ADD
                    add_sig <= '1';
                WHEN "00000001" =>  --STORE
                    store_sig <= '1';
                WHEN "00000010" =>  --LOAD
                    load_sig <= '1';
                WHEN "00000011" =>  --JUMP
                    jump_sig <= '1';
                WHEN "00000100" =>  --JNEG
                    jneg_sig <= '1';
                WHEN OTHERS =>  
                    NULL;
            END CASE;
        END IF;
    END PROCESS;
END instr_reg_architecture;