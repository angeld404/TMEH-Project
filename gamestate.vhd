process (sw1, sw2, sw3)
begin
    GameState(0) <= sw1;
    GameState(1) <= sw2;
    GameState(2) <= sw3;


-- This needs work. I need it so that when a new state is triggered, the column and row variables are reset
