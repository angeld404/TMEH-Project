library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity gamestate is
    Port ( sw1 : in STD_LOGIC;
           sw2 : in STD_LOGIC;
           sw3 : in STD_LOGIC;
           Ubtn : in STD_LOGIC;
           Dbtn : in STD_LOGIC;
           Lbtn : in STD_LOGIC;
           Rbtn : in STD_LOGIC;
           Mbtn : in STD_LOGIC);
end gamestate;

architecture Behavioral of gamestate is

signal GameState, OCursorCol, NCursorCol : std_logic_vector(2 downto 0) := "000";
signal OCursorRow : integer := 0;

signal R_SMP1_A, R_SMP1_B, R_SMP1_C, R_SMP1_D, R_SMP1_E, R_SMP2_A, R_SMP2_B, R_SMP2_C, R_SMP2_D, R_SMP2_E, R_HMP1_A, R_HMP1_B, R_HMP1_C, R_HMP1_D, R_HMP1_E, R_HMP2_A, R_HMP2_B, R_HMP2_C, R_HMP2_D, R_HMP2_E,
       G_SMP1_A, G_SMP1_B, G_SMP1_C, G_SMP1_D, G_SMP1_E, G_SMP2_A, G_SMP2_B, G_SMP2_C, G_SMP2_D, G_SMP2_E, G_HMP1_A, G_HMP1_B, G_HMP1_C, G_HMP1_D, G_HMP1_E, G_HMP2_A, G_HMP2_B, G_HMP2_C, G_HMP2_D, G_HMP2_E : std_logic_vector(7 downto 0) := "00000000";


begin

process (sw1, sw2, sw3)
begin
    GameState(0) <= sw1;
    GameState(1) <= sw2;
    GameState(2) <= sw3;
    
    -- If P2 Set Up phase or Attack Phase starts, Cursor is reset
    if (rising_edge(sw2)) or (rising_edge(sw3)) then
        OCursorCol <= "000";
        OCursorRow <= 0;
    end if;
    
    -- If all switches are off ('0') Game maps are reset.
    if GameState = "000" then
        OcursorCol <= "000";
        OCursorRow <= 0;
        R_HMP1_A <= "00000000";
        R_HMP1_B <= "00000000";
        R_HMP1_C <= "00000000";
        R_HMP1_D <= "00000000";
        
        R_HMP2_A <= "00000000";
        R_HMP2_B <= "00000000";
        R_HMP2_C <= "00000000";
        R_HMP2_D <= "00000000";
        
        R_SMP1_A <= "00000000";
        R_SMP1_B <= "00000000";
        R_SMP1_C <= "00000000";
        R_SMP1_D <= "00000000";
        
        R_SMP2_A <= "00000000";
        R_SMP2_B <= "00000000";
        R_SMP2_C <= "00000000";
        R_SMP2_D <= "00000000";

        G_HMP1_A <= "00000000";
        G_HMP1_B <= "00000000";
        G_HMP1_C <= "00000000";
        G_HMP1_D <= "00000000";
        
        G_HMP2_A <= "00000000";
        G_HMP2_B <= "00000000";
        G_HMP2_C <= "00000000";
        G_HMP2_D <= "00000000";
        
        G_SMP1_A <= "00000000";
        G_SMP1_B <= "00000000";
        G_SMP1_C <= "00000000";
        G_SMP1_D <= "00000000";
        
        G_SMP2_A <= "00000000";
        G_SMP2_B <= "00000000";
        G_SMP2_C <= "00000000";
        G_SMP2_D <= "00000000"; 
    end if;       
end process;

end Behavioral;
        
        
        


-- This needs work. I need it so that when a new state is triggered, the column and row variables are reset
