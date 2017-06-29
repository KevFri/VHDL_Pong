library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Color.all;

entity PongObject is

	generic 
	(
		StartPosX 						: std_logic_vector (9 downto 0) := 10x"02F";
		StartPosY 						: std_logic_vector (9 downto 0) := 10x"02F";
		breite 							: std_logic_vector (9 downto 0) := 10x"00F";
		hoehe								: std_logic_vector (9 downto 0) := 10x"00F";
		Color								: std_logic_vector (3 downto 0) := red;
		Motion							: std_logic := '0';
		Speed								: std_logic_vector(9 downto 0) := 10x"040"
	);

	port(
		VGA_Spielfeld_Pixel_Color 	: out std_logic_vector (3 downto 0); --asynchrone Farbe für Pixel
		VGA_Spielfeld_Pixel_En 		: out std_logic; -- Gibt an, ob Pixel gezeichnet werden soll oder nicht
		
		VGA_Pos_X 						: in std_logic_vector (9 downto 0);  -- aktuelle Position die in X gezeichnet wird
		VGA_Pos_Y 						: in std_logic_vector (9 downto 0);   -- aktuelle Position die in Y gezeichnet wird
		Clk								: in std_logic
	);



end PongObject;


architecture behave of PongObject is

	signal iStartPosY : std_logic_vector(9 downto 0) := (others => '0');
	signal FrameCounter : std_logic_vector(9 downto 0) := (others => '0');

begin

Prozess: process(Clk)
begin
				
		if (rising_edge(Clk)) then
			if(Motion = '1') then
			if(unsigned(VGA_Pos_Y) = 0 and unsigned(VGA_Pos_X) = 0) then
					FrameCounter <= std_logic_vector(unsigned(FrameCounter)+1);
				if(unsigned(FrameCounter) >= unsigned(Speed)) then
					iStartPosY <= std_logic_vector(unsigned(iStartPosY)+1);
					FrameCounter <= (others => '0');
				end if;
				if((unsigned(iStartPosY)+unsigned(hoehe)) = 599) then
					iStartPosY <= (others => '0');
					FrameCounter <= (others => '0');
				end if;
			end if;
			else
			iStartPosY <= StartPosY;
			end if;

		end if;
		
		if (unsigned(VGA_Pos_X) > unsigned(StartPosX) AND unsigned(VGA_Pos_X) < (unsigned(StartPosX)+unsigned(breite)) AND unsigned(VGA_Pos_Y) > unsigned(iStartPosY) AND unsigned(VGA_Pos_Y) < (unsigned(iStartPosY)+unsigned(hoehe))) then
			VGA_Spielfeld_Pixel_Color <= Color;
			VGA_Spielfeld_Pixel_En <= '1';
		else
			VGA_Spielfeld_Pixel_En <= '0';
		end if;

end process;
end architecture behave;