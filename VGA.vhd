library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA is

port(
	Reset: in std_logic;		--asynchroner Reset, High aktiv
	Clk: in std_logic;		--50MHz Clock
	-------------------------------------------------------------
	VGA_Paddle1_Pixel_En: in std_logic;		--Enable für aktuelles Pixel, High aktiv
	VGA_Paddle2_Pixel_En: in std_logic;		--Enable für aktuelles Pixel, High aktiv
	VGA_Ball_Pixel_En: in std_logic;			--Enable für aktuelles Pixel, High aktiv
	VGA_Spielfeld_Pixel_En: in std_logic;	--Enable für aktuelles Pixel, High aktiv
	-------------------------------------------------------------
	VGA_Paddle1_Pixel_Color: in std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	VGA_Paddle2_Pixel_Color: in std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	VGA_Ball_Pixel_Color: in std_logic_vector(3 downto 0);			--Farbe für aktuelles Pixel
	VGA_Spielfeld_Pixel_Color: in std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	-------------------------------------------------------------
	VGA_Pos_X: out std_logic_vector(9 downto 0) := (others => '0');		--Horizontal X Koordinate --Standardwert neu hinzugefügt
	VGA_Pos_Y: out std_logic_vector(9 downto 0) := (others => '0');		--Vertikal Y Koordinate  --Standardwert neu hinzugefügt
	-------------------------------------------------------------
	VGA_HS: out std_logic;		--Horizontal Synchronimpuls, High aktiv
	VGA_VS: out std_logic;		--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	VGA_R: out std_logic_vector(7 downto 0);		--Farbausgabe Rot aus LUT für DAC
	VGA_G: out std_logic_vector(7 downto 0);		--Farbausgabe Grün aus LUT für DAC
	VGA_B: out std_logic_vector(7 downto 0);		--Farbausgabe Blau aus LUT für DAC
	VGA_Clk: out std_logic
);

end entity VGA;


architecture behaviour of VGA is

signal ImageGen_En : std_logic := '0';

begin

--VGA controller
VGA_Clk <= Clk;
VGA_Controller: entity work.VGA_Controller
generic map(	
				horizontal_sync_pulse_width=>120,
				horizontal_back_porch_width=>64,
				horizontal_image_width=>800,
				horizontal_front_porch_width=> 56,
				horizontal_sync_pulse_polariy=>'1',
				vertikal_sync_pulse_width=> 6,
				vertikal_back_porch_width=>23,
				vertikal_image_width=>600,
				vertikal_front_porch_width=> 37,
				vertikal_sync_pulse_polariy=>'1')
port map(	Reset, 
				Clk, 
				VGA_Pos_X, 
				VGA_Pos_Y, 
				VGA_HS, 
				VGA_VS, 
				ImageGen_En);

				
--Image Generator
ImageGenerator: entity work.Image_Generator
port map(	Reset, 
				Clk, 
				ImageGen_En, 
				VGA_Paddle1_Pixel_En,
				VGA_Paddle2_Pixel_En,
				VGA_Ball_Pixel_En,
				VGA_Spielfeld_Pixel_En, 
				VGA_Paddle1_Pixel_Color, 
				VGA_Paddle2_Pixel_Color,
				VGA_Ball_Pixel_Color,
				VGA_Spielfeld_Pixel_Color,
				VGA_R,
				VGA_G,
				VGA_B);

end architecture behaviour;