library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Color.all;




entity Image_Generator_tester is

port(
	Reset: out std_logic ;--:= '0';														--asynchroner Reset, High aktiv
	Clk: out std_logic   ;--:= '0';														--50MHz Clock
	-------------------------------------------------------------------------------------------------------------------
	ImageGen_En: out std_logic;-- := '0';												--Enable für Image Generator, High aktiv
	-------------------------------------------------------------------------------------------------------------------
	VGA_Paddle1_Pixel_En: out std_logic;--   := '0';									--Enable für aktuelles Pixel, High aktiv
	VGA_Paddle2_Pixel_En: out std_logic ;--  := '0';									--Enable für aktuelles Pixel, High aktiv
	VGA_Ball_Pixel_En: out std_logic ;--     := '0';									--Enable für aktuelles Pixel, High aktiv
	VGA_Spielfeld_Pixel_En: out std_logic;-- := '0'; 								--Enable für aktuelles Pixel, High aktiv
	-------------------------------------------------------------------------------------------------------------------
	VGA_Paddle1_Pixel_Color: out std_logic_vector(3 downto 0)  := x"0";	--Farbe für aktuelles Pixel
	VGA_Paddle2_Pixel_Color: out std_logic_vector(3 downto 0)  := x"0";	--Farbe für aktuelles Pixel
	VGA_Ball_Pixel_Color: out std_logic_vector(3 downto 0)     := x"0";	--Farbe für aktuelles Pixel
	VGA_Spielfeld_Pixel_Color: out std_logic_vector(3 downto 0):= x"0";	--Farbe für aktuelles Pixel
	-------------------------------------------------------------------------------------------------------------------
	VGA_R: in std_logic_vector(7 downto 0);--:= x"00";							--Farbausgabe Rot aus LUT für DAC
	VGA_G: in std_logic_vector(7 downto 0);--:= x"00";							--Farbausgabe Grün aus LUT für DAC
	VGA_B: in std_logic_vector(7 downto 0) --:= x"00" 							--Farbausgabe Blau aus LUT für DAC
	);
begin	

end entity Image_Generator_tester;

architecture behaviour of Image_Generator_tester is
	signal iClk: std_logic := '0';

begin

process

begin

	
	VGA_Paddle1_Pixel_En 		<= '0';
	VGA_Paddle2_Pixel_En	 		<= '0';
	VGA_Ball_Pixel_En 			<= '0';
	VGA_Spielfeld_Pixel_En 		<= '0';
	
	VGA_Paddle1_Pixel_Color		<= light_cyan;
	VGA_Paddle2_Pixel_Color		<= light_red;
	VGA_Ball_Pixel_Color			<= light_blue;
	VGA_Spielfeld_Pixel_Color	<= light_green;
	Reset <= '1';
	wait for 20 ns;
	
	Reset <= '0';
	wait for 20 ns;
	
	VGA_Spielfeld_Pixel_En 		<= '1';
	wait for 60 ns;
	
	ImageGen_En 					<= '1';
	wait for 60 ns;
	
	VGA_Paddle2_Pixel_En 		<= '1';
	wait for 60 ns;
	
	VGA_Paddle1_Pixel_En 		<= '1';
	wait for 60 ns;
	
	VGA_Ball_Pixel_En		 		<= '1';
	wait for 60 ns;
	
	
	ImageGen_En 					<= '0';
	wait for 60 ns;
	VGA_Paddle1_Pixel_En 		<= '0';
	VGA_Paddle2_Pixel_En	 		<= '0';
	VGA_Ball_Pixel_En 			<= '0';
	VGA_Spielfeld_Pixel_En 		<= '0';
	wait for 60 ns;
		
	ImageGen_En 					<= '1';
	wait for 60 ns;
	
	
end process;
	
	
iClk <= not iClk after 10 ns; --für 50MHz Taktfrequenz
Clk <= iClk;

end architecture behaviour;