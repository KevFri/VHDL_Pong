library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Color.all;




entity Image_Generator_tb is
begin	

end entity Image_Generator_tb;

architecture behaviour of Image_Generator_tb is
	
	signal	Reset:  std_logic;
	signal	Clk:  std_logic;
	signal	ImageGen_En:  std_logic;
	signal	VGA_Paddle1_Pixel_En:  std_logic;
	signal	VGA_Paddle2_Pixel_En:  std_logic;
	signal	VGA_Ball_Pixel_En:  std_logic;
	signal	VGA_Spielfeld_Pixel_En:  std_logic;
	signal	VGA_Paddle1_Pixel_Color:  std_logic_vector(3 downto 0);
	signal	VGA_Paddle2_Pixel_Color:  std_logic_vector(3 downto 0);
	signal	VGA_Ball_Pixel_Color:  std_logic_vector(3 downto 0);
	signal	VGA_Spielfeld_Pixel_Color: std_logic_vector(3 downto 0);
	signal	VGA_R:  std_logic_vector(7 downto 0);
	signal	VGA_G:  std_logic_vector(7 downto 0);
	signal	VGA_B:  std_logic_vector(7 downto 0);

begin

DUT: entity work.Image_Generator
generic map(white)
port map(Reset,Clk,ImageGen_En,VGA_Paddle1_Pixel_En,VGA_Paddle2_Pixel_En,VGA_Ball_Pixel_En,VGA_Spielfeld_Pixel_En,VGA_Paddle1_Pixel_Color,VGA_Paddle2_Pixel_Color,VGA_Ball_Pixel_Color,VGA_Spielfeld_Pixel_Color,VGA_R,VGA_G,VGA_B);


Tester: entity work.Image_Generator_tester
port map(Reset,Clk,ImageGen_En,VGA_Paddle1_Pixel_En,VGA_Paddle2_Pixel_En,VGA_Ball_Pixel_En,VGA_Spielfeld_Pixel_En,VGA_Paddle1_Pixel_Color,VGA_Paddle2_Pixel_Color,VGA_Ball_Pixel_Color,VGA_Spielfeld_Pixel_Color,VGA_R,VGA_G,VGA_B);

end architecture behaviour;