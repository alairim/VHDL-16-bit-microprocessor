LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;

ENTITY ctrl_unit IS
    PORT(
		 clk: IN std_logic;
		 reset: IN std_logic;
		 reset_sig: OUT std_logic;
		 state_Sig: OUT std_logic_vector(1 DOWNTO 0)  --state signal
    );
END ctrl_unit;

ARCHITECTURE ctrl_unit_architecture OF ctrl_unit IS
TYPE state_type IS (reset_s,fetch_s,exec_s);  --define state type
SIGNAL CURRENT_S,NEXT_S: state_type;
SIGNAL iev: std_logic;
BEGIN
    
    PROCESS(reset, clk)
    BEGIN
        IF reset = '0' THEN
            CURRENT_S <= reset_s;  --reset the state machine
        ELSIF rising_edge(clk) THEN
            CURRENT_S <= NEXT_S;
        END IF;
    END PROCESS;
	 
    PROCESS(CURRENT_S)
    BEGIN   
        reset_sig <= '0';
        CASE CURRENT_S IS
        WHEN reset_s =>  --reset state
            NEXT_S <= fetch_s;
            state_Sig <= "00";
            reset_sig <= '1';
					 
        WHEN fetch_s =>  --fetch state
            NEXT_S <= exec_s;
            state_Sig <= "10";
				
        WHEN exec_s =>  --execute state
            NEXT_S <= fetch_s;
            state_Sig <= "01";
					 
        WHEN OTHERS =>
            state_Sig <= "XX";
        END CASE; 
    END PROCESS;

END ctrl_unit_architecture;