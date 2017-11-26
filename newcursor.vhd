
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity newcursor is
    Port ( Ubtn : in STD_LOGIC;
           Dbtn : in STD_LOGIC;
           Lbtn : in STD_LOGIC;
           Rbtn : in STD_LOGIC;
           Mbtn : in STD_LOGIC);
end newcursor;

architecture Behavioral of newcursor is

    signal TurnState : std_logic := '0';
    signal GameState, OCursorCol, NCursorCol : std_logic_vector(2 downto 0) := "000";
    signal R_SMP1_A, R_SMP1_B, R_SMP1_C, R_SMP1_D, R_SMP1_E, R_SMP2_A, R_SMP2_B, R_SMP2_C, R_SMP2_D, R_SMP2_E, R_HMP1_A, R_HMP1_B, R_HMP1_C, R_HMP1_D, R_HMP1_E, R_HMP2_A, R_HMP2_B, R_HMP2_C, R_HMP2_D, R_HMP2_E,
           G_SMP1_A, G_SMP1_B, G_SMP1_C, G_SMP1_D, G_SMP1_E, G_SMP2_A, G_SMP2_B, G_SMP2_C, G_SMP2_D, G_SMP2_E, G_HMP1_A, G_HMP1_B, G_HMP1_C, G_HMP1_D, G_HMP1_E, G_HMP2_A, G_HMP2_B, G_HMP2_C, G_HMP2_D, G_HMP2_E : std_logic_vector(7 downto 0) := "00000000";

    -- Old Cursor Row
    signal OCursorRow : integer := 0;
    -- New Cursor Row
    signal NCursorRow : integer := 0;

begin

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
                            R_SMP1_A(NCursorRow) <= '1';
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
                            R_SMP2_A(NCursorRow) <= '1';
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
                                    R_HMP2_A(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
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

                if rising_edge(Lbtn) then
                    NCursorCol <= "000";
                    NCursorRow <= OCursorRow;
                elsif rising_edge(Rbtn) then
                    NCursorCol <= "010";
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
                            R_SMP1_B(OCursorRow) <= '0';
                            R_SMP1_B(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP1_B(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "010") then
                            R_SMP1_C(NCursorRow) <= '1';
                            R_SMP1_B(OCursorRow) <= '0';
                        elsif (NCursorCol = "000") then
                            R_SMP1_A(NCursorRow) <= '1';
                            R_SMP1_B(OCursorRow) <= '0';
                        end if;
--------------------P2 Setup Phase------------------------------
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_B(OCursorRow) <= '0';
                            R_SMP2_B(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP2_B(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "010") then
                            R_SMP2_C(NCursorRow) <= '1';
                            R_SMP2_B(OCursorRow) <= '0';
                        elsif (NCursorCol = "000") then
                            R_SMP2_A(NCursorRow) <= '1';
                            R_SMP2_B(OCursorRow) <= '0';
                        end if;
-------------------Attack Phase---------------------------------
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_B(OCursorRow) <= '0';
                                    R_HMP1_B(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "010") then
                                    R_HMP1_C(NCursorRow) <= '1';
                                    R_HMP1_B(OCursorRow) <= '0';
                                elsif (NCursorCol = "000") then
                                    R_HMP1_A(NCursorRow) <= '1';
                                    R_HMP1_B(OCursorRow) <= '0';
                                end if;

                            when '1' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP2_B(OCursorRow) <= '0';
                                    R_HMP2_B(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "010") then
                                    R_HMP2_C(NCursorRow) <= '1';
                                    R_HMP2_B(OCursorRow) <= '0';
                                elsif (NCursorCol = "000") then
                                    R_HMP2_A(NCursorRow) <= '1';
                                    R_HMP2_B(OCursorRow) <= '0';
                                end if;
                            end case; -- For TurnState

                        end case; -- For GameState
                OCursorCol <= NCursorCol;
                OCursorRow <= NCursorRow;
----------END FOR COLUMN B----------END FOR COLUMN B----------END FOR COLUMB B----------
            when "010" =>

                if rising_edge(Lbtn) then
                    NCursorCol <= "001";
                    NCursorRow <= OCursorRow;
                elsif rising_edge(Rbtn) then
                    NCursorCol <= "011";
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
                            R_SMP1_C(OCursorRow) <= '0';
                            R_SMP1_C(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP1_C(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "011") then
                            R_SMP1_D(NCursorRow) <= '1';
                            R_SMP1_C(OCursorRow) <= '0';
                        elsif (NCursorCol = "001") then
                            R_SMP1_B(NCursorRow) <= '1';
                            R_SMP1_C(OCursorRow) <= '0';
                        end if;
--------------------P2 Setup Phase------------------------------
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_C(OCursorRow) <= '0';
                            R_SMP2_C(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP2_C(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "011") then
                            R_SMP2_D(NCursorRow) <= '1';
                            R_SMP2_C(OCursorRow) <= '0';
                        elsif (NCursorCol = "001") then
                            R_SMP2_B(NCursorRow) <= '1';
                            R_SMP2_C(OCursorRow) <= '0';
                        end if;
-------------------Attack Phase---------------------------------
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_C(OCursorRow) <= '0';
                                    R_HMP1_C(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "011") then
                                    R_HMP1_D(NCursorRow) <= '1';
                                    R_HMP1_C(OCursorRow) <= '0';
                                elsif (NCursorCol = "001") then
                                    R_HMP1_B(NCursorRow) <= '1';
                                    R_HMP1_C(OCursorRow) <= '0';
                                end if;

                            when '1' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP2_C(OCursorRow) <= '0';
                                    R_HMP2_C(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "011") then
                                    R_HMP2_D(NCursorRow) <= '1';
                                    R_HMP2_C(OCursorRow) <= '0';
                                elsif (NCursorCol = "001") then
                                    R_HMP2_B(NCursorRow) <= '1';
                                    R_HMP2_C(OCursorRow) <= '0';
                                end if;
                            end case; -- For TurnState

                        end case; -- For GameState
                OCursorCol <= NCursorCol;
                OCursorRow <= NCursorRow;
----------END FOR COLUMN C----------END FOR COLUMN C----------END FOR COLUMB C----------
            when "011" =>

                if rising_edge(Lbtn) then
                    NCursorCol <= "010";
                    NCursorRow <= OCursorRow;
                elsif rising_edge(Rbtn) then
                    NCursorCol <= "100";
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
                            R_SMP1_D(OCursorRow) <= '0';
                            R_SMP1_D(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP1_D(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "100") then
                            R_SMP1_E(NCursorRow) <= '1';
                            R_SMP1_D(OCursorRow) <= '0';
                        elsif (NCursorCol = "010") then
                            R_SMP1_C(NCursorRow) <= '1';
                            R_SMP1_D(OCursorRow) <= '0';
                        end if;
--------------------P2 Setup Phase------------------------------
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_D(OCursorRow) <= '0';
                            R_SMP2_D(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP2_D(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "100") then
                            R_SMP2_E(NCursorRow) <= '1';
                            R_SMP2_D(OCursorRow) <= '0';
                        elsif (NCursorCol = "010") then
                            R_SMP2_C(NCursorRow) <= '1';
                            R_SMP2_D(OCursorRow) <= '0';
                        end if;
-------------------Attack Phase---------------------------------
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_D(OCursorRow) <= '0';
                                    R_HMP1_D(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "100") then
                                    R_HMP1_E(NCursorRow) <= '1';
                                    R_HMP1_D(OCursorRow) <= '0';
                                elsif (NCursorCol = "010") then
                                    R_HMP1_C(NCursorRow) <= '1';
                                    R_HMP1_D(OCursorRow) <= '0';
                                end if;

                            when '1' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP2_D(OCursorRow) <= '0';
                                    R_HMP2_D(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "100") then
                                    R_HMP2_E(NCursorRow) <= '1';
                                    R_HMP2_D(OCursorRow) <= '0';
                                elsif (NCursorCol = "010") then
                                    R_HMP2_C(NCursorRow) <= '1';
                                    R_HMP2_D(OCursorRow) <= '0';
                                end if;
                            end case; -- For TurnState

                        end case; -- For GameState
                OCursorCol <= NCursorCol;
                OCursorRow <= NCursorRow; 
----------END FOR COLUMN D----------END FOR COLUMN D----------END FOR COLUMB D----------           
            when "100" =>

                if rising_edge(Lbtn) then
                    NCursorCol <= "011";
                    NCursorRow <= OCursorRow;
                elsif rising_edge(Rbtn) then
                    NCursorCol <= "000";
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
                            R_SMP1_E(OCursorRow) <= '0';
                            R_SMP1_E(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP1_E(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "000") then
                            R_SMP1_A(NCursorRow) <= '1';
                            R_SMP1_E(OCursorRow) <= '0';
                        elsif (NCursorCol = "011") then
                            R_SMP1_D(NCursorRow) <= '1';
                            R_SMP1_E(OCursorRow) <= '0';
                        end if;
--------------------P2 Setup Phase------------------------------
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_E(OCursorRow) <= '0';
                            R_SMP2_E(NCursorRow) <= '1';
                            if rising_edge(Mbtn) then
                                G_SMP2_E(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "000") then
                            R_SMP2_A(NCursorRow) <= '1';
                            R_SMP2_E(OCursorRow) <= '0';
                        elsif (NCursorCol = "010") then
                            R_SMP2_D(NCursorRow) <= '1';
                            R_SMP2_E(OCursorRow) <= '0';
                        end if;
-------------------Attack Phase---------------------------------
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_E(OCursorRow) <= '0';
                                    R_HMP1_E(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "000") then
                                    R_HMP1_A(NCursorRow) <= '1';
                                    R_HMP1_E(OCursorRow) <= '0';
                                elsif (NCursorCol = "011") then
                                    R_HMP1_D(NCursorRow) <= '1';
                                    R_HMP1_E(OCursorRow) <= '0';
                                end if;

                            when '1' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP2_E(OCursorRow) <= '0';
                                    R_HMP2_E(NCursorRow) <= '1';
                                    if rising_edge(Mbtn) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "000") then
                                    R_HMP2_A(NCursorRow) <= '1';
                                    R_HMP2_E(OCursorRow) <= '0';
                                elsif (NCursorCol = "011") then
                                    R_HMP2_D(NCursorRow) <= '1';
                                    R_HMP2_E(OCursorRow) <= '0';
                                end if;
                            end case; -- For TurnState

                        end case; -- For GameState
                OCursorCol <= NCursorCol;
                OCursorRow <= NCursorRow; 

        end case;
end process;
end Behavioral;