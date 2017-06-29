library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Color.all;

entity Pong_Test is

port(
	Reset: in std_logic;		--asynchroner Reset, High aktiv
	Clk: in std_logic;		--50MHz Clock

	-------------------------------------------------------------
	VGA_HS: out std_logic;		--Horizontal Synchronimpuls, High aktiv
	VGA_VS: out std_logic;		--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	VGA_R: out std_logic_vector(7 downto 0);		--Farbausgabe Rot aus LUT für DAC
	VGA_G: out std_logic_vector(7 downto 0);		--Farbausgabe Grün aus LUT für DAC
	VGA_B: out std_logic_vector(7 downto 0);		--Farbausgabe Blau aus LUT für DAC
	VGA_Clk: out std_logic
);

end entity Pong_Test;

architecture behave of Pong_Test is

	-------------------------------------------------------------
	signal VGA_Pos_X:  std_logic_vector(9 downto 0) := (others => '0');		--Horizontal X Koordinate --Standardwert neu hinzugefügt
	signal VGA_Pos_Y:  std_logic_vector(9 downto 0) := (others => '0');		--Vertikal Y Koordinate  --Standardwert neu hinzugefügt
	
		-------------------------------------------------------------
	signal VGA_Paddle1_Pixel_En: std_logic;		--Enable für aktuelles Pixel, High aktiv
	signal VGA_Paddle2_Pixel_En: std_logic;		--Enable für aktuelles Pixel, High aktiv
	signal VGA_Ball_Pixel_En: std_logic;			--Enable für aktuelles Pixel, High aktiv
	signal VGA_Spielfeld_Pixel_En:  std_logic;	--Enable für aktuelles Pixel, High aktiv
	-------------------------------------------------------------
	signal VGA_Paddle1_Pixel_Color: std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	signal VGA_Paddle2_Pixel_Color: std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	signal VGA_Ball_Pixel_Color: std_logic_vector(3 downto 0);			--Farbe für aktuelles Pixel
	signal VGA_Spielfeld_Pixel_Color:  std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel

	begin
	
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
					
Spielfeld: entity work.Spielfeld
	port map(
		--Goal1, 							
		open,
		--Goal2,							
		open,
		--Boarder_colission, 			
		open,
		VGA_Spielfeld_Pixel_Color, 	
		VGA_Spielfeld_Pixel_En, 		
		--Ball_Pos_X, 						
		"0000000000",
		--Ball_Pos_Y, 						
		"0000000000",
		VGA_Pos_X, 						
		VGA_Pos_Y 			
	);
					
			
	PaddleLeft: entity work.PongObject
	generic map(
		StartPosX 	=> 10x"00F",
		StartPosY 	=> 10x"02F",
		breite 		=> 10x"01F",
		hoehe 		=> 10x"09F",
		Color			=> blue,
		Motion		=> '1',
		Speed			=> 10x"001"
	)	
	port map(
		VGA_Paddle1_Pixel_Color,
		VGA_Paddle1_Pixel_En,
		VGA_Pos_X,
		VGA_Pos_Y,
		Clk
	);

	PaddleRight: entity work.PongObject
	generic map(
		StartPosX 	=> 10x"2F0",
		StartPosY 	=> 10x"05F",
		breite 		=> 10x"01F",
		hoehe 		=> 10x"09F",
		Color			=> green,
		Motion		=> '1',
		Speed			=> 10x"000"
	)	
	port map(
		VGA_Paddle2_Pixel_Color,
		VGA_Paddle2_Pixel_En,
		VGA_Pos_X,
		VGA_Pos_Y,
		Clk
	);	
	
	Ball: entity work.PongObject
	generic map(
		StartPosX 	=> 10x"186",
		StartPosY 	=> 10x"122",
		breite 		=> 10x"02F",
		hoehe 		=> 10x"03F",
		Color			=> magenta,
		Motion		=> '0',
		Speed			=> 10x"040"
	)	
	port map(
		VGA_Ball_Pixel_Color,
		VGA_Ball_Pixel_En,
		VGA_Pos_X,
		VGA_Pos_Y,
		Clk
	);	
end architecture behave;