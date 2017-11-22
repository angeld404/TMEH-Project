-- Needs work but I need the hardware to test so GG`


variable column : bit := "000000000000000000000000000001";

display : process
    begin
        for X in range 0 to 7 loop
            wait for rising.edge(CLK);
            R_SMP1_A(X) <= DataOut;
        end for;
        for Y in range 0 to 39 loop
            wait for rising.edge(CLK);
            column <= DataOut;
        end for;
        column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP1_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP1_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP1_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP1_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP1_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
----------------------------------------------
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP1_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP1_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP1_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP1_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP1_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
----------------------------------------------
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP2_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP2_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP2_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP2_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_SMP2_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
----------------------------------------------
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP2_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP2_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP2_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP2_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    R_HMP2_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
--------------------------------------------
--------------------------------------------
--------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP1_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP1_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP1_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP1_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP1_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
----------------------------------------------
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP1_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP1_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP1_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP1_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP1_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
----------------------------------------------
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP2_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP2_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP2_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP2_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_SMP2_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
----------------------------------------------
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP2_A(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP2_B(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP2_C(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP2_D(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := column + column;
----------------------------------------------
for X in range 0 to 7 loop
    wait for rising.edge(CLK);
    G_HMP2_E(X) <= DataOut;
end for;
for Y in range 0 to 39 loop
    wait for rising.edge(CLK);
    column <= DataOut;
end for;
column := "000000000000000000000000000001";
