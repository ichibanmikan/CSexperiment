library ieee;
use ieee.std_logic_1164.all;
entity dataBus is
port(	Clk: in std_logic;
		sw_bus, r1_bus, r2_bus, r3_bus: in std_logic;
		k: in std_logic_vector(7 downto 0);
		lddr: in std_logic_vector(3 downto 1);
		l: inout std_logic_vector(7 downto 0);
		outr3: out std_logic_vector(7 downto 0);
		outr1, outr2: out std_logic_vector(7 downto 0));
end dataBus;

architecture dataBus of dataBus is
	signal r1, r2, r3, bus_Reg: std_logic_vector(7 downto 0);
	begin
		ldreg:process(Clk, lddr, bus_Reg)
		begin
			if Clk'event and Clk = '1' then
				if lddr(1) = '1' then r1 <= bus_Reg;
				elsif lddr(2) = '1' then r2 <= bus_Reg;
				elsif lddr(3) = '1' then r3 <= bus_Reg;
				end if;
			end if;
		end process;
		
		bus_Reg <= k when (sw_bus = '0' and r1_bus = '1' and r2_bus = '1' and r3_bus = '1') else
				   r1 when (sw_bus = '1' and r1_bus = '0' and r2_bus = '1' and r3_bus = '1') else
				   r2 when (sw_bus = '1' and r1_bus = '1' and r2_bus = '0' and r3_bus = '1') else
				   r3 when (sw_bus = '1' and r1_bus = '1' and r2_bus = '1' and r3_bus = '0') else
				   (others => '0');
		l <= bus_Reg when ((sw_bus = '0' or r1_bus = '0' or r2_bus = '0') and r3_bus='1') else
				   (others => 'Z');
		outr3<=r3;
		outr2<=r2;
		outr1<=r1;
		end dataBus;