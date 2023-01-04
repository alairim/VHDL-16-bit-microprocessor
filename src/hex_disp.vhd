LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY hex_disp IS
    PORT(
		  acc_reg: IN std_logic_vector(15 DOWNTO 0);
		  display0: OUT std_logic_vector(6 DOWNTO 0);
		  display1: OUT std_logic_vector(6 DOWNTO 0);
		  display2: OUT std_logic_vector(6 DOWNTO 0);
		  display3: OUT std_logic_vector(6 DOWNTO 0)
	 );
END hex_disp;

ARCHITECTURE hex_disp_architecture OF hex_disp IS
SIGNAL ori0: std_logic_vector(3 DOWNTO 0);
SIGNAL ori1: std_logic_vector(3 DOWNTO 0);
SIGNAL ori2: std_logic_vector(3 DOWNTO 0);
SIGNAL ori3: std_logic_vector(3 DOWNTO 0);
BEGIN
	 
    ori0 <= acc_reg(3 DOWNTO 0);
    ori1 <= acc_reg(7 DOWNTO 4);
    ori2 <= acc_reg(11 DOWNTO 8);
    ori3 <= acc_reg(15 DOWNTO 12);
    PROCESS(ori0,ori1,ori2,ori3) 
    BEGIN
        CASE ori0 IS 
            WHEN "0000" => display0 <= "0000001"; --0:01 
            WHEN "0001" => display0 <= "1001111"; --1:4F 
            WHEN "0010" => display0 <= "0010010"; --2:12 
            WHEN "0011" => display0 <= "0000110"; --3:06 
            WHEN "0100" => display0 <= "1001100"; --4:4C 
            WHEN "0101" => display0 <= "0100100"; --5:24 
            WHEN "0110" => display0 <= "0100000"; --6:20 
            WHEN "0111" => display0 <= "0001111"; --7:0F 
            WHEN "1000" => display0 <= "0000000"; --8:00 
            WHEN "1001" => display0 <= "0000100"; --9:04 
            WHEN "1010" => display0 <= "0001000"; --A:08 
            WHEN "1011" => display0 <= "1100000"; --B:60 
            WHEN "1100" => display0 <= "0110001"; --C:31 
            WHEN "1101" => display0 <= "1000010"; --D:42 
            WHEN "1110" => display0 <= "0110000"; --E:30 
            WHEN "1111" => display0 <= "0111000"; --F:38 
            WHEN OTHERS => display0 <= "0000000"; 
        END CASE;
		  
        CASE ori1 IS 
            WHEN "0000" => display1 <= "0000001"; --0:01 
            WHEN "0001" => display1 <= "1001111"; --1:4F 
            WHEN "0010" => display1 <= "0010010"; --2:12 
            WHEN "0011" => display1 <= "0000110"; --3:06 
            WHEN "0100" => display1 <= "1001100"; --4:4C 
            WHEN "0101" => display1 <= "0100100"; --5:24 
            WHEN "0110" => display1 <= "0100000"; --6:20 
            WHEN "0111" => display1 <= "0001111"; --7:0F 
            WHEN "1000" => display1 <= "0000000"; --8:00 
            WHEN "1001" => display1 <= "0000100"; --9:04 
            WHEN "1010" => display1 <= "0001000"; --A:08 
            WHEN "1011" => display1 <= "1100000"; --B:60 
            WHEN "1100" => display1 <= "0110001"; --C:31 
            WHEN "1101" => display1 <= "1000010"; --D:42 
            WHEN "1110" => display1 <= "0110000"; --E:30 
            WHEN "1111" => display1 <= "0111000"; --F:38 
            WHEN OTHERS => display1 <= "0000000"; 
        END CASE;
		  
        CASE ori2 IS 
            WHEN "0000" => display2 <= "0000001"; --0:01 
            WHEN "0001" => display2 <= "1001111"; --1:4F 
            WHEN "0010" => display2 <= "0010010"; --2:12 
            WHEN "0011" => display2 <= "0000110"; --3:06 
            WHEN "0100" => display2 <= "1001100"; --4:4C 
            WHEN "0101" => display2 <= "0100100"; --5:24 
            WHEN "0110" => display2 <= "0100000"; --6:20 
            WHEN "0111" => display2 <= "0001111"; --7:0F 
            WHEN "1000" => display2 <= "0000000"; --8:00 
            WHEN "1001" => display2 <= "0000100"; --9:04 
            WHEN "1010" => display2 <= "0001000"; --A:08 
            WHEN "1011" => display2 <= "1100000"; --B:60 
            WHEN "1100" => display2 <= "0110001"; --C:31 
            WHEN "1101" => display2 <= "1000010"; --D:42 
            WHEN "1110" => display2 <= "0110000"; --E:30 
            WHEN "1111" => display2 <= "0111000"; --F:38 
            WHEN OTHERS => display2 <= "0000000"; 
        END CASE;
		  
        CASE ori3 IS 
            WHEN "0000" => display3 <= "0000001"; --0:01 
            WHEN "0001" => display3 <= "1001111"; --1:4F 
            WHEN "0010" => display3 <= "0010010"; --2:12 
            WHEN "0011" => display3 <= "0000110"; --3:06 
            WHEN "0100" => display3 <= "1001100"; --4:4C 
            WHEN "0101" => display3 <= "0100100"; --5:24 
            WHEN "0110" => display3 <= "0100000"; --6:20 
            WHEN "0111" => display3 <= "0001111"; --7:0F 
            WHEN "1000" => display3 <= "0000000"; --8:00 
            WHEN "1001" => display3 <= "0000100"; --9:04 
            WHEN "1010" => display3 <= "0001000"; --A:08 
            WHEN "1011" => display3 <= "1100000"; --B:60 
            WHEN "1100" => display3 <= "0110001"; --C:31 
            WHEN "1101" => display3 <= "1000010"; --D:42 
            WHEN "1110" => display3 <= "0110000"; --E:30 
            WHEN "1111" => display3 <= "0111000"; --F:38 
            WHEN OTHERS => display3 <= "0000000"; 
        END CASE;
    END PROCESS;
	 
END hex_disp_architecture;