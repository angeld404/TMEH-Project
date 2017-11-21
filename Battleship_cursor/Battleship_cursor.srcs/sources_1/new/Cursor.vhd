----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2017 11:33:05 AM
-- Design Name: 
-- Module Name: Cursor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cursor is
    Port ( Ubtn : in STD_LOGIC;
           Dbtn : in STD_LOGIC;
           Lbtn : in STD_LOGIC;
           Rbtn : in STD_LOGIC;
           Sbtn : in STD_LOGIC);
end Cursor;

architecture Behavioral of Cursor is

    signal CursorCol, CursorRow, NCursorCol, NCursorRow : std_logic_vector(2 downto 0) := "000";
    signal R_SMP1_A, R_SMP1_B, R_SMP1_C, R_SMP1_D, R_SMP1_E : std_logic_vector(7 downto 0) := "00000000";

begin

    process (Ubtn, Dbtn, Lbtn, Rbtn)
    begin
        case (CursorCol) is
            when "000" =>
                case (CursorRow) is
                    when "000" =>
                        R_SMP1_A(0) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "111";
                            R_SMP1_A(0) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "001";
                            R_SMP1_A(0) <= '0';
                        end if;
    
                    when "001" =>
                        R_SMP1_A(1) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "000";
                            R_SMP1_A(1) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "010";
                            R_SMP1_A(1) <= '0';
                        end if;
                        
                    when "010" =>
                        R_SMP1_A(2) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "001";
                            R_SMP1_A(2) <= '0';
                        end if;
            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "011";
                            R_SMP1_A(2) <= '0';
                        end if;

                    when "011" =>
                        R_SMP1_A(3) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "010";
                            R_SMP1_A(3) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "100";
                            R_SMP1_A(3) <= '0';
                        end if;

                    when "100" =>
                        R_SMP1_A(4) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "011";
                            R_SMP1_A(4) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "101";
                            R_SMP1_A(4) <= '0';
                        end if;
                            
                    when "101" =>
                        R_SMP1_A(5) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "100";
                            R_SMP1_A(5) <= '0';
                        end if;
                            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "110";
                            R_SMP1_A(5) <= '0';
                        end if;
                            
                    when "110" =>
                        R_SMP1_A(6) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "101";
                            R_SMP1_A(6) <= '0';
                        end if; 
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "111";
                            R_SMP1_A(6) <= '0';
                        end if;
                            
                    when "111" =>
                        R_SMP1_A(7) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "110";
                            R_SMP1_A(7) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "000";
                            R_SMP1_A(7) <= '0';
                        end if;    
                end case;
                
                if rising_edge(Lbtn) then
                    NCursorCol <= "101";
                end if;
                
                if rising_edge(Rbtn) then
                    NCursorCol <= "001";
                end if;

            when "001" =>
                case (CursorRow) is
                    when "000" =>
                        R_SMP1_B(0) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "111";
                            R_SMP1_B(0) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "001";
                            R_SMP1_B(0) <= '0';
                        end if;
    
                    when "001" =>
                        R_SMP1_B(1) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "000";
                            R_SMP1_B(1) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "010";
                            R_SMP1_B(1) <= '0';
                        end if;
                        
                    when "010" =>
                        R_SMP1_B(2) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "001";
                            R_SMP1_B(2) <= '0';
                        end if;
            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "011";
                            R_SMP1_B(2) <= '0';
                        end if;

                    when "011" =>
                        R_SMP1_B(3) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "010";
                            R_SMP1_B(3) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "100";
                            R_SMP1_B(3) <= '0';
                        end if;

                    when "100" =>
                        R_SMP1_B(4) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "011";
                            R_SMP1_B(4) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "101";
                            R_SMP1_B(4) <= '0';
                        end if;
                            
                    when "101" =>
                        R_SMP1_B(5) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "100";
                            R_SMP1_B(5) <= '0';
                        end if;
                            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "110";
                            R_SMP1_B(5) <= '0';
                        end if;
                            
                    when "110" =>
                        R_SMP1_B(6) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "101";
                            R_SMP1_B(6) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "111";
                            R_SMP1_B(6) <= '0';
                        end if;
                            
                    when "111" =>
                        R_SMP1_B(7) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "110";
                            R_SMP1_B(7) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "000";
                            R_SMP1_B(7) <= '0';
                        end if;    
                end case;

                if rising_edge(Lbtn) then
                    NCursorCol <= "001";
                end if;
                
                if rising_edge(Rbtn) then
                    NCursorCol <= "011";
                end if;
                
            when "011" =>
                case (CursorRow) is
                    when "000" =>
                        R_SMP1_C(0) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "111";
                            R_SMP1_C(0) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "001";
                            R_SMP1_C(0) <= '0';
                        end if;
    
                    when "001" =>
                        R_SMP1_C(1) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "000";
                            R_SMP1_C(1) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "010";
                            R_SMP1_C(1) <= '0';
                        end if;
                        
                    when "010" =>
                        R_SMP1_C(2) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "001";
                            R_SMP1_C(2) <= '0';
                        end if;
            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "011";
                            R_SMP1_C(2) <= '0';
                        end if;

                    when "011" =>
                        R_SMP1_C(3) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "010";
                            R_SMP1_C(3) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "100";
                            R_SMP1_C(3) <= '0';
                        end if;

                    when "100" =>
                        R_SMP1_C(4) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "011";
                            R_SMP1_C(4) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "101";
                            R_SMP1_C(4) <= '0';
                        end if;
                            
                    when "101" =>
                        R_SMP1_C(5) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "100";
                            R_SMP1_C(5) <= '0';
                        end if;
                            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "110";
                            R_SMP1_C(5) <= '0';
                        end if;
                            
                    when "110" =>
                        R_SMP1_C(6) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "101";
                            R_SMP1_C(6) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "111";
                            R_SMP1_C(6) <= '0';
                        end if;
                            
                    when "111" =>
                        R_SMP1_C(7) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "110";
                            R_SMP1_C(7) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "000";
                            R_SMP1_C(7) <= '0';
                        end if;    
                end case;

                if rising_edge(Lbtn) then
                    NCursorCol <= "010";
                end if;
                
                if rising_edge(Rbtn) then
                    NCursorCol <= "100";
                end if;

            when "100" =>
                case (CursorRow) is
                    when "000" =>
                        R_SMP1_D(0) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "111";
                            R_SMP1_D(0) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "001";
                            R_SMP1_D(0) <= '0';
                        end if;
    
                    when "001" =>
                        R_SMP1_D(1) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "000";
                            R_SMP1_D(1) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "010";
                            R_SMP1_D(1) <= '0';
                        end if;
                        
                    when "010" =>
                        R_SMP1_D(2) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "001";
                            R_SMP1_D(2) <= '0';
                        end if;
            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "011";
                            R_SMP1_D(2) <= '0';
                        end if;

                    when "011" =>
                        R_SMP1_D(3) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "010";
                            R_SMP1_D(3) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "100";
                            R_SMP1_D(3) <= '0';
                        end if;

                    when "100" =>
                        R_SMP1_D(4) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "011";
                            R_SMP1_D(4) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "101";
                            R_SMP1_D(4) <= '0';
                        end if;
                            
                    when "101" =>
                        R_SMP1_D(5) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "100";
                            R_SMP1_D(5) <= '0';
                        end if;
                            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "110";
                            R_SMP1_D(5) <= '0';
                        end if;
                            
                    when "110" =>
                        R_SMP1_D(6) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "101";
                            R_SMP1_D(6) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "111";
                            R_SMP1_D(6) <= '0';
                        end if;
                            
                    when "111" =>
                        R_SMP1_D(7) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "110";
                            R_SMP1_D(7) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "000";
                            R_SMP1_D(7) <= '0';
                        end if;    
                end case;

                if rising_edge(Lbtn) then
                    NCursorCol <= "011";
                end if;
                
                if rising_edge(Rbtn) then
                    NCursorCol <= "101";
                end if;
                
            when "101" =>
                case (CursorRow) is
                    when "000" =>
                        R_SMP1_E(0) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "111";
                            R_SMP1_E(0) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "001";
                            R_SMP1_E(0) <= '0';
                        end if;
    
                    when "001" =>
                        R_SMP1_E(1) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "000";
                            R_SMP1_E(1) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "010";
                            R_SMP1_E(1) <= '0';
                        end if;
                        
                    when "010" =>
                        R_SMP1_E(2) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "001";
                            R_SMP1_E(2) <= '0';
                        end if;
            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "011";
                            R_SMP1_E(2) <= '0';
                        end if;

                    when "011" =>
                        R_SMP1_E(3) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "010";
                            R_SMP1_E(3) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "100";
                            R_SMP1_E(3) <= '0';
                        end if;

                    when "100" =>
                        R_SMP1_E(4) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "011";
                            R_SMP1_E(4) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "101";
                            R_SMP1_E(4) <= '0';
                        end if;
                            
                    when "101" =>
                        R_SMP1_E(5) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "100";
                            R_SMP1_E(5) <= '0';
                        end if;
                            
                        if rising_edge(Dbtn) then
                            NCursorRow <= "110";
                            R_SMP1_E(5) <= '0';
                        end if;
                            
                    when "110" =>
                        R_SMP1_E(6) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "101";
                            R_SMP1_E(6) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "111";
                            R_SMP1_E(6) <= '0';
                        end if;
                            
                    when "111" =>
                        R_SMP1_E(7) <= '1';
                        if rising_edge(Ubtn) then
                            NCursorRow <= "110";
                            R_SMP1_E(7) <= '0';
                        end if;
    
                        if rising_edge(Dbtn) then
                            NCursorRow <= "000";
                            R_SMP1_E(7) <= '0';
                        end if;    
                end case;
                
                if rising_edge(Lbtn) then
                    NCursorCol <= "100";
                end if;
                
                if rising_edge(Rbtn) then
                    NCursorCol <= "000";
                end if;
                    
        end case;
    end process;
end Behavioral;
