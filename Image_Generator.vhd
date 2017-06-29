library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Image_Generator is

port(
	Reset: in std_logic := '0';		--asynchroner Reset, High aktiv
	Clk: in std_logic := '0';			--50MHz Clock
	-------------------------------------------------------------
	ImageGen_En: in std_logic := '0';		--Enable für Image Generator, High aktiv
	-------------------------------------------------------------
	VGA_Paddle1_Pixel_En: in std_logic := '0';		--Enable für aktuelles Pixel, High aktiv
	VGA_Paddle2_Pixel_En: in std_logic := '0';		--Enable für aktuelles Pixel, High aktiv
	VGA_Ball_Pixel_En: in std_logic := '0';			--Enable für aktuelles Pixel, High aktiv
	VGA_Spielfeld_Pixel_En: in std_logic := '0'; 	--Enable für aktuelles Pixel, High aktiv
	-------------------------------------------------------------
	VGA_Paddle1_Pixel_Color: in std_logic_vector(3 downto 0) := x"0";		--Farbe für aktuelles Pixel
	VGA_Paddle2_Pixel_Color: in std_logic_vector(3 downto 0) := x"0";		--Farbe für aktuelles Pixel
	VGA_Ball_Pixel_Color: in std_logic_vector(3 downto 0) := x"0";			--Farbe für aktuelles Pixel
	VGA_Spielfeld_Pixel_Color: in std_logic_vector(3 downto 0) := x"0";	--Farbe für aktuelles Pixel
	-------------------------------------------------------------
	VGA_R: out std_logic_vector(7 downto 0):= x"00";		--Farbausgabe Rot aus LUT für DAC
	VGA_G: out std_logic_vector(7 downto 0):= x"00";		--Farbausgabe Grün aus LUT für DAC
	VGA_B: out std_logic_vector(7 downto 0):= x"00" 		--Farbausgabe Blau aus LUT für DAC
	);
end entity Image_Generator;

architecture behaviour of Image_Generator is
	--variables
	signal VGA_Pixel_Color: std_logic_vector(3 downto 0) := x"0";

begin

	PixelColorProzess: process(Clk,Reset)
	begin	
		if(Reset = '1') then
			--VGA_R <= (others => '0');
			--VGA_G <= (others => '0');
			--VGA_B <= (others => '0'); 	
			VGA_Pixel_Color  <= (others => '0');
		elsif(rising_edge(Clk)) then
		
				if(ImageGen_En) then --VGA_Paddle1_Pixel_En or VGA_Paddle2_Pixel_En or VGA_Ball_Pixel_En or VGA_Spielfeld_Pixel_En) and
					if( VGA_Ball_Pixel_En ) then
						VGA_Pixel_Color <= VGA_Ball_Pixel_Color;
					elsif (VGA_Paddle1_Pixel_En) then
						VGA_Pixel_Color <= VGA_Paddle1_Pixel_Color;
					elsif (VGA_Paddle2_Pixel_En) then
						VGA_Pixel_Color <= VGA_Paddle2_Pixel_Color;
					elsif (VGA_Spielfeld_Pixel_En) then
						VGA_Pixel_Color <= VGA_Spielfeld_Pixel_Color;
					else
						VGA_Pixel_Color <= x"A"; --Background Color
					end if;
					
				else  --setze alles auf Schwarz, wenn kein Enable vorhanden ist
					VGA_Pixel_Color  <= (others => '0');
					
				end if;	
		end if;
	end process;
	
	RGB_Prozess: process(VGA_Pixel_Color)
	begin
					case VGA_Pixel_Color is
						when X"0"   => VGA_R <= (others => '0');
											VGA_G <= (others => '0');
											VGA_B <= (others => '0');
						when X"1"   => VGA_R <= (others => '0');
											VGA_G <= (others => '0');
											VGA_B <= x"AA";				--170
						when X"2"   => VGA_R <= (others => '0');
											VGA_G <= x"AA"; 
											VGA_B <= (others => '0');
						when X"3"   => VGA_R <= (others => '0');
											VGA_G <= x"AA"; 
											VGA_B <= x"AA"; 
						when X"4"   => VGA_R <= x"AA"; 
											VGA_G <= (others => '0'); 
											VGA_B <= (others => '0');
						when X"5"   => VGA_R <= x"AA"; 
											VGA_G <= (others => '0'); 
											VGA_B <= x"AA";
						when X"6"   => VGA_R <= x"AA"; 
											VGA_G <= x"55";				--85 
											VGA_B <= (others => '0'); 
						when X"7"   => VGA_R <= x"AA"; 
											VGA_G <= x"AA";
											VGA_B <= x"AA"; 
						when X"8"   => VGA_R <= x"55"; 
											VGA_G <= x"55";
											VGA_B <= x"55";
						when X"9"   => VGA_R <= x"55"; 
											VGA_G <= x"55";
											VGA_B <= x"FF";
						when X"A"   => VGA_R <= x"55"; 
											VGA_G <= x"FF";
											VGA_B <= x"55"; 
						when X"B"   => VGA_R <= x"55"; 
											VGA_G <= x"FF";
											VGA_B <= x"FF";
						when X"C"   => VGA_R <= x"FF"; 
											VGA_G <= x"55";
											VGA_B <= x"55"; 
						when X"D"   => VGA_R <= x"FF"; 
											VGA_G <= x"55";
											VGA_B <= x"FF"; 
						when X"E"   => VGA_R <= x"FF"; 
											VGA_G <= x"FF";
											VGA_B <= x"55";
						when X"F"   => VGA_R <= x"FF"; 
											VGA_G <= x"FF";
											VGA_B <= x"FF"; 
						when others => VGA_R <= (others => '0');
											VGA_G <= (others => '0');
											VGA_B <= (others => '0'); 		 
				end case;
		end process;


end architecture behaviour;