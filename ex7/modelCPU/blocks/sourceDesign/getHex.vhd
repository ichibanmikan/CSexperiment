library ieee;
use ieee.std_logic_1164.all;

entity getHex is
    port(dout:in std_logic_vector(3 downto 0);
		qa,qb,qc,qd,qe,qf,qg:out std_logic);
end getHex;

architecture getHex of getHex is
    signal Q:std_logic_vector(6 downto 0):="0000000";
    begin
        process (dout)
        begin
            case dout is
                when "0000"=>	
                    Q<="1111110";
                when "0001"=>	
                    Q<="0110000";
                when "0010"=>	
                    Q<="1101101";
                when "0011"=>	
                    Q<="1111001";
                when "0100"=>	
                    Q<="0110011";
                when "0101"=>	
                    Q<="1011011";			
                when "0110"=>	
                    Q<="1011111";			
                when "0111"=>	
                    Q<="1110000";			
                when "1000"=>	
                    Q<="1111111";			
                when "1001"=>	
                    Q<="1111011";		
                when "1010"=>	
                    Q<="1110111";			
                when "1011"=>	
                    Q<="0011111";			
                when "1100"=>	
                    Q<="1001110";			
                when "1101"=>	
                    Q<="0111101";			
                when "1110"=>	
                    Q<="1001111";			
                when "1111"=>	
                    Q<="1000111";	
            end case;
        end process;
        qa<=Q(6);
        qb<=Q(5);
        qc<=Q(4);
        qd<=Q(3);
        qe<=Q(2);
        qf<=Q(1);
        qg<=Q(0);
end getHex;			