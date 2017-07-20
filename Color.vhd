library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package Color is
  constant black 				: std_Logic_vector(3 downto 0);
  constant blue 				: std_Logic_vector(3 downto 0);
  constant green 				: std_Logic_vector(3 downto 0);
  constant cyan 				: std_Logic_vector(3 downto 0);
  constant red 				: std_Logic_vector(3 downto 0);
  constant magenta 			: std_Logic_vector(3 downto 0);
  constant brown 				: std_Logic_vector(3 downto 0);
  constant gray 				: std_Logic_vector(3 downto 0);
  constant dark_gray 		: std_Logic_vector(3 downto 0);
  constant light_blue 		: std_Logic_vector(3 downto 0);
  constant light_green 		: std_Logic_vector(3 downto 0);
  constant light_cyan 		: std_Logic_vector(3 downto 0);
  constant light_red 		: std_Logic_vector(3 downto 0);
  constant light_magenta 	: std_Logic_vector(3 downto 0);
  constant yellow 			: std_Logic_vector(3 downto 0);
  constant white 				: std_Logic_vector(3 downto 0);
end package Color;

package body Color is
  constant black 				: std_Logic_vector(3 downto 0) := x"0";
  constant blue 				: std_Logic_vector(3 downto 0) := x"1";
  constant green 				: std_Logic_vector(3 downto 0) := x"2";
  constant cyan 				: std_Logic_vector(3 downto 0) := x"3";
  constant red 				: std_Logic_vector(3 downto 0) := x"4";
  constant magenta 			: std_Logic_vector(3 downto 0) := x"5";
  constant brown 				: std_Logic_vector(3 downto 0) := x"6";
  constant gray 				: std_Logic_vector(3 downto 0) := x"7";
  constant dark_gray 		: std_Logic_vector(3 downto 0) := x"8";
  constant light_blue 		: std_Logic_vector(3 downto 0) := x"9";
  constant light_green 		: std_Logic_vector(3 downto 0) := x"A";
  constant light_cyan 		: std_Logic_vector(3 downto 0) := x"B";
  constant light_red 		: std_Logic_vector(3 downto 0) := x"C";
  constant light_magenta 	: std_Logic_vector(3 downto 0) := x"D";
  constant yellow 			: std_Logic_vector(3 downto 0) := x"E";
  constant white 				: std_Logic_vector(3 downto 0) := x"F";
end package body Color;

		--CGA	RGB	Farbe
		--0x0	0,0,0	black
		--0x1	0,0,170	blue
		--0x2	0,170,0	green
		--0x3	0,170,170	cyan
		--0x4	170,0,0	red
		--0x5	170,0,170	magenta
		--0x6	170,85,0	brown
		--0x7	170,170,170	gray
		--0x8	85,85,85	dark gray
		--0x9	85,85,255	bright blue
		--0xA	85,255,85	bright green
		--0xB	85,255,255	bright cyan
		--0xC	255,85,85	bright red
		--0xD	255,85,255	bright magenta
		--0xE	255,255,85	yellow
		--0xF	255,255,255	white
		