displayCol : process (CLK)


begin
    if (rising_edge(CLK)) then
        if (outCount2 = 7) then
            ColCLK <= '1';
                if (count3 = 40) then
                    DataOut2 <= '1';
                    count3 := 0;
                else
                    DataOut <= '0';
                    count3 := count3 + 1;
                end if;
            LatchOut2 <= 1;
            outCount2 := 0;
        else
            LatchOut2 <= 0;
            ColCLK <= '0';
            outCount2 := outCount2 + 1;
        end if;
    end if;
end process;
