LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY io_intf IS
    PORT(
		  state_Sig: IN std_logic_vector(1 DOWNTO 0);
		  pc_addr: IN std_logic_vector(7 DOWNTO 0);  --address from pc
		  ir_addr: IN std_logic_vector(7 DOWNTO 0);  --address from ir
		  ir_ev: IN std_logic;
		  add_sig: IN std_logic;
		  store_sig: IN std_logic;
		  load_sig: IN std_logic;
		  jump_sig: IN std_logic;
		  we: OUT std_logic;  --write enable
		  address: OUT std_logic_vector(7 DOWNTO 0);
		  oe: OUT std_logic;  --output enable
		  data_io: INOUT std_logic_vector(15 DOWNTO 0);
		  buswire: INOUT std_logic_vector(15 DOWNTO 0)
	);
END io_intf;

ARCHITECTURE io_intf_architecture OF io_intf IS
BEGIN
	 
    buswire <= (OTHERS=>'Z') WHEN state_Sig="01" AND jump_sig='0' AND load_sig='0' AND add_sig='0' ELSE data_io;
    --output to MEMORY
    address <= ir_addr WHEN ir_ev='1' ELSE pc_addr;
    data_io <= buswire WHEN store_sig='1' ELSE (OTHERS=>'Z');
    PROCESS(store_sig)
    BEGIN
        IF store_sig='1' THEN  --output to MEMORY
            we <= '1';
            oe <= '1';
        ELSE
            we <= '0';
            oe <= '0';
        END IF;
    END PROCESS;

END io_intf_architecture;