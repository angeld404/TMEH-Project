ibrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Battleship is
    Port ( Ubtn : in STD_LOGIC;
           Dbtn : in STD_LOGIC;
           Lbtn : in STD_LOGIC;
           Rbtn : in STD_LOGIC;
           Mbtn : in STD_LOGIC;
           Gamestate : in STD_LOGIC_VECTOR(2 downto 0);
           CLK  : in STD_LOGIC;


           RowCLK : out STD_LOGIC;
           DataOutRow : out STD_LOGIC;
           LatchOutRow : out STD_LOGIC;

           ColCLK : out STD_LOGIC;
           DataOutCol : out STD_LOGIC;
           LatchOutCol : out STD_LOGIC
           );
end Battleship;

architecture Behavioral of Battleship is

    signal TurnState : std_logic := '0';


    signal CLK : std_logic := '0';

    signal RowCLK : std_logic := '0';
    signal DataOutRow : std_logic := '0';
    signal LatchOutRow : std_logic := '0';

    signal ColCLK : std_logic := '0';
    signal DataOutCol : std_logic := '0';
    signal LatchOutCol : std_logic := '0';


    variable R_SMP1_A, R_SMP1_B, R_SMP1_C, R_SMP1_D, R_SMP1_E, R_SMP2_A, R_SMP2_B, R_SMP2_C, R_SMP2_D, R_SMP2_E, R_HMP1_A, R_HMP1_B, R_HMP1_C, R_HMP1_D, R_HMP1_E, R_HMP2_A, R_HMP2_B, R_HMP2_C, R_HMP2_D, R_HMP2_E,
    G_SMP1_A, G_SMP1_B, G_SMP1_C, G_SMP1_D, G_SMP1_E, G_SMP2_A, G_SMP2_B, G_SMP2_C, G_SMP2_D, G_SMP2_E, G_HMP1_A, G_HMP1_B, G_HMP1_C, G_HMP1_D, G_HMP1_E, G_HMP2_A, G_HMP2_B, G_HMP2_C, G_HMP2_D, G_HMP2_E : unsigned (7 downto 0) := "00000000";
    variable OCursorRow : integer range 0 to 8  := 0;
    variable NCursorRow : integer range 0 to 8  := 0;
    variable OCursorCol : unsigned (2 downto 0) := "000";
    variable NCursorCol : unsigned (2 downto 0) := "000";




begin


Gamestate : process (GameState)
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

cursor : process (CLK, Ubtn, Dbtn, Lbtn, Rbtn, Mbtn)
    begin
    if rising_edge(CLK) then
        case (OCursorCol) is
            when "000" =>
                if (Lbtn = 1) then
                    NCursorCol := "100";
                    NCursorRow := OCursorRow;
                elsif (Rbtn = 1) then
                    NCursorCol := "001";
                    NCursorRow := OCursorRow;
                elsif (Ubtn = 1) then
                    if (OCursorRow = 7) then
                        NCursorRow := 0;
                    else
                        NCursorRow := OCursorRow + 1;
                    end if;
                    NCursorCol <= OCursorCol;
                elsif (Dbtn = 1) then
                    if (OCursorRow = 0) then
                        NCursorRow := 7;
                    else
                        NCursorRow := OCursorRow - 1;
                    end if;
                    NCursorCol := OCursorCol;
                end if;
                case GameState is
                    when "001" => -- P1 Setup Phase
                        if (OCursorCol = NCursorCol) then
                            R_SMP1_A(OCursorRow) := '0';
                            R_SMP1_A(NCursorRow) := '1';
                            if (Mbtn = 1) then
                                G_SMP1_A(NCursorRow) := '1';
                            end if;
                        elsif (NCursorCol = "001") then
                            R_SMP1_B(NCursorRow) := '1';
                            R_SMP1_A(OCursorRow) := '0';
                        elsif (NCursorCol = "100") then
                            R_SMP1_E(NCursorRow) := '1';
                            R_SMP1_A(OCursorRow) := '0';
                        end if;
                    when "011" => -- P2 Setup Phase
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_A(OCursorRow) := '0';
                            R_SMP2_A(NCursorRow) := '1';
                            if (Mbtn = 1) then
                                G_SMP2_A(NCursorRow) := '1';
                            end if;
                        elsif (NCursorCol = "001") then
                            R_SMP2_B(NCursorRow) := '1';
                            R_SMP2_A(OCursorRow) := '0';
                        elsif (NCursorCol = "100") then
                            R_SMP2_E(NCursorRow) := '1';
                            R_SMP2_A(OCursorRow) := '0';
                        end if;
                    when "111" => -- Attack Phase
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_A(OCursorRow) := '0';
                                    R_HMP1_A(NCursorRow) := '1';
                                    if (Mbtn = 1) then
                                        -- Will trigger the Check Process
                                        TurnState <= not(TurnState);
                                    end if;
                                elsif (NCursorCol = "001") then
                                    R_HMP1_B(NCursorRow) := '1';
                                    R_HMP1_A(OCursorRow) := '0';
                                elsif (NCursorCol = "100") then
                                    R_HMP1_E(NCursorRow) := '1';
                                    R_HMP1_A(OCursorRow) := '0';
                                end if;

                            when '1' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP2_A(OCursorRow) <= '0';
                                    R_HMP2_A(NCursorRow) <= '1';
                                    if (Mbtn = 1) then
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
                    end case; -- GameState
                OCursorCol <= NCursorCol;
                OCursorRow <= NCursorRow; -- END COLUMN A
            when "001" =>

                if (Lbtn = 1) then
                    NCursorCol <= "000";
                    NCursorRow <= OCursorRow;
                elsif (Rbtn = 1) then
                    NCursorCol <= "010";
                    NCursorRow <= OCursorRow;
                elsif (Ubtn = 1) then
                    if (OCursorRow = 7) then
                        NCursorRow <= 0;
                    else
                        NCursorRow <= OCursorRow + 1;
                    end if;
                    NCursorCol <= OCursorCol;
                elsif (Dbtn = 1) then
                    if (OCursorRow = 0) then
                        NCursorRow <= 7;
                    else
                        NCursorRow <= OCursorRow - 1;
                    end if;
                    NCursorCol <= OCursorCol;
                end if;
                case GameState is
                    when "001" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP1_B(OCursorRow) <= '0';
                            R_SMP1_B(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP1_B(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "010") then
                            R_SMP1_C(NCursorRow) <= '1';
                            R_SMP1_B(OCursorRow) <= '0';
                        elsif (NCursorCol = "000") then
                            R_SMP1_A(NCursorRow) <= '1';
                            R_SMP1_B(OCursorRow) <= '0';
                        end if;
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_B(OCursorRow) <= '0';
                            R_SMP2_B(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP2_B(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "010") then
                            R_SMP2_C(NCursorRow) <= '1';
                            R_SMP2_B(OCursorRow) <= '0';
                        elsif (NCursorCol = "000") then
                            R_SMP2_A(NCursorRow) <= '1';
                            R_SMP2_B(OCursorRow) <= '0';
                        end if;
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_B(OCursorRow) <= '0';
                                    R_HMP1_B(NCursorRow) <= '1';
                                    if (Mbtn = 1) then
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
                                    if (Mbtn = 1) then
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
            when "010" =>
                if (Lbtn = 1) then
                    NCursorCol <= "001";
                    NCursorRow <= OCursorRow;
                elsif (Rbtn = 1) then
                    NCursorCol <= "011";
                    NCursorRow <= OCursorRow;
                elsif (Ubtn = 1) then
                    if (OCursorRow = 7) then
                        NCursorRow <= 0;
                    else
                        NCursorRow <= OCursorRow + 1;
                    end if;
                    NCursorCol <= OCursorCol;
                elsif (Dbtn = 1) then
                    if (OCursorRow = 0) then
                        NCursorRow <= 7;
                    else
                        NCursorRow <= OCursorRow - 1;
                    end if;
                    NCursorCol <= OCursorCol;
                end if;
                case GameState is
                    when "001" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP1_C(OCursorRow) <= '0';
                            R_SMP1_C(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP1_C(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "011") then
                            R_SMP1_D(NCursorRow) <= '1';
                            R_SMP1_C(OCursorRow) <= '0';
                        elsif (NCursorCol = "001") then
                            R_SMP1_B(NCursorRow) <= '1';
                            R_SMP1_C(OCursorRow) <= '0';
                        end if;
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_C(OCursorRow) <= '0';
                            R_SMP2_C(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP2_C(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "011") then
                            R_SMP2_D(NCursorRow) <= '1';
                            R_SMP2_C(OCursorRow) <= '0';
                        elsif (NCursorCol = "001") then
                            R_SMP2_B(NCursorRow) <= '1';
                            R_SMP2_C(OCursorRow) <= '0';
                        end if;
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_C(OCursorRow) <= '0';
                                    R_HMP1_C(NCursorRow) <= '1';
                                    if (Mbtn = 1) then
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
                                    if (Mbtn = 1) then
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
            when "011" =>

                if (Lbtn = 1) then
                    NCursorCol <= "010";
                    NCursorRow <= OCursorRow;
                elsif (Rbtn = 1) then
                    NCursorCol <= "100";
                    NCursorRow <= OCursorRow;
                elsif (Ubtn = 1) then
                    if (OCursorRow = 7) then
                        NCursorRow <= 0;
                    else
                        NCursorRow <= OCursorRow + 1;
                    end if;
                    NCursorCol <= OCursorCol;
                elsif (Dbtn = 1) then
                    if (OCursorRow = 0) then
                        NCursorRow <= 7;
                    else
                        NCursorRow <= OCursorRow - 1;
                    end if;
                    NCursorCol <= OCursorCol;
                end if;
                case GameState is
                    when "001" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP1_D(OCursorRow) <= '0';
                            R_SMP1_D(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP1_D(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "100") then
                            R_SMP1_E(NCursorRow) <= '1';
                            R_SMP1_D(OCursorRow) <= '0';
                        elsif (NCursorCol = "010") then
                            R_SMP1_C(NCursorRow) <= '1';
                            R_SMP1_D(OCursorRow) <= '0';
                        end if;
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_D(OCursorRow) <= '0';
                            R_SMP2_D(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP2_D(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "100") then
                            R_SMP2_E(NCursorRow) <= '1';
                            R_SMP2_D(OCursorRow) <= '0';
                        elsif (NCursorCol = "010") then
                            R_SMP2_C(NCursorRow) <= '1';
                            R_SMP2_D(OCursorRow) <= '0';
                        end if;
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_D(OCursorRow) <= '0';
                                    R_HMP1_D(NCursorRow) <= '1';
                                    if (Mbtn = 1) then
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
                                    if (Mbtn = 1) then
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
            when "100" =>

                if (Lbtn = 1) then
                    NCursorCol <= "011";
                    NCursorRow <= OCursorRow;
                elsif (Rbtn = 1) then
                    NCursorCol <= "000";
                    NCursorRow <= OCursorRow;
                elsif (Ubtn = 1) then
                    if (OCursorRow = 7) then
                        NCursorRow <= 0;
                    else
                        NCursorRow <= OCursorRow + 1;
                    end if;
                    NCursorCol <= OCursorCol;
                elsif (Dbtn = 1) then
                    if (OCursorRow = 0) then
                        NCursorRow <= 7;
                    else
                        NCursorRow <= OCursorRow - 1;
                    end if;
                    NCursorCol <= OCursorCol;
                end if;
                case GameState is
                    when "001" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP1_E(OCursorRow) <= '0';
                            R_SMP1_E(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP1_E(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "000") then
                            R_SMP1_A(NCursorRow) <= '1';
                            R_SMP1_E(OCursorRow) <= '0';
                        elsif (NCursorCol = "011") then
                            R_SMP1_D(NCursorRow) <= '1';
                            R_SMP1_E(OCursorRow) <= '0';
                        end if;
                    when "011" =>
                        if (OCursorCol = NCursorCol) then
                            R_SMP2_E(OCursorRow) <= '0';
                            R_SMP2_E(NCursorRow) <= '1';
                            if (Mbtn = 1) then
                                G_SMP2_E(NCursorRow) <= '1';
                            end if;
                        elsif (NCursorCol = "000") then
                            R_SMP2_A(NCursorRow) <= '1';
                            R_SMP2_E(OCursorRow) <= '0';
                        elsif (NCursorCol = "010") then
                            R_SMP2_D(NCursorRow) <= '1';
                            R_SMP2_E(OCursorRow) <= '0';
                        end if;
                    when "111" =>
                        case (TurnState) is
                            when '0' =>
                                if (OCursorCol = NCursorCol) then
                                    R_HMP1_E(OCursorRow) <= '0';
                                    R_HMP1_E(NCursorRow) <= '1';
                                    if (Mbtn = 1) then
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
                                    if (Mbtn = 1) then
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
    end if;
end process;

check : process (TurnState)
  begin
    for ck1 in range 0 to 7 loop
        if (R_HMP1_A(x) = G_SMP2_A(x)) then
        -- Turn the ships on opponent red (AKA turn off green turn on red)
            G_SMP2_A(x) <= '0';
            R_SMP2_A(x) <= '1';
            R_HMP1_A(x) <= '0';
            G_HMP1_A(x) <= '1';
        end if;

        if (R_HMP1_B(x) = G_SMP2_B(x)) then
        -- Turn the ships on opponent red (AKA turn off green turn on red)
            G_SMP2_B(x) <= '0';
            R_SMP2_B(x) <= '1';
            R_HMP1_B(x) <= '0';
            G_HMP1_B(x) <= '1';
        end if;

        if (R_HMP1_C(x) = G_SMP2_C(x)) then
        -- Turn the ships on opponent red (AKA turn off green turn on red)
            G_SMP2_C(x) <= '0';
            R_SMP2_C(x) <= '1';
            R_HMP1_C(x) <= '0';
            G_HMP1_C(x) <= '1';
        end if;

        if (R_HMP1_D(x) = G_SMP2_D(x)) then
        -- Turn the ships on opponent red (AKA turn off green turn on red)
            G_SMP2_D(x) <= '0';
            R_SMP2_D(x) <= '1';
            R_HMP1_D(x) <= '0';
            G_HMP1_D(x) <= '1';
        end if;

        if (R_HMP1_E(x) = G_SMP2_E(x)) then
        -- Turn the ships on opponent red (AKA turn off green turn on red)
            G_SMP2_E(x) <= '0';
            R_SMP2_E(x) <= '1';
            R_HMP1_E(x) <= '0';
            G_HMP1_E(x) <= '1';
        end if;

        if (R_HMP2_A(x) = G_SMP1_A(x)) then
          G_SMP1_A(x) <= '0';
          R_SMP1_A(x) <= '1';
          R_HMP2_A(x) <= '0';
          G_HMP2_A(x) <= '1';
        end if;

        if (R_HMP2_B(x) = G_SMP1_B(x)) then
          G_SMP1_B(x) <= '0';
          R_SMP1_B(x) <= '1';
          R_HMP2_B(x) <= '0';
          G_HMP2_B(x) <= '1';
        end if;

        if (R_HMP2_B(x) = G_SMP1_C(x)) then
          G_SMP1_C(x) <= '0';
          R_SMP1_C(x) <= '1';
          R_HMP2_C(x) <= '0';
          G_HMP2_C(x) <= '1';
        end if;

        if (R_HMP2_C(x) = G_SMP1_D(x)) then
          G_SMP1_D(x) <= '0';
          R_SMP1_D(x) <= '1';
          R_HMP2_D(x) <= '0';
          G_HMP2_D(x) <= '1';
        end if;

        if (R_HMP2_A(x) = G_SMP1_E(x)) then
          G_SMP1_E(x) <= '0';
          R_SMP1_E(x) <= '1';
          R_HMP2_E(x) <= '0';
          G_HMP2_E(x) <= '1';
        end if;
    end loop;
end process;

CLKDivider : process (CLK)
    variable clkcount : integer range 0 to 52083 := 0;
    begin
        if (rising_edge(CLK)) then
            clkcount := clkcount + 1;
            if (clkcount = 52083) then
                RowCLK <= not(RowCLK);
                clkcount := 0;
            end if;
        end if;
end process;

displayRow : process (RowCLK)
    variable RowCountA, RowCountB, RowCountC, RowCountD, RowCountE : integer range 0 to 8  := 0;
    variable OScreen  : unsigned (2 downto 0) := "000";
    variable NScreen  : unsigned (2 downto 0) := "000";

    begin
        if (rising_edge(RowCLK)) then
            case (OScreen) is =>
    -----------RED   - SHIP MAP - PLAYER 1
                when "000" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= R_SMP1_E(RowCountE);
                                        NScreen := "001";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= R_SMP1_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= R_SMP1_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= R_SMP1_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= R_SMP1_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= R_SMP1_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
    -----------RED   - HIT MAP  - PLAYER 1
                when "001" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= R_HMP1_E(RowCountE);
                                        NScreen := "010";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= R_HMP1_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= R_HMP1_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= R_HMP1_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= R_HMP1_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= R_HMP1_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
    -----------RED   - SHIP MAP - PLAYER 2
                when "010" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= R_SMP2_E(RowCountE);
                                        NScreen := "011";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= R_SMP2_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= R_SMP2_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= R_SMP2_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= R_SMP2_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= R_SMP2_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
    -----------RED   - HIT MAP  - PLAYER 2
                when "011" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= R_HMP2_E(RowCountE);
                                        NScreen := "100";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= R_HMP2_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= R_HMP2_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= R_HMP2_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= R_HMP2_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= R_HMP2_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
    -----------GREEN - SHIP MAP - PLAYER 1
                when "100" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= G_SMP1_E(RowCountE);
                                        NScreen := "101";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= G_SMP1_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= G_SMP1_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= G_SMP1_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= G_SMP1_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= G_SMP1_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
    -----------GREEN - HIT MAP  - PLAYER 1
                when "101" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= G_HMP1_E(RowCountE);
                                        NScreen := "110";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= G_HMP1_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= G_HMP1_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= G_HMP1_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= G_HMP1_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= G_HMP1_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
    -----------GREEN - SHIP MAP - PLAYER 2
                when "110" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= G_SMP2_E(RowCountE);
                                        NScreen := "111";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= G_SMP2_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= G_SMP2_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= G_SMP2_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= G_SMP2_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= G_SMP2_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
    -----------GREEN - HIT MAP  - PLAYER 2
                when "111" =>
                    if (RowCountA = 8) then
                        -- Output Clock goes high
                        if (RowCountB = 8) then
                            -- Output Clock Goes High
                            if (RowCountC = 8) then
                                -- Output Clock Goes High
                                if (RowCountD = 8) then
                                    -- Output Clock Goes High
                                    if (RowCountE = 7) then
                                        -- Output Clock Goes High
                                        DataOutRow <= G_HMP2_E(RowCountE);
                                        NScreen := "000";
                                        RowCountA := 0;
                                        RowCountB := 0;
                                        RowCountC := 0;
                                        RowCountD := 0;
                                        RowCountE := 0;
                                    else
                                        DataOutRow <= G_HMP2_E(RowCountE);
                                        RowCountE := RowCountE + RowCountE + 1;
                                    end if;
                                else
                                    DataOutRow <= G_HMP2_D(RowCountD);
                                    RowCountD := RowCountD + RowCountD + 1;
                                end if;
                            else
                                DataOutRow <= G_HMP2_C(RowCountC);
                                RowCountC := RowCountC + RowCountC + 1;
                            end if;
                        else
                            DataOutRow <= G_HMP2_B(RowCountB);
                            RowCountB := RowCountB + RowCountB + 1;
                        end if;
                    else
                        DataOutRow <= G_HMP2_A(RowCountA);
                        RowCountA := RowCountA + RowCountA;
                    end if;
                    OScreen := NScreen;
                end case;
    -----------Latch Out Code -- Triggers every 8 counts [0,7]
                if (RowCount1 = 7) then
                    LatchOutRow <= 1;
                    RowCount1 := 0;
                else
                    LatchOutRow <= 0;
                    RowCount1 := RowCount1 + 1;
                end if;
        end if;
end process;

displayCol : process (RowCLK)
    variable ColCount : integer range 0 to 8  := 0;
    variable RowCount : integer range 0 to 8  := 0;
    begin
        if ((RowCLK)) then
            if (RowCount2 = 7) then
                ColCLK <= '1';
                    if (ColCount = 40) then
                        DataOutCol <= '1';
                        ColCount := 0;
                    else
                        DataOutCol <= '0';
                        ColCount := ColCount + 1;
                    end if;
                LatchOutCol <= 1;
                RowCount2 := 0;
            else
                LatchOutCol <= 0;
                ColCLK <= '0';
                RowCount2 := RowCount + 1;
            end if;
        end if;
end process;

end Behavioral;
