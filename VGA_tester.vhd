library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_tester is

port(
	Reset: out std_logic;		--asynchroner Reset, High aktiv
	Clk: out std_logic;			--50MHz Clock
	-------------------------------------------------------------
	VGA_Paddle1_Pixel_En: out std_logic;		--Enable für aktuelles Pixel, High aktiv
	VGA_Paddle2_Pixel_En: out std_logic;		--Enable für aktuelles Pixel, High aktiv
	VGA_Ball_Pixel_En: out std_logic;			--Enable für aktuelles Pixel, High aktiv
	VGA_Spielfeld_Pixel_En: out std_logic;		--Enable für aktuelles Pixel, High aktiv
	-------------------------------------------------------------
	VGA_Paddle1_Pixel_Color: out std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	VGA_Paddle2_Pixel_Color: out std_logic_vector(3 downto 0);		--Farbe für aktuelles Pixel
	VGA_Ball_Pixel_Color: out std_logic_vector(3 downto 0);			--Farbe für aktuelles Pixel
	VGA_Spielfeld_Pixel_Color: out std_logic_vector(3 downto 0);	--Farbe für aktuelles Pixel
	-------------------------------------------------------------
	VGA_Pos_X: in std_logic_vector(9 downto 0);		--Horizontal X Koordinate
	VGA_Pos_Y: in std_logic_vector(9 downto 0);		--Vertikal Y Koordinate
	-------------------------------------------------------------
	VGA_HS: in std_logic;		--Horizontal Synchronimpuls, High aktiv
	VGA_VS: in std_logic;		--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	VGA_R: in std_logic_vector(7 downto 0);		--Farbausgabe Rot aus LUT für DAC
	VGA_G: in std_logic_vector(7 downto 0);		--Farbausgabe Grün aus LUT für DAC
	VGA_B: in std_logic_vector(7 downto 0);		--Farbausgabe Blau aus LUT für DAC
	VGA_Clk: in std_logic
);

end entity VGA_tester;


architecture behaviour of VGA_tester is
	signal iClk: std_logic := '0';

	--alias ImageGen_En is << signal .VGA_tb.VGA.ImageGen_En : std_logic >>;
  
begin

process

begin

	Reset <= '1';
	wait for 20 ns;
	
	Reset <= '0';
	
	VGA_Paddle1_Pixel_Color <= x"A";
	VGA_Paddle2_Pixel_Color <= x"2";
	VGA_Ball_Pixel_Color <= x"6";
	VGA_Spielfeld_Pixel_Color <= x"C";
	
	VGA_Paddle1_Pixel_En <= '0';
	VGA_Paddle2_Pixel_En <= '0';
	VGA_Ball_Pixel_En <= '0';
	VGA_Spielfeld_Pixel_En <= '0';
	
	wait for 100 ns;
	
	VGA_Paddle1_Pixel_En <= '1';
	
	wait for 100 ns;
	
	VGA_Paddle1_Pixel_En <= '0';
	VGA_Ball_Pixel_En <= '1';
	
	wait for 100 ns;
	
	VGA_Ball_Pixel_En <= '0';
	VGA_Paddle2_Pixel_En <= '1';
	
	wait for 100 ns;
	
	VGA_Paddle2_Pixel_En <= '0';
	
	wait for 14 ms;
	
	
end process;
	
	
iClk <= not iClk after 10 ns; --für 50MHz
Clk <= iClk;

end architecture behaviour;


