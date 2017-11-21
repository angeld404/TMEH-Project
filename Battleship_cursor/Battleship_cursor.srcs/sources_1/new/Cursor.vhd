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
           Select : in STD_LOGIC);
end Cursor;

architecture Behavioral of Cursor is

begin

    process 
    begin
    
    cursor
        
        case (GameState) is
            when "000" =>
                
                case "000" then
                
                    HM_P1_A[0] <= '1';
                    
                    if rising_edge(Ubtn) then
                        NS1 <= "111";
                        HM_P1_A[0] <= '0';
    
                    if rising_edge(Dbtn) then
                        NS1 <= "001";
                        HM_P1_A[0] <= '0';
    
                case "001" then
                    HM_P1_A[1] <= '1';
                    if rising_edge(Ubtn) then
                        NS1 <= "000";
    
                    if rising_edge(Dbtn) then
                        NS1 <= "010";
    
                    if rising_edge(Lbtn) then
                        NS <= "100";
                    
                    if rising_edge(Rbtn) then
                        NS <= "001";


end Behavioral;
