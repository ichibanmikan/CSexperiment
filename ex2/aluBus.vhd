library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity aluBus is
    port( Clk: in STD_LOGIC;
          sw_bus,r4_bus,r5_bus,ALU_bus:in STD_LOGIC;
          lddr1,lddr2,ldr4,ldr5:in STD_LOGIC;
          m, cn:in STD_LOGIC; 
          s:in STD_LOGIC_VECTOR(3 downto 0);
          k:in STD_LOGIC_VECTOR(7 downto 0);
          d:inout STD_LOGIC_VECTOR(7 downto 0));
end aluBus;

architecture aluBus of aluBus is
    signal dr1,dr2,r4,r5,aluout,bus_Reg:STD_LOGIC_VECTOR(7 downto 0);
    signal sel:STD_LOGIC_VECTOR(5 downto 0);
    begin
    ldreg:process(Clk,lddr1,lddr2,ldr4,ldr5,bus_Reg)
        begin
            if Clk'event and Clk ='1'then
                if lddr1='1'then dr1<= bus_Reg; 
                elsif lddr2 ='1'then dr2<= bus_Reg; 
                elsif ldr4='1'then r4<= bus_Reg; 
                elsif ldr5 ='1'then r5<= bus_Reg; 
                end if; 
            end if; 
        end process;
    ALU:process(m, cn, s, dr1,dr2,sel,aluout)
        begin
            sel <= m & cn & s; 
            case sel is
                when "000000" => aluout <= dr1+1; 
				when "010000" => aluout <= dr1;
				when "100000" => aluout <= not dr1;
				when "000001" => aluout <= (dr1 or dr2)+1; 
				when "010001" => aluout <= dr1 or dr2; 
				when "100001" => aluout <= not(dr1 or dr2); 
				when "000010" => aluout <= (dr1 or(not dr2))+1; 
				when "010010" => aluout <= dr1 or(not dr2); 
				when "100010" => aluout <= (not dr1)and dr2; 
				when "000011" => aluout <= x"00"; 
				when "010011" => aluout <= aluout-1; 
				when "100011" => aluout <= x"00";
				when "000100" => aluout <= dr1+(dr1 and(not dr2))+1; 
				when "010100" => aluout <= dr1+(dr1 and(not dr2)); 
				when "100100" => aluout <= not(dr1 and dr2);
				when "000101" => aluout <= (dr1 or dr2)or(dr1 and dr2)or x"01"; 
				when "010101" => aluout <= (dr1 or dr2)+(dr1 and(not dr2));
				when "100101" => aluout <= not dr2;
				when "000110" => aluout <= dr1-dr2; 
				when "010110" => aluout <= dr1-dr2-1; 
				when "100110" => aluout <= dr1 xor dr2; 
				when "000111" => aluout <= dr1 and(not dr2); 
				when "010111" => aluout <= (dr1 and(not dr2))-1; 
				when "100111" => aluout <= dr1 and(not dr2);
				when "001000" => aluout <= dr1+(dr1 and dr2)+1;
				when "011000" => aluout <= dr1+(dr1 and dr2);
				when "101000" => aluout <= (not dr1)or dr2;
				when "001001" => aluout <= dr1+ dr2+1;
				when "011001" => aluout <= dr1 +dr2;
				when "101001" => aluout <= (dr1 xnor dr2);
				when "001010" => aluout <= (dr1 or(not dr2))+(dr1 and dr2)+1;
				when "011010" => aluout <= (dr1 or(not dr2))+(dr1 and dr2);
				when "101010" => aluout <= dr2;
				when "001011" => aluout <= dr1 and dr2;
				when "011011" => aluout <= (dr1 and dr2)-1;
				when "101011" => aluout <= dr1 and dr2;
				when "001100" => aluout <= dr1+dr1 + 1;
				when "011100" => aluout <= dr1 or dr1;
				when "101100" => aluout <= x"01";
				when "001101" => aluout <= (dr1 or dr2)+ dr1 + 1;
				when "011101" => aluout <= (dr1 or dr2)+dr1;
				when "101101" => aluout <= dr1 or(not dr2);
				when "001110" => aluout <= (dr1 or(not dr2))+dr1 +1;
				when "011110" => aluout <= (dr1 or(not dr2))+ dr1;
				when "101110" => aluout <= dr1 or dr2;
				when "001111" => aluout <= dr1;
				when "011111" => aluout <= dr1-1;
				when "101111" => aluout <= dr1;
				when others   => aluout <= x"ff";
            end case;
        end process;
    bus_Reg<=k when (sw_bus='0'and r4_bus='1'and r5_bus ='1'and ALU_bus='1') else
             r4 when (sw_bus='1'and r4_bus='0'and r5_bus='1'and ALU_bus='1') else
             r5 when (sw_bus='1'and r4_bus='1'and r5_bus='0'and ALU_bus='1') else
             aluout when (sw_bus='1'and r4_bus='1'and r5_bus='1'and ALU_bus='0') else
             d;
    d<=bus_Reg when (sw_bus='0'or r4_bus='0'or r5_bus='0'or ALU_bus ='0')else
        (others=>'Z');
    end aluBus;