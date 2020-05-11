----------------------------------------------------------------------------------
--
-- Create Date:    15:10:19 12/02/2019
-- Design Name:
-- Module Name:    control - Behavioral
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

entity control is
    Port ( clk : in std_logic;
           cont : in std_logic;
           mux : out  STD_LOGIC_VECTOR (1 downto 0);
           enable : out std_logic_vector(2 downto 0);
           reset : in  STD_LOGIC);
end control;

architecture Behavioral of control is
  type state_type is (st1_dig1, st2_dig2, st3_dig3);
  signal state, next_state : state_type;


begin

  SYNC_PROC: process (clk, reset)
  process(clk, hab, digitoBCD, reset)--Creamos un clock para sincronizar el sistema
  begin
    if (clk'event and clk = '1') then
      if (reset = '1') then
        state <= st1_dig1;
      else
        state <= next_state;

      end if;
    end if;

  end process;

  BCDalmacenado <= digBCD;

  OUTPUT_DECODE: process(state)
  begin
    --valores por defecto
    mux     <= "00";
    enable  <= "000";

    if state = st1_dig1 then
      mux <= "00";
      enable <= "001":
    elsif state = st2_dig2 then
      mux <= "01";
      enable <= "010":
    elsif state = st3_dig3 then
      mux <= "10";
      enable <= "100":

    end if;
  end process;

  NEXT_STATE_DECODE: process(state, cont)
  begin
    next_state <= state;
    case (state) is
      when st1_dig1 =>
        if cont = '1' then
          next_state <= st2_dig2;
        end if;
      when st2_dig2 =>
        if cont = '1' then
          next_state <= st3_dig3;
        end if;
      when st3_dig3 =>
      if cont = '1' then
        next_state <= st1_dig1;
      end if;
      when others =>
        next_state <= st1_dig1;
    end case;
  end process;

end Behavioral;
