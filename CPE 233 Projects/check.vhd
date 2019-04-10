-- TurnState; if 0 --> player 1; if 1 --> player 2
process (TurnState)
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

    for ck2 in range 0 to 7 loop
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
end case;
