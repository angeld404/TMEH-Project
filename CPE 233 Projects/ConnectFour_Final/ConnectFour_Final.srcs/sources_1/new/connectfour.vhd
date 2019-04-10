library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity connectfour is
    Port ( Lbtn : in STD_LOGIC; -- LEFT BUTTON
           Rbtn : in STD_LOGIC; -- RIGHT BUTTON
           Cbtn : in STD_LOGIC; -- CENTER BUTTON
           CLK  : in STD_LOGIC; -- CLOCK
           RST  : in STD_LOGIC; -- UP BUTTON/RESET


           -- Row Data out through PMOD connection 
           DORow : out STD_LOGIC_VECTOR(7 downto 0) := "00000000";
           
           -- Column Data out through PMOD connection
           DOCol : out STD_LOGIC_VECTOR(0 to 15) := "0000000000000000"
           );
end connectfour;

architecture Behavioral of connectfour is

    signal TurnState, NTurnState : std_logic := '1';
    signal RedA, RedB, RedC, RedD, RedE, RedF, RedG, RedH : std_logic_vector (7 downto 0) := "00000000"; -- Row data depending on column: RED
    signal GreenA, GreenB, GreenC, GreenD, GreenE, GreenF, GreenG, GreenH : std_logic_vector  (7 downto 0) := "00000000"; -- Row Data depending on column: GREEN
    signal ColCLK, BtnCLK : std_logic := '0'; -- Clocks

begin

-- Clock process opperating at 960Hz
CLKDivider : process (CLK)
    variable clkcount : integer range 0 to 52083 := 0;
    begin
        if (rising_edge(CLK)) then
            clkcount := clkcount + 1;
            if (clkcount = 52083) then
                ColCLK <= not(ColCLK);
                clkcount := 0;
            end if;
        end if;
end process;

-- Clock process opperating at 5 Hz.
ButtonCLK : process (CLK)
    variable btnclkcount : integer range 0 to 10000001 := 0;
    begin
    if (rising_edge(CLK)) then
        if (btnclkcount = 10000000) then
            btnclkcount := 0;
            BtnCLK <= not(BtnCLK);
        else
            btnclkcount := btnclkcount + 1;
        end if;
    end if;
end process;

-- Cursor Process.
    -- Allows for movement of cursor on top row of display. Color depends on player's turn Red/Green : P1/P2.
    -- Also allows for column selection using middle button: When a column is selected, lowest possible LED on same column is lit up corresponding to the player's color.
cursor : process (BtnCLK)
    
    variable OCursorCol : STD_LOGIC_VECTOR (2 downto 0) := "000";
        -- OCursorCol keeps track of previous column
    variable NCursorCol : STD_LOGIC_VECTOR (2 downto 0) := "000";
        -- NCursorCol sets new cursor column
    begin
    
    --RESET condition (UP Button)
        --Board is cleared for game to restart
    if (rising_edge(BtnCLK)) then
        if (RST = '1') then
            RedA <= "00000000";
            RedB <= "00000000";
            RedC <= "00000000";
            RedD <= "00000000";
            RedE <= "00000000";
            RedF <= "00000000";
            RedG <= "00000000";
            RedH <= "00000000";
            GreenA <= "00000000";
            GreenB <= "00000000";
            GreenC <= "00000000";
            GreenD <= "00000000";
            GreenE <= "00000000";
            GreenF <= "00000000";
            GreenG <= "00000000";
            GreenH <= "00000000";
        end if;
        
        --  Case statements depending on Current column of RED or GREEN cursor
        case (OCursorCol) is
            -- When Column A
            when "000" =>
                if (Lbtn = '1') then
                    NCursorCol := "111"; -- Column H
                elsif (Rbtn = '1') then
                    NCursorCol := "001"; -- Column B
                elsif (Cbtn = '1') then
                    NCursorCol := OCursorCol; -- Column stays the same
                    NTurnState <= not(TurnState); -- Triggers next player's turn
                    
                    -- Checks current coumn from botton to top and turns on first LED that is not on. Color depeds on current player's cursor color.
                    for ck in 7 downto 1 loop
                        if (RedA(0) = '1') and (RedA(ck) = '0') and (GreenA(ck) = '0') then
                            RedA(Ck) <= '1';
                            RedA(0) <= '0';
                        EXIT;
                        end if;

                        if (GreenA(0) = '1') and (RedA(ck) = '0') and (GreenA(ck) = '0') then
                            GreenA(Ck) <= '1';
                            GreenA(0) <= '0';
                        EXIT;
                        end if;
                        
                        
                    end loop;
                end if;
                
                -- Case that turns on LEDs on cursor row/column.
                    -- Color depeds on current Player's turn.
                    -- Location depends on Button presses/ Old location
                case (TurnState) is
                    when '0' => -- Red Player
                        GreenA(0) <= '0';
                        if (NCursorCol = OCursorCol) then -- If nothing was pressed
                            RedA(0) <= '1';
                        elsif (NCursorCol = "111") then --  If Lbtn was pressed
                            RedH(0) <= '1';
                            RedA(0) <= '0';
                        elsif (NCursorCol = "001") then -- Iff Rbtn was pressed
                            RedB(0) <= '1';
                            RedA(0) <= '0';
                        end if;
                    when '1' => -- Green Player
                        RedA(0) <= '0';
                        if (NCursorCol = OCursorCol) then
                            GreenA(0) <= '1';
                        elsif (NCursorCol = "111") then
                            GreenH(0) <= '1';
                            GreenA(0) <= '0';
                        elsif (NCursorCol = "001") then
                            GreenB(0) <= '1';
                            GreenA(0) <= '0';
                        end if;
                 end case;
              when "001" => -- column B
                  if (Lbtn = '1') then
                      NCursorCol := "000";
                  elsif (Rbtn = '1') then
                      NCursorCol := "010";
                  elsif (Cbtn = '1') then
                      NCursorCol := OCursorCol;
                      NTurnState <= not(TurnState);

                    for ck in 7 downto 1 loop
                        if (RedB(0) = '1') and (RedB(ck) = '0') and (GreenB(ck) = '0') then
                            RedB(Ck) <= '1';
                            RedB(0) <= '0';
                        EXIT;
                        end if;

                        if (GreenB(0) = '1') and (RedB(ck) = '0') and (GreenB(ck) = '0') then
                            GreenB(Ck) <= '1';
                            GreenB(0) <= '0';
                        EXIT;
                        end if;
                    end loop;
                  end if;
                  
                  case (TurnState) is
                      when '0' =>
                          GreenB(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              RedB(0) <= '1';
                          elsif (NCursorCol = "000") then
                              RedA(0) <= '1';
                              RedB(0) <= '0';
                          elsif (NCursorCol = "010") then
                              RedC(0) <= '1';
                              RedB(0) <= '0';
                          end if;
                      when '1' =>
                          RedB(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              GreenB(0) <= '1';
                          elsif (NCursorCol = "000") then
                              GreenA(0) <= '1';
                              GreenB(0) <= '0';
                          elsif (NCursorCol = "010") then
                              GreenC(0) <= '1';
                              GreenB(0) <= '0';
                          end if;
                    end case;
              when "010" => --Column C

                  if (Lbtn = '1') then
                      NCursorCol := "001";
                  elsif (Rbtn = '1') then
                      NCursorCol := "011";
                  elsif (Cbtn = '1') then
                      NCursorCol := OCursorCol;
                      NTurnState <= not(TurnState);

                    for ck in 7 downto 1 loop
                        if (RedC(0) = '1') and (RedC(ck) = '0') and (GreenC(ck) = '0') then
                            RedC(Ck) <= '1';
                            RedC(0) <= '0';
                        EXIT;
                        end if;

                        if (GreenC(0) = '1') and (RedC(ck) = '0') and (GreenC(ck) = '0') then
                            GreenC(Ck) <= '1';
                            GreenC(0) <= '0';
                        EXIT;
                        end if;
                        
                    end loop;
                  end if;
                  case (TurnState) is
                      when '0' =>
                          GreenC(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              RedC(0) <= '1';
                          elsif (NCursorCol = "001") then
                              RedB(0) <= '1';
                              RedC(0) <= '0';
                          elsif (NCursorCol = "011") then
                              RedD(0) <= '1';
                              RedC(0) <= '0';
                          end if;
                      when '1' =>
                          RedC(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              GreenC(0) <= '1';
                          elsif (NCursorCol = "001") then
                              GreenB(0) <= '1';
                              GreenC(0) <= '0';
                          elsif (NCursorCol = "011") then
                              GreenD(0) <= '1';
                              GreenC(0) <= '0';
                          end if;
                    end case;

              when "011" => -- Column D

                  if (Lbtn = '1') then
                      NCursorCol := "010";
                  elsif (Rbtn = '1') then
                      NCursorCol := "100";
                  elsif (Cbtn = '1') then
                      NCursorCol := OCursorCol;
                      NTurnState <= not(TurnState);

                    for ck in 7 downto 1 loop
                        if (RedD(0) = '1') and (RedD(ck) = '0') and (GreenD(ck) = '0') then
                            RedD(Ck) <= '1';
                            RedD(0) <= '0';
                        EXIT;
                        end if;

                        if (GreenD(0) = '1') and (RedD(ck) = '0') and (GreenD(ck) = '0') then
                            GreenD(Ck) <= '1';
                            GreenD(0) <= '0';
                        EXIT;
                        end if;
                        
                        
                    end loop;
                  end if;
                  case (TurnState) is
                      when '0' =>
                          GreenD(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              RedD(0) <= '1';
                          elsif (NCursorCol = "010") then
                              RedC(0) <= '1';
                              RedD(0) <= '0';
                          elsif (NCursorCol = "100") then
                              RedE(0) <= '1';
                              RedD(0) <= '0';
                          end if;
                      when '1' =>
                          RedD(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              GreenD(0) <= '1';
                          elsif (NCursorCol = "010") then
                              GreenC(0) <= '1';
                              GreenD(0) <= '0';
                          elsif (NCursorCol = "100") then
                              GreenE(0) <= '1';
                              GreenD(0) <= '0';
                          end if;
                    end case;

              when "100" => -- Column E

                  if (Lbtn = '1') then
                      NCursorCol := "011";
                  elsif (Rbtn = '1') then
                      NCursorCol := "101";
                  elsif (Cbtn = '1') then
                      NCursorCol := OCursorCol;
                      NTurnState <= not(TurnState);

                    for ck in 7 downto 1 loop
                        if (RedE(0) = '1') and (RedE(ck) = '0') and (GreenE(ck) = '0') then
                            RedE(Ck) <= '1';
                            RedE(0) <= '0';
                        EXIT;
                        end if;

                        if (GreenE(0) = '1') and (RedE(ck) = '0') and (GreenE(ck) = '0') then
                            GreenE(Ck) <= '1';
                            GreenE(0) <= '0';
                        EXIT;
                        end if;
                        
                        
                    end loop;
                  end if;
                  case (TurnState) is
                      when '0' =>
                          GreenE(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              RedE(0) <= '1';
                          elsif (NCursorCol = "011") then
                              RedD(0) <= '1';
                              RedE(0) <= '0';
                          elsif (NCursorCol = "101") then
                              RedF(0) <= '1';
                              RedE(0) <= '0';
                          end if;
                      when '1' =>
                          RedE(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              GreenE(0) <= '1';
                          elsif (NCursorCol = "011") then
                              GreenD(0) <= '1';
                              GreenE(0) <= '0';
                          elsif (NCursorCol = "101") then
                              GreenF(0) <= '1';
                              GreenE(0) <= '0';
                          end if;
                    end case;

              when "101" => -- Column F

                  if (Lbtn = '1') then
                      NCursorCol := "100";
                  elsif (Rbtn = '1') then
                      NCursorCol := "110";
                  elsif (Cbtn = '1') then
                      NCursorCol := OCursorCol;
                      NTurnState <= not(TurnState);

                    for ck in 7 downto 1 loop
                        if (RedF(0) = '1') and (RedF(ck) = '0') and (GreenF(ck) = '0') then
                            RedF(Ck) <= '1';
                            RedF(0) <= '0';
                        EXIT;
                        end if;

                        if (GreenF(0) = '1') and (RedF(ck) = '0') and (GreenF(ck) = '0') then
                            GreenF(Ck) <= '1';
                            GreenF(0) <= '0';
                        EXIT;
                        end if;
                        
                        
                    end loop;
                  end if;
                  case (TurnState) is
                      when '0' =>
                          GreenF(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              RedF(0) <= '1';
                          elsif (NCursorCol = "100") then
                              RedE(0) <= '1';
                              RedF(0) <= '0';
                          elsif (NCursorCol = "110") then
                              RedG(0) <= '1';
                              RedF(0) <= '0';
                          end if;
                      when '1' =>
                          RedF(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              GreenF(0) <= '1';
                          elsif (NCursorCol = "100") then
                              GreenE(0) <= '1';
                              GreenF(0) <= '0';
                          elsif (NCursorCol = "110") then
                              GreenG(0) <= '1';
                              GreenF(0) <= '0';
                          end if;
                    end case;

              when "110" => -- Column G

                  if (Lbtn = '1') then
                      NCursorCol := "101";
                  elsif (Rbtn = '1') then
                      NCursorCol := "111";
                  elsif (Cbtn = '1') then
                      NCursorCol := OCursorCol;
                      NTurnState <= not(TurnState);
 
                     for ck in 7 downto 1 loop
                          if (RedG(0) = '1') and (RedG(ck) = '0') and (GreenG(ck) = '0') then
                              RedG(Ck) <= '1';
                              RedG(0) <= '0';
                          EXIT;
                          end if;
  
                          if (GreenG(0) = '1') and (RedG(ck) = '0') and (GreenG(ck) = '0') then
                              GreenG(Ck) <= '1';
                              GreenG(0) <= '0';
                          EXIT;
                          end if;
                          
                          
                      end loop;
                  end if;
                  case (TurnState) is
                      when '0' =>
                          GreenG(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              RedG(0) <= '1';
                          elsif (NCursorCol = "101") then
                              RedF(0) <= '1';
                              RedG(0) <= '0';
                          elsif (NCursorCol = "111") then
                              RedH(0) <= '1';
                              RedG(0) <= '0';
                          end if;
                      when '1' =>
                          RedG(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              GreenG(0) <= '1';
                          elsif (NCursorCol = "101") then
                              GreenF(0) <= '1';
                              GreenG(0) <= '0';
                          elsif (NCursorCol = "111") then
                              GreenH(0) <= '1';
                              GreenG(0) <= '0';
                          end if;
                    end case;

              when "111" => -- Column H
                  if (Lbtn = '1') then
                      NCursorCol := "110";
                  elsif (Rbtn = '1') then
                      NCursorCol := "000";
                  elsif (Cbtn = '1') then
                      NCursorCol := OCursorCol;
                      NTurnState <= not(TurnState);

                    for ck in 7 downto 1 loop
                        if (RedH(0) = '1') and (RedH(ck) = '0') and (GreenH(ck) = '0') then
                            RedH(Ck) <= '1';
                            RedH(0) <= '0';
                        EXIT;
                        end if;

                        if (GreenH(0) = '1') and (RedA(ck) = '0') and (GreenA(ck) = '0') then
                            GreenH(Ck) <= '1';
                            GreenH(0) <= '0';
                        EXIT;
                        end if;
                        
                        
                    end loop;
            
                  end if;
                  case (TurnState) is
                      when '0' =>
                          GreenH(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              RedH(0) <= '1';
                          elsif (NCursorCol = "110") then
                              RedG(0) <= '1';
                              RedH(0) <= '0';
                          elsif (NCursorCol = "000") then
                              RedA(0) <= '1';
                              RedH(0) <= '0';
                          end if;
                      when '1' =>
                          RedH(0) <= '0';
                          if (NCursorCol = OCursorCol) then
                              GreenH(0) <= '1';
                          elsif (NCursorCol = "110") then
                              GreenG(0) <= '1';
                              GreenH(0) <= '0';
                          elsif (NCursorCol = "000") then
                              GreenA(0) <= '1';
                              GreenH(0) <= '0';
                          end if;
                    end case;
            end case;
                OCursorCol := NCursorCol;
                TurnState <= NTurnState;

      end if;
end process;

-- Process that Controls LED display matrix
displayRow : process (ColCLK)
    -- 0 - 16 to refesh both the 8X8 RED and 8x8 GREEn matrix
variable RowCount : integer range 0 to 16 := 0;
begin
    if (rising_edge(ColCLK)) then
            if (RowCount = 0) then
            DORow <= RedA; -- Row Data for corresponding Column
            DOCol <= "1000000000000000"; -- Column Trigger
        elsif (RowCount = 1) then
            DORow <= RedB;
            DOCol <= "0100000000000000";
        elsif (RowCount = 2) then
            DORow <= RedC;
            DOCol <= "0010000000000000";
        elsif (RowCount = 3) then
            DORow <= RedD;
            DOCol <= "0001000000000000";
        elsif (RowCount = 4) then
            DORow <= RedE;
            DOCol <= "0000100000000000";
        elsif (RowCount = 5) then
            DORow <= RedF;
            DOCol <= "0000010000000000";
        elsif (RowCount = 6) then
            DORow <= RedG;
            DOCol <= "0000001000000000";
        elsif (RowCount = 7) then
            DORow <= RedH;
            DOCol <= "0000000100000000";
        elsif (RowCount = 8) then
            DORow <= GreenA;
            DOCol <= "0000000010000000";
        elsif (RowCount = 9) then
            DORow <= GreenB;
            DOCol <= "0000000001000000";
        elsif (RowCount = 10) then
            DORow <= GreenC;
            DOCol <= "0000000000100000";
        elsif (RowCount = 11) then
            DORow <= GreenD;
            DOCol <= "0000000000010000";
        elsif (RowCount = 12) then
            DORow <= GreenE;
            DOCol <= "0000000000001000";
        elsif (RowCount = 13) then
            DORow <= GreenF;
            DOCol <= "0000000000000100";
        elsif (RowCount = 14) then
            DORow <= GreenG;
            DOCol <= "0000000000000010";
        elsif (RowCount = 15) then
            DORow <= GreenH;
            DOCol <= "0000000000000001";
        end if;
        if (RowCount = 15) then -- Restart refresh from column A
            RowCount := 0;
        else
            RowCount := RowCount + 1; -- Shift through columns
        end if;
    end if;
end process;
end Behavioral;