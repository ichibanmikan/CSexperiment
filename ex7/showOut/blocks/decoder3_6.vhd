library ieee;
use ieee.std_logic_1164.all;

entity decoder3_6 is
    port (data:in std_logic_vector(2 downto 0);
          seg:out std_logic_vector(5 downto 0));
end decoder3_6;

architecture decoder3_6 of decoder3_6 is
begin
    seg <= 
        "011111" when data="000" else
        "101111" when data="001" else 
        "110111" when data="010" else
        "111011" when data="011" else
        "111101" when data="100" else
        "111110";
end decoder3_6;
        