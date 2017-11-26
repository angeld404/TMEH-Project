process (Ubtn, Dbtn, Lbtn, Rbtn)
    begin
        case (CursorCol) is
            when "000" =>
                if rising_edge(Lbtn) then
                    NCursorCol <= "101";
                end if;

                if rising_edge(Rbtn) then
                    NCursorCol <= "001";
                end if;
                case (CursorRow) is
                    when "000" =>
                    -- Coord (A,0)
                        case (GameState) is
                            -- P1 Setup Phase
                            when "001" =>
                                R_SMP1_A(0) <= '1';
                                if rising_edge(Ubtn) then
                                    NCursorRow <= "111";
                                    R_SMP1_A(0) <= '0';
                                end if;

                                if rising_edge(Dbtn) then
                                    NCursorRow <= "001";
                                    R_SMP1_A(0) <= '0';
                                end if;

                                if rising_edge(Mbtn) then
                                    G_SMP1_A(0) <= '1';
                                end if;
                            -- P2 Setup Phase
                            when "011" =>
                                R_SMP2_A(0) <= '1';
                                if rising_edge(Ubtn) then
                                    NCursorRow <= "111";
                                    R_SMP2_A(0);
                                end if;

                                if rising_edge(Dbtn) then
                                    NCursorRow <= "001";
                                    R_SMP2_A(0) <= '0';
                                end if;

                                if rising_edge(Mbtn) then
                                    G_SMP2_A(0) <= '1';
                                end if;

                            -- Attack Phase
                            when "111" =>
                                case (TurnState) is
                                    -- P1 AttackPhase
                                    when '0' =>
                                        R_HMP1_A(0) <= '1';
                                        if rising_edge(Ubtn) then
                                            NCursorRow <= "111";
                                            R_HMP1_A(0) <= '0';
                                        end if;

                                        if rising_edge(Dbtn) then
                                            NCursorRow <= "001";
                                            R_HMP1_A(0) <= '0';
                                        end if;

                                        if rising_edge(MBtn) then
                                            -- Will also trigger the check process
                                            TurnState <= not(TurnState);
                                        end if;
                                    when '1' =>
                                        R_HMP2_A(0) <= '1';
                                        if rising_edge(Ubtn) then
                                            NCursorRow <= "111";
                                            R_HMP2_A(0) <= '0';
                                        end if;

                                        if rising_edge(Dbtn) then
                                            NCursorRow <= "001";
                                            R_HMP2_A(0) <= '0';
                                        end if;

                                        if rising_edge(MBtn) then
                                            -- Will also trigger the check process
                                            TurnState <= not(TurnState);
                                        end if;


                  when "001
                  "

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
