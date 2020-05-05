----------------------------------------------------------------------------------
--
-- Create Date:    15:10:19 12/02/2019
-- Design Name:
-- Module Name:    reg4bits_hab - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg4bits_hab is
    Port ( digitoBCD : in  STD_LOGIC_VECTOR (3 downto 0);
	        clk : in std_logic;
          hab : in std_logic;
           BCDalmacenado : out  STD_LOGIC_VECTOR (7 downto 0);
           reset : in  STD_LOGIC);
end reg4bits_hab;

architecture Behavioral of reg4bits_hab is
  signal digBCD : std_logic_vector (3 downto 0);

begin
  process(clk, hab, digitoBCD, reset)--Creamos un clock para sincronizar el sistema
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        digBCD <= (others => '0');
      elsif hab = '1'then
        digBCD <= digitoBCD;
      end if;
    end if;
  end process;

  BCDalmacenado <= digBCD;

end Behavioral;
