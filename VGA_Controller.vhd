library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- VGA_Controller
-- Controller wurde durch Generics so entwickelt, dass er für alle gängigen VESA-Standarts verwendet werden kann
--
--Generics:
--			horizontal_sync_pulse_width:		Horizontal synchronimpuls Breite in Pixel, Maximalwert 255
--			horizontal_back_porch_width:		Horizontal back porch Breite, Maximalwert 511
--			horizontal_image_width:				Horizontal image Breite, Maximalwert 2047
--			horizontal_front_porch_width: 	Horizontal front porch Breite, Maximalwert 255
--			horizontal_sync_pulse_polarity:	Horizontal synchronimpuls Polarität (1 = posiiv, 0 = negativ)
--		
--			vertikal_sync_pulse_width:			Vertikal synchronimpuls Breite in Pixel, Maximalwert 15
--			vertikal_back_porch_width:			Vertikal back porch Breite, Maximalwert 127
--			vertikal_image_width:				Vertikal image Breite, Maximalwert 2047
--			vertikal_front_porch_width: 		Vertikal front porch Breite, Maximalwert 63
--			vertikal_sync_pulse_polarity:		Vertikal synchronimpuls Polarität (1 = posiiv, 0 = negativ)
--
--Ports:	
--			Reset: 									asynchroner Reset, High aktiv
--			Clk: in std_logic:					Taktfrequenz
--			VGA_Pos_X: 								Horizontal X Koordinate
--			VGA_Pos_Y: 								Vertikal Y Koordinate
--			VGA_HS: out std_logic:				Horizontal Synchronimpuls, High aktiv
--			VGA_VS: out std_logic:				Vertikal Synchronimpuls, High aktiv
--			ImageGen_En: out std_logic:		Enable für Image Generator, High aktiv
entity VGA_Controller is

generic( --Default-Werte für DMT ID: 0Ah Standart
	horizontal_sync_pulse_width:	integer := 120;	--Horizontal synchronimpuls Breite in Pixel, Maximalwert 255
	horizontal_back_porch_width:	integer := 64;   	--Horizontal back porch Breite, Maximalwert 511
	horizontal_image_width:			integer := 800;	--Horizontal image Breite, Maximalwert 2047
	horizontal_front_porch_width: integer := 56;		--Horizontal front porch Breite, Maximalwert 255
	horizontal_sync_pulse_polarity:std_logic := '1';--Horizontal synchronimpuls Polarität (1 = posiiv, 0 = negativ)
	----------------------------------------------------------------------
	vertikal_sync_pulse_width:	integer := 6;			--Vertikal synchronimpuls Breite in Pixel, Maximalwert 15
	vertikal_back_porch_width:	integer := 23;   		--Vertikal back porch Breite, Maximalwert 127
	vertikal_image_width:			integer := 600;	--Vertikal image Breite, Maximalwert 2047
	vertikal_front_porch_width: integer := 37;		--Vertikal front porch Breite, Maximalwert 63
	vertikal_sync_pulse_polarity:std_logic := '1'	--Vertikal synchronimpuls Polarität (1 = posiiv, 0 = negativ)
);

port(
	Reset: in std_logic;										--asynchroner Reset, High aktiv
	Clk: in std_logic;										--50MHz Clock
	-------------------------------------------------------------
	VGA_Pos_X: out std_logic_vector(9 downto 0);		--Horizontal X Koordinate
	VGA_Pos_Y: out std_logic_vector(9 downto 0);		--Vertikal Y Koordinate
	-------------------------------------------------------------
	VGA_HS: out std_logic;									--Horizontal Synchronimpuls, High aktiv
	VGA_VS: out std_logic;									--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	ImageGen_En: out std_logic								--Enable für Image Generator, High aktiv
	);


end entity VGA_Controller;


architecture behaviour of VGA_Controller is

constant horizontal_period : unsigned(12 downto 0) := to_unsigned(horizontal_image_width+horizontal_front_porch_width+horizontal_sync_pulse_width+horizontal_back_porch_width,13);		--Horizontal Periodenlänge in Pixel
constant vertikal_period   : unsigned(12 downto 0) := to_unsigned(vertikal_image_width + vertikal_front_porch_width + vertikal_sync_pulse_width + vertikal_back_porch_width,13);			--Vertikal Periodenlänge in Pixel


begin
	Prozess: process (Clk, Reset)	
	variable horizontal_count  : unsigned(12 downto 0) := (others =>'0'); 		--Horizontal Counter
	variable vertikal_count    : unsigned(12 downto 0) := to_unsigned(0,13) ; 	--Vertikal Counter

	begin
		if(Reset = '1') then --asynchroner Reset
			horizontal_count := (others => '0');
			vertikal_count := (others => '0');
			VGA_HS <= NOT horizontal_sync_pulse_polarity;
			VGA_VS <= NOT vertikal_sync_pulse_polarity;
			ImageGen_En <= '0';
			VGA_Pos_X <= (others => '0');
			VGA_Pos_Y <= (others => '0');
			
		elsif(rising_edge(Clk)) then
		
			-- Horizontal und Vertikal Counter
			if(horizontal_count < horizontal_period-1) then 	--Horizontal Counter (Pixel)
				horizontal_count := horizontal_count + 1;			--wird mit jedem Taktzyklus erhöht und am ende der Zeile zurückgesetzt
			else
				horizontal_count := (others => '0');
				if(vertikal_count < vertikal_period-1) then 		--Vertikal Counter (Zeilen)
					vertikal_count := vertikal_count + 1;			--vertikal Counter wird erhöht, wenn horizontal_count seinen Maximalwert erreicht hat
				else
					vertikal_count := (others => '0');				--Frame wurde fertig gezeichnet
				end if;			
			end if;
			
			
			--erzeugen des Horizontal Synchronimpuls
			if((horizontal_count < (to_unsigned(horizontal_image_width + horizontal_front_porch_width,13))) OR( horizontal_count >= (to_unsigned(horizontal_image_width + horizontal_front_porch_width + horizontal_sync_pulse_width,13)))) then
				VGA_HS <= NOT horizontal_sync_pulse_polarity;
			else
				VGA_HS <= horizontal_sync_pulse_polarity;
			end if;			
		
			--erzeugen des Vertikal Synchronimpuls
			if((vertikal_count < to_unsigned(vertikal_image_width + vertikal_front_porch_width,13)) OR( vertikal_count >= to_unsigned(vertikal_image_width + vertikal_front_porch_width + vertikal_sync_pulse_width,13))) then
				VGA_VS <= NOT vertikal_sync_pulse_polarity;
			else
				VGA_VS <= vertikal_sync_pulse_polarity;
			end if;
			
			--erzeugen der Positionen VGA Pos X
			if(horizontal_count < to_unsigned(horizontal_image_width,13)) then
				VGA_Pos_X <= std_logic_vector(horizontal_count(9 downto 0));
			end if;
			
			--erzeugen der Positionen VGA Pos Y
			if(vertikal_count < to_unsigned(vertikal_image_width,13)) then
				VGA_Pos_Y <= std_logic_vector(vertikal_count(9 downto 0));
			end if;
						
			--Image Generator Enable, aktivieren des Image_Generators während der "aktiven Video Phase"
			if(horizontal_count < to_unsigned(horizontal_image_width,13) AND vertikal_count < to_unsigned(vertikal_image_width,13)) then
				ImageGen_En <= '1';
			else
				ImageGen_En <= '0';
			end if;
		
		end if;
	end process;
end architecture behaviour;