
displayRow : process (CLK)
    variable RowCountA : integer range 0 to 8  := 0;
    variable RowCountB : integer range 0 to 8  := 0;
    variable RowCountC : integer range 0 to 8  := 0;
    variable RowCountD : integer range 0 to 8  := 0;
    variable RowCountE : integer range 0 to 8  := 0;
    variable outCount  : integer range 0 to 7  := 0;
    variable OScreen  : unsigned (2 downto 0) := "000";
    variable NScreen  : unsigned (2 downto 0) := "000";

begin
if (rising_edge(CLK)) then
    if (outCount = 7) then
        LatchOut <= 1;
        outCount := 0;
    else
        LatchOut <= 0;
        outCount := outCount + 1;
    end if;



    case (OScreen) is =>
        when "000" =>
            if (RowCountA = 8) then
                DataOut <= R_SMP1_A(RowCountA);
                -- Output Clock goes high
                if (RowCountB = 8) then
                    DataOut <= R_SMP1_B(RowCountB);
                    -- Output Clock Goes High
                    if (RowCountC = 8) then
                        DataOut <= R_SMP1_C(RowCountC);
                        -- Output Clock Goes High
                        if (RowCountD = 8) then
                            DataOut <= R_SMP1_D(RowCountD);
                            -- Output Clock Goes High
                            if (RowCountE = 8) then
                                DataOut <= R_SMP1_E(RowCountE);
                                -- Output Clock Goes High
                                NScreen := "001";
                                RowCountA := 0;
                                RowCountB := 0;
                                RowCountC := 0;
                                RowCountD := 0;
                                RowCountE := 0;
                            else
                                DataOut <= R_SMP1_E(RowCountE);
                                RowCountE := RowCountE + RowCountE + 1;
                            end if;
                        else
                            DataOut <= R_SMP1_D(RowCountD);
                            RowCountD := RowCountD + RowCountD + 1;
                        end if;
                    else
                        DataOut <= R_SMP1_C(RowCountC);
                        RowCountC := RowCountC + RowCountC + 1;
                    end if;
                else
                    DataOut <= R_SMP1_B(RowCountB);
                    RowBCount := RowBCount + RowBCount + 1;
                end if;
            else
                DataOut <= R_SMP1_A(RowCountA);
                RowCountA := RowCountA + RowACountA;
            end if;
            OScreen := NScreen;


        when "001" =>
        when "010" =>
        when "011" =>
        when "100" =>
        when "101" =>
        when "110" =>
        when "111" =>
end process;
