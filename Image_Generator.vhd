library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Color.all;




entity Image_Generator is

generic(
	Background_Color : std_logic_vector(3 downto 0) := white
);
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
begin	

end entity Image_Generator;

architecture behaviour of Image_Generator is
	--variables
	signal VGA_Pixel_Color: std_logic_vector(3 downto 0) := white;

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
						VGA_Pixel_Color <= Background_Color; --Background Color
					end if;
					
				else  --setze alles auf Schwarz, wenn kein Enable vorhanden ist
					VGA_Pixel_Color  <= (others => '0');
					
				end if;	
		end if;
	end process;
	
	RGB_Prozess: process(VGA_Pixel_Color)
	begin
					case VGA_Pixel_Color is
						when black   			=> 	VGA_R <= (others => '0');
															VGA_G <= (others => '0');
															VGA_B <= (others => '0');
						when blue   			=> 	VGA_R <= (others => '0');
															VGA_G <= (others => '0');
															VGA_B <= x"AA";				--170
						when green   			=> 	VGA_R <= (others => '0');
															VGA_G <= x"AA"; 
															VGA_B <= (others => '0');
						when cyan   			=> 	VGA_R <= (others => '0');
															VGA_G <= x"AA"; 
															VGA_B <= x"AA"; 
						when red   				=> 	VGA_R <= x"AA"; 
															VGA_G <= (others => '0'); 
															VGA_B <= (others => '0');
						when magenta   		=> 	VGA_R <= x"AA"; 
															VGA_G <= (others => '0'); 
															VGA_B <= x"AA";
						when brown   			=> 	VGA_R <= x"AA"; 
															VGA_G <= x"55";				--85 
															VGA_B <= (others => '0'); 
						when gray   			=> 	VGA_R <= x"AA"; 
															VGA_G <= x"AA";
															VGA_B <= x"AA"; 
						when dark_gray   		=> 	VGA_R <= x"55"; 
															VGA_G <= x"55";
															VGA_B <= x"55";
						when ligth_blue   	=>		VGA_R <= x"55"; 
															VGA_G <= x"55";
															VGA_B <= x"FF";
						when ligth_green   	=> 	VGA_R <= x"55"; 
															VGA_G <= x"FF";
															VGA_B <= x"55"; 
						when ligth_cyan   	=> 	VGA_R <= x"55"; 
															VGA_G <= x"FF";
															VGA_B <= x"FF";
						when ligth_red  		=> 	VGA_R <= x"FF"; 
															VGA_G <= x"55";
															VGA_B <= x"55"; 
						when ligth_magenta   => 	VGA_R <= x"FF"; 
															VGA_G <= x"55";
															VGA_B <= x"FF"; 
						when yellow   			=> 	VGA_R <= x"FF"; 
															VGA_G <= x"FF";
															VGA_B <= x"55";
						when white   			=> 	VGA_R <= x"FF"; 
															VGA_G <= x"FF";
															VGA_B <= x"FF"; 
						when others 			=> 	VGA_R <= (others => '0');
															VGA_G <= (others => '0');
															VGA_B <= (others => '0');										
				end case;
		end process;
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
end architecture behaviour;