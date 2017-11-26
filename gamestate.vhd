process (sw1, sw2, sw3)
variable flag : bit := '0';

begin
    GameState(0) <= sw1;
    GameState(1) <= sw2;
    GameState(2) <= sw3;


    -- Once in P2 setup phase, for the first time, reset the Col/Row of cursor
    if (GameState = "011" and flag = '0' ) then
        OCursorCol <= "000";
        OCursorRow <= '0';
        flag <= '1';
    end if;

    if (GameState = "111") then
    -- some code that fully resets game
    end if;
end process;
