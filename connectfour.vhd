library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity connectfour is
    Port ( Lbtn : in STD_LOGIC;
           Rbtn : in STD_LOGIC;
           Mbtn : in STD_LOGIC;
           CLK  : in STD_LOGIC;


           RowCLK : out STD_LOGIC;
           DORow : out STD_LOGIC;
           LORow : out STD_LOGIC;

           ColCLK : out STD_LOGIC;
           DOCol : out STD_LOGIC;
           LOCol : out STD_LOGIC
           );
end connectfour;

architecture Behavioral of connectfour is

    signal TurnState : std_logic := '0';


begin

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

cursor : process (CLK)
    variable OCursorCol : STD_LOGIC_VECTOR (2 downto 0) := "000";
    variable NCursorCol : STD_LOGIC_VECTOR (2 downto 0) := "000";

    begin
    if (rising_edge(CLK)) then
        case (OCursorCol) is
            when "000" =>
                if (LBTN = 1) then
                    NCursorCol := "111";
                elsif (RBTN = 1) then
                    NCursorCol := "001";
                elsif (MBTN = 1) then
                    NCursorCol := OCursorCol
                    TurnState <= not(TurnState);
                end if;
                case (TurnState) is
                    when '0' =>
                        if (NCursorCol = OCursorCol) then
                            RedA(0) := '1';
                        elsif (NCursorCol = "111") then
                            RedF(0) := '1';
                            RedA(0) := '0';
                        elsif (NCursorCol = "001") then
                            RedB(0) := '1';
                            RedA(0) := '0';
                        end if;
                    when '1' =>
                        if (NCursorCol = OCursorCol) then
                            GreenA(0) := '1';
                        elsif (NCursorCol = "111") then
                            GreenF(0) := '1';
                            GreenA(0) := '0';
                        elsif (NCursorCol = "001") then
                            GreenB(0) := '1';
                            GreenA(0) := '0';
                        end if;
                  end case;
                  OCursorCol := NCursorCol;
              when "001" =>
              when "010" =>
              when "011" =>
              when "100" =>
              when "101" =>
              when "110" =>
              when "111" =>





            end case;




      end if;
end process;

check : process (TurnState)
  begin
    for ck in range 7 downto 1 loop
        if (RedA(0) = 1) and (RedA(Ck) = 0) then
            RedA(Ck) = 1;
            EXIT;
        end if;

        if (RedB(0) = 1) and (RedB(Ck) = 0) then
            RedB(Ck) = 1;
            EXIT;
        end if;

        if (RedC(0) = 1) and (RedC(Ck) = 0) then
            RedC(Ck) = 1;
            EXIT;
        end if;

        if (RedD(0) = 1) and (RedD(Ck) = 0) then
            RedD(Ck) = 1;
            EXIT;
        end if;

        if (RedE(0) = 1) and (RedE(Ck) = 0) then
            RedE(Ck) = 1;
            EXIT;
        end if;

        if (RedF(0) = 1) and (RedF(Ck) = 0) then
            RedF(Ck) = 1;
            EXIT;
        end if;

        if (RedG(0) = 1) and (RedG(Ck) = 0) then
            RedG(Ck) = 1;
            EXIT;
        end if;

        if (RedH(0) = 1) and (RedH(Ck) = 0) then
            RedH(Ck) = 1;
            EXIT;
        end if;

        if (GreenA(0) = 1) and (GreenA(Ck) = 0) then
            GreenA(Ck) = 1;
            EXIT;
        end if;

        if (GreenB(0) = 1) and (GreenB(Ck) = 0) then
            GreenB(Ck) = 1;
            EXIT;
        end if;

        if (GreenC(0) = 1) and (GreenC(Ck) = 0) then
            GreenC(Ck) = 1;
            EXIT;
        end if;

        if (GreenD(0) = 1) and (GreenD(Ck) = 0) then
            GreenD(Ck) = 1;
            EXIT;
        end if;

        if (GreenE(0) = 1) and (GreenE(Ck) = 0) then
            RedE(Ck) = 1;
            EXIT;
        end if;

        if (GreenF(0) = 1) and (GreenF(Ck) = 0) then
            RedF(Ck) = 1;
            EXIT;
        end if;

        if (GreenG(0) = 1) and (GreenG(Ck) = 0) then
            GreenG(Ck) = 1;
            EXIT;
        end if;

        if (GreenH(0) = 1) and (GreenH(Ck) = 0) then
            GreenH(Ck) = 1;
            EXIT;
        end if;
    end loop;
end process;

displayRow : process (RowCLK)
    variable RowA, RowB, RowC, RowD, RowE, RowF, RowG, RowH, RowCount : integer range 0 to 8 := 0;
    variable OScreen : STD_LOGIC := '0';
    variable NScreen : STD_LOGIC := '0';

    begin
        if (rising_edge(RowCLK)) then
            case (OScreen) is
                when '0' =>
                    if (RowA = 8) then
                        if (RowB = 8) then
                            if (RowC = 8) then
                                if (RowD = 8) then
                                    if (RowE = 8) then
                                        if (RowF = 8) then
                                            if (RowG = 8) then
                                                if (RowH = 7) then
                                                    DORow <= RedH(RowH)
                                                    NScreen := '1';
                                                    RowA := 0;
                                                    RowB := 0;
                                                    RowC := 0;
                                                    RowD := 0;
                                                    RowE := 0;
                                                    RowF := 0;
                                                    RowG := 0;
                                                    RowH := 0;
                                                else
                                                    DORow <= RedH(RowH)
                                                    RowE := RowE + 1;
                                                end if;
                                            else
                                                DORow <= RedG(RowG)
                                                RowG := RowG + 1;
                                            end if;
                                        else
                                            DORow <= RedF(RowF)
                                            RowF := RowF + 1;
                                        end if;
                                    else
                                        DORow <= RedE(RowE)
                                        RowE := RowE + 1;
                                    end if;
                                else
                                    DORow <= RedD(RowD)
                                    RowD := RowD + 1;
                                end if;
                            else
                                DORow <= RedC(RowC)
                                RowC := RowC + 1;
                            end if;
                        else
                            DORow <= RedB(RowB)
                            RowB := RowB + 1;
                        end if;
                    else
                        DORow <= RedA(RowA)
                        RowA := RowA + 1;
                    end if;
                when '1' =>
                    if (RowA = 8) then
                        if (RowB = 8) then
                            if (RowC = 8) then
                                if (RowD = 8) then
                                    if (RowE = 8) then
                                        if (RowF = 8) then
                                            if (RowG = 8) then
                                                if (RowH = 7) then
                                                    DORow <= GreenH(RowH)
                                                    NScreen := '1';
                                                    RowA := 0;
                                                    RowB := 0;
                                                    RowC := 0;
                                                    RowD := 0;
                                                    RowE := 0;
                                                    RowF := 0;
                                                    RowG := 0;
                                                    RowH := 0;
                                                else
                                                    DORow <= GreenH(RowH)
                                                    RowE := RowE + 1;
                                                end if;
                                            else
                                                DORow <= GreenG(RowG)
                                                RowG := RowG + 1;
                                            end if;
                                        else
                                            DORow <= GreenF(RowF)
                                            RowF := RowF + 1;
                                        end if;
                                    else
                                        DORow <= GreenE(RowE)
                                        RowE := RowE + 1;
                                    end if;
                                else
                                    DORow <= GreenD(RowD)
                                    RowD := RowD + 1;
                                end if;
                            else
                                DORow <= GreenC(RowC)
                                RowC := RowC + 1;
                            end if;
                        else
                            DORow <= GreenB(RowB)
                            RowB := RowB + 1;
                        end if;
                    else
                        DORow <= GreenA(RowA)
                        RowA := RowA + 1;
                    end if;
                end case;

                if (RowCount = 7) then
                    LORow <= 1;
                    RowCount := 0;
                else
                    LORow <= 0;
                    RowCount := RowCount + 1;
                end if;



            end if;
end process;

displayCol : process (RowCLK)
    variable LatchCount, ColCount : integer range 0 to 8 := 0;
    begin
        if (rising_edge(RowCLK)) then
            if (LatchCount = 7) then
                ColCLK <= '1';
                    if (ColCount = 8) then
                        DOCol <= '1';
                        ColCount := 0;
                    else
                        DOCol <= '0';
                        ColCount := ColCount + 1;
                    end if;
                LOCol <= '1';
                LatchCount := 0;
            else
                LOCol <= '0';
                ColCLK <= '0';
                LatchCount := LatchCount + 1;
            end if;
        end if;
end process;

end Behavioral;
