library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity VGA_Controller is

generic(
	horizontal_sync_pulse_width:	integer := 120;	--Horizontal synchronimpuls Breite in Pixel, Maximalwert 255
	horizontal_back_porch_width:	integer := 64;   	--Horizontal back porch Breite, Maximalwert 511
	horizontal_image_width:			integer := 800;	--Horizontal image Breite, Maximalwert 2047
	horizontal_front_porch_width: integer := 56;		--Horizontal front porch Breite, Maximalwert 255
	horizontal_sync_pulse_polariy:std_logic := '1';	--Horizontal synchronimpuls Polarität (1 = posiiv, 0 = negativ)
	----------------------------------------------------------------------
	vertikal_sync_pulse_width:	integer := 6;			--Vertikal synchronimpuls Breite in Pixel, Maximalwert 15
	vertikal_back_porch_width:	integer := 23;   		--Vertikal back porch Breite, Maximalwert 127
	vertikal_image_width:			integer := 600;	--Vertikal image Breite, Maximalwert 2047
	vertikal_front_porch_width: integer := 37;		--Vertikal front porch Breite, Maximalwert 63
	vertikal_sync_pulse_polariy:std_logic := '1'		--Vertikal synchronimpuls Polarität (1 = posiiv, 0 = negativ)
);

port(
	Reset: in std_logic;		--asynchroner Reset, High aktiv
	Clk: in std_logic;		--50MHz Clock
	-------------------------------------------------------------
	VGA_Pos_X: out std_logic_vector(9 downto 0);		--Horizontal X Koordinate
	VGA_Pos_Y: out std_logic_vector(9 downto 0);		--Vertikal Y Koordinate
	-------------------------------------------------------------
	VGA_HS: out std_logic;		--Horizontal Synchronimpuls, High aktiv
	VGA_VS: out std_logic;		--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	ImageGen_En: out std_logic		--Enable für Image Generator, High aktiv
	);


end entity VGA_Controller;


architecture behaviour of VGA_Controller is

constant horizontal_period : unsigned(12 downto 0) := to_unsigned(horizontal_image_width+horizontal_front_porch_width+horizontal_sync_pulse_width+horizontal_back_porch_width,13);		--Horizontal Periodenlänge in Pixel
constant vertikal_period   : unsigned(12 downto 0) := to_unsigned(vertikal_image_width + vertikal_front_porch_width + vertikal_sync_pulse_width + vertikal_back_porch_width,13);			--Vertikal Periodenlänge in Pixel


begin
	Prozess: process (Clk, Reset)	
	variable horizontal_count  : unsigned(12 downto 0) := (others =>'0'); --Horizontal Counter
	variable vertikal_count    : unsigned(12 downto 0) := to_unsigned(0,13) ; --Vertikal Counter

	begin
		if(Reset = '1') then
			horizontal_count := (others => '0');
			vertikal_count := (others => '0');
			VGA_HS <= NOT horizontal_sync_pulse_polariy;
			VGA_VS <= NOT vertikal_sync_pulse_polariy;
			ImageGen_En <= '0';
			VGA_Pos_X <= (others => '0');
			VGA_Pos_Y <= (others => '0');
			
		elsif(rising_edge(Clk)) then
		
			-- Horizontal und Vertikal Counter
			if(horizontal_count < horizontal_period-1) then --Horizontal Counter (Pixel)
				horizontal_count := horizontal_count + 1;
			else
				horizontal_count := (others => '0');
				if(vertikal_count < vertikal_period-1) then --Vertikal Counter (Zeilen)
					vertikal_count := vertikal_count + 1;
				else
					vertikal_count := (others => '0');
				end if;			
			end if;
			
			
			--Horizontal Synchronimpuls
			if((horizontal_count < (to_unsigned(horizontal_image_width + horizontal_front_porch_width,13))) OR( horizontal_count >= (to_unsigned(horizontal_image_width + horizontal_front_porch_width + horizontal_sync_pulse_width,13)))) then
				VGA_HS <= NOT horizontal_sync_pulse_polariy;
			else
				VGA_HS <= horizontal_sync_pulse_polariy;
			end if;
			
		
			--Vertikal Synchronimpuls
			if((vertikal_count < to_unsigned(vertikal_image_width + vertikal_front_porch_width,13)) OR( vertikal_count >= to_unsigned(vertikal_image_width + vertikal_front_porch_width + vertikal_sync_pulse_width,13))) then
				VGA_VS <= NOT vertikal_sync_pulse_polariy;
			else
				VGA_VS <= vertikal_sync_pulse_polariy;
			end if;
			
			
			--VGA Pos X
			if(horizontal_count < to_unsigned(horizontal_image_width,13)) then
				VGA_Pos_X <= std_logic_vector(horizontal_count(9 downto 0));
			end if;
			
			--VGA Pos Y
			if(vertikal_count < to_unsigned(vertikal_image_width,13)) then
				VGA_Pos_Y <= std_logic_vector(vertikal_count(9 downto 0));
			end if;
			
			
			--Image Generator Enable
			if(horizontal_count < to_unsigned(horizontal_image_width,13) AND vertikal_count < to_unsigned(vertikal_image_width,13)) then
				ImageGen_En <= '1';
			else
				ImageGen_En <= '0';
			end if;
		
		end if;
	end process;
end architecture behaviour;






















