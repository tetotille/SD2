----------------------------------------------------------------------------------
--
-- Create Date:    15:10:19 12/02/2019
-- Design Name:
-- Module Name:    display - estructural
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

entity display is
    Port ( clk : in std_logic;
           reset : in  STD_LOGIC;
           dig1 : in std_logic_vector(3 downto 0);
           ce1 : in std_logic;
           dig2 : in std_logic_vector(3 downto 0);
           ce2 : in std_logic;
           dig3 : in std_logic_vector(3 downto 0);
           ce3 : in std_logic;
           enable : out std_logic_vector(2 downto 0);
           seg : out std_logic_vector(7 downto 0));
end display;

architecture estructural of display is
  -- Componentes
  COMPONENT cont_mod_170000
  PORT (
        clk : in std_logic;
        reset : in std_logic;
        salida: out std_logic);
  END COMPONENT;

  COMPONENT mux_dec
  PORT (
        dig1 : in std_logic_vector (3 downto 0);
        dig2 : in std_logic_vector (3 downto 0);
        dig3 : in std_logic_vector (3 downto 0);
        ct1 : in std_logic_vector (1 downto 0);
        seg : out std_logic_vector (7 downto 0));
  END COMPONENT;

  COMPONENT reg4bits_hab
  PORT (
        digitoBCD : in  STD_LOGIC_VECTOR (3 downto 0);
        clk : in std_logic;
        hab : in std_logic;
         BCDalmacenado : out  STD_LOGIC_VECTOR (7 downto 0);
         reset : in  STD_LOGIC);
  END COMPONENT;

  COMPONENT control
  PORT (
          clk : in std_logic;
         cont : in std_logic;
         mux : out  STD_LOGIC_VECTOR (1 downto 0);
         enable : out std_logic_vector(2 downto 0);
         reset : in  STD_LOGIC);
  END COMPONENT;

-- señales de interconexión
  signal BCDdig1, BCDdig2, BCDdig3 : std_logic_vector(3 downto 0);
  signal mux : std_logic_vector(1 downto 0);
  signal cont : std_logic;

begin
  --instanciación
    reg_dig1 : reg4bits_hab PORT MAP (
    digitoBCD     => dig1,
    hab           => ce1,
    BCDalmacenado => BCDdig1,
    clk           => clk,
    reset         => reset
  );

    reg_dig2 : reg4bits_hab PORT MAP (
    digitoBCD     => dig2,
    hab           => ce2,
    BCDalmacenado => BCDdig2,
    clk           => clk,
    reset         => reset
  );

    reg_dig3 : reg4bits_hab PORT MAP (
    digitoBCD     => dig3,
    hab           => ce3,
    BCDalmacenado => BCDdig3,
    clk           => clk,
    reset         => reset
  );


    multiplexor : mux_dec PORT MAP (
    dig1  => BCDdig1,
    dig2  => BCDdig2,
    dig3  => BCDdig3,
    ct1   => mux,
    seg   => seg
  );

  contador : cont_mod_170000 PORT MAP (
    clk     => clk,
    reset   => reset,
    salida  => cont
  );

  uControl : control PORT MAP (
    clk => clk,
    cont => cont,
    mux => mux,
    enable => enable,
    reset => reset
  );

end estructural;
