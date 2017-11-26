-- Old Cursor Row
variable OCursorRow : integer := 0;
-- New Cursor Row
variable NCursowRow : integer := 0;

process (Ubtn, Dbtn, Lbtn, Rbtn, Mbtn)
    begin
        case (OCursorCol) is
            when "000" =>
                if rising_edge(Lbtn) then
                    NCursorCol <= "100";
                    NCursorRow <= OCursorRow;
                elsif rising_edge(Rbtn) then
                    NCursorCol <= "001";
                    NCursorRow <= OCursorRow;
                elsif rising_edge(Ubtn) then
                    if (OCursorRow = 7) then
                        NCursorRow <= 0;
                    else
                        NCursorRow <= OCursorRow + 1;
                    end if;
                    NCursorCol <= OCursorCol;
                elsif rising_edge(Dbtn) then
                    if (OCursorRow = 0) then
                        NCursorRow <= 7;
                    else
                        NCursorRow <= OCursorRow - 1;
                    end if;
                    NCursorCol <= OCursorCol;
                end if;
                case GameState is
--------------------P1 Setup Phase-----------------------------
                    when "001" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP1_A(OCursorRow) <= '0';
                            R_SMP1_A(NCursorRow) <= '1'
                            if rising_edge(Mbtn) then
                                G_SMP1_A(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "001") then
                            R_SMP1_B(NCursorRow) <= '1';
                            R_SMP1_A(OCursorRow) <= '0';
                        elsif (NCursorCol = "100") then
                            R_SMP1_E(NCursorRow) <= '1';
                            R_SMP1_A(OCursorRow) <= '0';
                        end if;
--------------------P2 Setup Phase------------------------------
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_A(OCursorRow) <= '0';
                            R_SMP2_A(NCursorRow) <= '1'
                            if rising_edge(Mbtn) then
                                G_SMP2_A(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "001") then
                            R_SMP2_B(NCursorRow) <= '1';
                            R_SMP2_A(OCursorRow) <= '0';
                        elsif (NCursorCol = "100") then
                            R_SMP2_E(NCursorRow) <= '1';
                            R_SMP2_A(OCursorRow) <= '0';
                        end if;
-------------------Attack Phase---------------------------------
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_A(OCursorRow) <= '0';
                                    R_HMP1_A(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        NCursorRow <= '0';
                                        NCursorCol <= "000";
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "001") then
                                    R_HMP1_B(NCursorRow) <= '1';
                                    R_HMP1_A(OCursorRow) <= '0';
                                elsif (NCursorCol = "100") then
                                    R_HMP1_E(NCursorRow) <= '1';
                                    R_HMP1_A(OCursorRow) <= '0';
                                end if;

                            when '1' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP2_A(OCursorRow) <= '0';
                                    R_HMP2_A(NCursorRow) <= '1'
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        NCursorRow <= '0';
                                        NCursorCol <= "000";
                                        TurnState <= not(TurnState)
                                    end if;
                                elsif (NCursorCol = "001") then
                                    R_HMP2_B(NCursorRow) <= '1';
                                    R_HMP2_A(OCursorRow) <= '0';
                                elsif (NCursorCol = "100") then
                                    R_HMP2_E(NCursorRow) <= '1';
                                    R_HMP2_A(OCursorRow) <= '0';
                                end if;
                            end case; -- For TurnState

                        end case; -- For GameState
                OCursorCol <= NCursorCol;
                OCursorRow <= NCursorRow;
----------END FOR COLUMN A----------END FOR COLUMN A----------END FOR COLUMB A----------
            when "001" =>
            when "010" =>
            when "011" =>
            when "100" =>
