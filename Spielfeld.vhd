library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Color.all;

entity Spielfeld is

	generic 
	(
		Spielfeld_hoehe 				: integer := 600; -- 0-599  
		Spielfeld_breite  			: integer := 800; -- 0-799
	--	Netz_breite 					: integer := 10 ;
		Ball_radius 					: integer := 7;
		Netz_Color						: std_logic_vector (3 downto 0) := black
	);

	port(
		
		Goal1 							: out std_logic; -- Gibt zurück wenn Ball in Tor1  landet
		Goal2 							: out std_logic; -- Gibt zurück wenn Ball in Tor2  landet
		Boarder_colission 			: out std_logic; -- Gibt zurück wenn Ball an Bande kommt
		
		VGA_Spielfeld_Pixel_Color 	: out std_logic_vector (3 downto 0); --asynchrone Farbe für Pixel
		VGA_Spielfeld_Pixel_En 		: out std_logic; -- Gibt an, ob Pixel gezeichnet werden soll oder nicht
		
		
		
		Ball_Pos_X 						: in std_logic_vector (9 downto 0);
		Ball_Pos_Y 						: in std_logic_vector (9 downto 0);
		
		VGA_Pos_X 						: in std_logic_vector (9 downto 0);  -- aktuelle Position die in X gezeichnet wird
		VGA_Pos_Y 						: in std_logic_vector (9 downto 0)   -- aktuelle Position die in Y gezeichnet wird
		
	
	);



end Spielfeld;


architecture Behavioral of Spielfeld is

		
 -- alias	iVGA_Pos_X 	: unsigned (9 downto 0) is unsigned(VGA_Pos_X);    -- aktuelle Position die in X gezeichnet wird
 -- alias  iVGA_Pos_Y 	: unsigned (9 downto 0) is unsigned(VGA_Pos_Y);  
 -- alias  iBall_Pos_X : unsigned (9 downto 0) is unsigned(Ball_Pos_X); 	
 -- alias  iBall_Pos_Y : unsigned (9 downto 0) is unsigned(Ball_Pos_Y); 
  
 
	begin
	
		
	Netz_zeichnen: process (All) -- Netz Striche in Mitte des Spielfeldes zeichnen 
			begin
			
			-- Kommentare sind alte Ideen, die nicht in ModelSim funktionierten.
			
			
--		if (iVGA_Pos_X > 394 AND iVGA_Pos_X < 406 AND iVGA_Pos_Y > 28 AND iVGA_Pos_Y <90) then
--			VGA_Spielfeld_Pixel_Color <= Netz_Color;
--			VGA_Spielfeld_Pixel_En <= '1';
--		
		if (unsigned(VGA_Pos_X) > 394 AND unsigned(VGA_Pos_X) < 406 AND unsigned(VGA_Pos_Y) > 28 AND unsigned(VGA_Pos_Y) <90) then
			VGA_Spielfeld_Pixel_Color <= Netz_Color;
			VGA_Spielfeld_Pixel_En <= '1';
		

--		
--		elsif (iVGA_Pos_X > 394 AND iVGA_Pos_X < 406 AND iVGA_Pos_Y > 148 AND iVGA_Pos_Y <210) then
--			VGA_Spielfeld_Pixel_Color <= Netz_Color;
--			VGA_Spielfeld_Pixel_En <= '1';

		elsif (unsigned(VGA_Pos_X) > 394 AND unsigned(VGA_Pos_X) < 406 AND unsigned(VGA_Pos_Y) > 148 AND unsigned(VGA_Pos_Y) <210) then
			VGA_Spielfeld_Pixel_Color <= Netz_Color;
			VGA_Spielfeld_Pixel_En <= '1';
--		
--		
--		elsif (iVGA_Pos_X > 394 AND iVGA_Pos_X < 406 AND iVGA_Pos_Y > 268 AND iVGA_Pos_Y <330) then
--			VGA_Spielfeld_Pixel_Color <= Netz_Color;
--			VGA_Spielfeld_Pixel_En <= '1';

		elsif (unsigned(VGA_Pos_X) > 394 AND unsigned(VGA_Pos_X) < 406 AND unsigned(VGA_Pos_Y) > 268 AND unsigned(VGA_Pos_Y) <330) then
			VGA_Spielfeld_Pixel_Color <= Netz_Color;
			VGA_Spielfeld_Pixel_En <= '1';
			
--		
--		elsif (iVGA_Pos_X > 394 AND iVGA_Pos_X < 406 AND iVGA_Pos_Y > 388 AND iVGA_Pos_Y <450) then
--			VGA_Spielfeld_Pixel_Color <= Netz_Color;
--			VGA_Spielfeld_Pixel_En <= '1';

		elsif (unsigned(VGA_Pos_X) > 394 AND unsigned(VGA_Pos_X) < 406 AND unsigned(VGA_Pos_Y) > 388 AND unsigned(VGA_Pos_Y) <450) then
			VGA_Spielfeld_Pixel_Color <= Netz_Color;
			VGA_Spielfeld_Pixel_En <= '1';
--		
--		
--		elsif (iVGA_Pos_X > 394 AND iVGA_Pos_X < 406 AND iVGA_Pos_Y > 508 AND iVGA_Pos_Y <570) then
--			VGA_Spielfeld_Pixel_Color <= Netz_Color;
--			VGA_Spielfeld_Pixel_En <= '1';

		elsif (unsigned(VGA_Pos_X) > 394 AND unsigned(VGA_Pos_X) < 406 AND unsigned(VGA_Pos_Y) > 508 AND unsigned(VGA_Pos_Y) <570) then
			VGA_Spielfeld_Pixel_Color <= Netz_Color;
			VGA_Spielfeld_Pixel_En <= '1';
			
			
		else 
			VGA_Spielfeld_Pixel_Color <= x"1";
			VGA_Spielfeld_Pixel_En <= '0';	
			
		end if;
	
	end process;

Ballbewegung : process(All)  -- Ball an Bande oder Ball in Tor
	begin
	
--		if ((iBall_Pos_Y = Ball_radius)    OR    (iBall_Pos_Y = (Spielfeld_hoehe - 1) - Ball_radius)) then  -- Ball an Bande oben und unten
--			Boarder_colission	 <= '1';

		if (unsigned(Ball_Pos_Y) = Ball_radius OR unsigned(Ball_Pos_Y) = (Spielfeld_hoehe -1) - Ball_radius) then
			Boarder_colission <= '1';
	
		else 
			Boarder_colission <= '0';
		end if;
--		
--		if (iBall_Pos_X = Ball_radius) then  -- Ball im linken Tor
		if (unsigned(Ball_Pos_X) = Ball_radius) then
			Goal1 <= '1'; 
			Goal2 <= '0';
--		elsif (iBall_Pos_X = (Spielfeld_breite - 1) - Ball_radius) then -- Ball im rechten Tor
		elsif (unsigned(Ball_Pos_X) = (Spielfeld_breite - 1) - Ball_radius) then
			Goal2 <= '1';
			Goal1 <= '0';
		else  -- kein Tor
			Goal1 <= '0';
			Goal2 <= '0';
		end if;
	end process;


end architecture Behavioral;