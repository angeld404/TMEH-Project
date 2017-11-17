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


end Behavioral;
