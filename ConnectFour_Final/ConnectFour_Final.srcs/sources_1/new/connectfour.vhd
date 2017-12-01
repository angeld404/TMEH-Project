library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity connectfour is
    Port ( Lbtn : in STD_LOGIC;
           Rbtn : in STD_LOGIC;
           Cbtn : in STD_LOGIC;
           CLK  : in STD_LOGIC;


 
           DORow : out STD_LOGIC_VECTOR(7 downto 0) := "00000000";
           

           DOCol : out STD_LOGIC_VECTOR(0 to 15) := "0000000000000000"
           );
end connectfour;

architecture Behavioral of connectfour is

    signal TurnState, BtnCLK : std_logic := '1';
    signal RedA, RedB, RedC, RedD, RedE, RedF, RedG, RedH : std_logic_vector (7 downto 0) := "00000000";
    signal GreenA, GreenB, GreenC, GreenD, GreenE, GreenF, GreenG, GreenH : std_logic_vector  (7 downto 0) := "00000000";
    signal RowCLK, ColCLK : std_logic := '0';
    signal LORowSig : std_logic := '0';
    signal NTurnState : std_logic := '1';

begin

CLKDivider : process (CLK)
    variable clkcount2 : integer range 0 to 52083 := 0;
    variable clkcount : integer range 0 to 6510 := 0;
    begin
        if (rising_edge(CLK)) then
            clkcount := clkcount + 1;
            clkcount2 := clkcount2 + 1;
            if (clkcount = 6510) then
                RowCLK <= not(RowCLK);
                clkcount := 0;
            end if;
            if (clkcount2 = 52083) then
                ColCLK <= not(ColCLK);
                clkcount2 := 0;
            end if;
        end if;
end process;

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


cursor : process (BtnCLK)
    variable OCursorCol : STD_LOGIC_VECTOR (2 downto 0) := "000";
    variable NCursorCol : STD_LOGIC_VECTOR (2 downto 0) := "000";
    
    begin
    if (rising_edge(BtnCLK)) then
        case (OCursorCol) is
            when "000" =>
                if (Lbtn = '1') then
                    NCursorCol := "111";
                elsif (Rbtn = '1') then
                    NCursorCol := "001";
                elsif (Cbtn = '1') then
                    NCursorCol := OCursorCol;
                    NTurnState <= not(TurnState);

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
                case (TurnState) is
                    when '0' =>
                        GreenA(0) <= '0';
                        if (NCursorCol = OCursorCol) then
                            RedA(0) <= '1';
                        elsif (NCursorCol = "111") then
                            RedH(0) <= '1';
                            RedA(0) <= '0';
                        elsif (NCursorCol = "001") then
                            RedB(0) <= '1';
                            RedA(0) <= '0';
                        end if;
                    when '1' =>
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
              when "001" =>
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
              when "010" =>

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

              when "011" =>

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

              when "100" =>

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

              when "101" =>

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

              when "110" =>

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

              when "111" =>
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

displayRow : process (ColCLK)
variable RowCount : integer range 0 to 16 := 0;
begin
    if (rising_edge(ColCLK)) then
        if (RowCount = 0) then
            DORow <= RedA;
            DOCol <= "1000000000000000";
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
        if (RowCount = 15) then
            RowCount := 0;
        else
            RowCount := RowCount + 1;
        end if;
    end if;
end process;





end Behavioral;