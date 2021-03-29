library ieee;
use ieee.std_logic_1164.all;

entity mux4_6_1 is
    port (d0,d1,d2,d3,d4,d5:in std_logic_vector(3 downto 0);
          sel :in std_logic_vector(2 downto 0);
          dout:out std_logic_vector(3 downto 0));
end mux4_6_1;

architecture mux4_6_1 of mux4_6_1 is
begin
    dout <= 
	d0 when sel="000" else
	d1 when sel="001" else 
	d2 when sel="010" else
	d3 when sel="011" else
	d4 when sel="100" else
	d5;
end mux4_6_1;
        
        
