library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_tb is


end entity VGA_tb;


architecture tb of VGA_tb is

	signal Reset: std_logic;		--asynchroner Reset, High aktiv
	signal Clk: std_logic;		--50MHz Clock
	-------------------------------------------------------------
	signal VGA_Paddle1_Pixel_En: std_logic;		--Enable für aktuelles Pixel, High aktiv
	signal VGA_Paddle2_Pixel_En: std_logic;		--Enable für aktuelles Pixel, High aktiv
	signal VGA_Ball_Pixel_En:  std_logic;			--Enable für aktuelles Pixel, High aktiv
	signal VGA_Spielfeld_Pixel_En:  std_logic;	--Enable für aktuelles Pixel, High aktiv
	-------------------------------------------------------------
	signal VGA_Paddle1_Pixel_Color:  std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	signal VGA_Paddle2_Pixel_Color:  std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	signal VGA_Ball_Pixel_Color:  std_logic_vector(3 downto 0);			--Farbe für aktuelles Pixel
	signal VGA_Spielfeld_Pixel_Color:  std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	-------------------------------------------------------------
	signal VGA_Pos_X:  std_logic_vector(9 downto 0);		--Horizontal X Koordinate
	signal VGA_Pos_Y:  std_logic_vector(9 downto 0);		--Vertikal Y Koordinate
	-------------------------------------------------------------
	signal VGA_HS:  std_logic;		--Horizontal Synchronimpuls, High aktiv
	signal VGA_VS:  std_logic;		--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	signal VGA_R:  std_logic_vector(7 downto 0);		--Farbausgabe Rot aus LUT für DAC
	signal VGA_G:  std_logic_vector(7 downto 0);		--Farbausgabe Grün aus LUT für DAC
	signal VGA_B:  std_logic_vector(7 downto 0);		--Farbausgabe Blau aus LUT für DAC
	signal VGA_Clk:  std_logic;

begin

tester: entity work.VGA_tester

		port map(Reset,
					Clk,
					VGA_Paddle1_Pixel_En,
					VGA_Paddle2_Pixel_En,
					VGA_Ball_Pixel_En,
					VGA_Spielfeld_Pixel_En,
					VGA_Paddle1_Pixel_Color,
					VGA_Paddle2_Pixel_Color,
					VGA_Ball_Pixel_Color,
					VGA_Spielfeld_Pixel_Color,
					VGA_Pos_X,
					VGA_Pos_Y,
					VGA_HS,
					VGA_VS,
					VGA_R,
					VGA_G,
					VGA_B,
					VGA_Clk);
				
VGA: entity work.VGA

		port map(Reset,
					Clk,
					VGA_Paddle1_Pixel_En,
					VGA_Paddle2_Pixel_En,
					VGA_Ball_Pixel_En,
					VGA_Spielfeld_Pixel_En,
					VGA_Paddle1_Pixel_Color,
					VGA_Paddle2_Pixel_Color,
					VGA_Ball_Pixel_Color,
					VGA_Spielfeld_Pixel_Color,
					VGA_Pos_X,
					VGA_Pos_Y,
					VGA_HS,
					VGA_VS,
					VGA_R,
					VGA_G,
					VGA_B,
					VGA_Clk);

end architecture tb;