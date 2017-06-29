library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity VGA_Controller_tb is
end entity VGA_Controller_tb;



architecture behaviour of VGA_Controller_tb is

	signal Reset:  std_logic;		--asynchroner Reset, High aktiv
	signal Clk:  std_logic;		--50MHz Clock
	-------------------------------------------------------------
	signal VGA_Pos_X:  std_logic_vector(9 downto 0);		--Horizontal X Koordinate
	signal VGA_Pos_Y:  std_logic_vector(9 downto 0);		--Vertikal Y Koordinate
	-------------------------------------------------------------
	signal VGA_HS:  std_logic;		--Horizontal Synchronimpuls, High aktiv
	signal VGA_VS:  std_logic;		--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	signal ImageGen_En:  std_logic;		--Enable für Image Generator, High aktiv

begin

VGA_Controller: entity work.VGA_Controller

port map(Reset, Clk, VGA_Pos_X, VGA_Pos_Y, VGA_HS, VGA_VS, ImageGen_En);


VGA_Controller_tester: entity work.VGA_Controller_tester

port map(Reset, Clk, VGA_Pos_X, VGA_Pos_Y, VGA_HS, VGA_VS, ImageGen_En);

end architecture behaviour;