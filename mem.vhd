LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;

PACKAGE MEM256 IS 
    COMPONENT mem IS 
        PORT(
		      reset_sig: IN std_logic;
		      we: IN std_logic;  --write enable
		      address: IN std_logic_vector(7 DOWNTO 0);
		      oe: IN std_logic;  --output enable
		      clk: IN std_logic;
		      data_io: INOUT std_logic_vector(15 DOWNTO 0)
		      ); 
    END COMPONENT; 
END PACKAGE MEM256;

	 
LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
	 
ENTITY mem IS
    PORT(
		  reset_sig: IN std_logic;
		  we: IN std_logic;  --write enable
		  address: IN std_logic_vector(7 DOWNTO 0);
		  oe: IN std_logic;  --output enable
		  clk: IN std_logic;
		  data_io: INOUT std_logic_vector(15 DOWNTO 0)
	 );
END mem;

ARCHITECTURE mem_architecture OF mem IS
TYPE MEMORY IS ARRAY(255 DOWNTO 0) OF std_logic_vector(15 DOWNTO 0); 
SIGNAL mem_array: MEMORY:=(OTHERS => (OTHERS => '0'));
SIGNAL data_in: std_logic_vector(15 DOWNTO 0);
SIGNAL data_out: std_logic_vector(15 DOWNTO 0);
BEGIN
	 
    data_in <= data_io;
    data_io <= data_out WHEN oe='0' ELSE (OTHERS => 'Z');
    --internal memory structure
    data_out <= mem_array(conv_integer(address)) WHEN we='0' ELSE (OTHERS => 'Z');
    
    PROCESS(clk,we,reset_sig) --writing process
    BEGIN
        IF reset_sig = '1' THEN
            --preset value
            mem_array(0) <= "0000001011111110";  --02FE:LOAD 254
            mem_array(1) <= "0000010000000100";  --0403:JNEG 04
            mem_array(2) <= "0000001011111101";  --0304:LOAD 253
            mem_array(3) <= "0000001100000011";  --0303:JUMP 03
            mem_array(253) <= "0000000000000100";  --0004
            mem_array(254) <= "0000000000000011";  --0003
        ELSIF rising_edge(clk) THEN
            IF we='1' THEN
                mem_array(conv_integer(address)) <= data_in;
            END IF;
        END IF;
    END PROCESS;
	 
END mem_architecture;


LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE work.MEM256.ALL;

ENTITY my_mem256 IS
    PORT(
		  reset_sig: IN std_logic;
		  we: IN std_logic;  --write enable
		  address: IN std_logic_vector(7 DOWNTO 0);
		  oe: IN std_logic;  --output enable
		  clk: IN std_logic;
		  data_in: IN std_logic_vector(15 DOWNTO 0);
		  data_out: OUT std_logic_vector(15 DOWNTO 0)
	 );
END my_mem256;

ARCHITECTURE my_mem256_architecture OF my_mem256 IS
SIGNAL bidirectional_buffer: std_logic_vector(15 downto 0);
BEGIN
    
    data_out <= bidirectional_buffer;
   bidirectional_buffer <= data_in WHEN oe='1' ELSE (OTHERS => 'Z');
    todo: mem port map (reset_sig,we,address,oe,clk,bidirectional_buffer);
	
END my_mem256_architecture;