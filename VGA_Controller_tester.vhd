library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Controller_tester is

port(
	Reset: out std_logic;		--asynchroner Reset, High aktiv
	Clk: out std_logic;		--50MHz Clock
	-------------------------------------------------------------
	VGA_Pos_X: in std_logic_vector(9 downto 0);		--Horizontal X Koordinate
	VGA_Pos_Y: in std_logic_vector(9 downto 0);		--Vertikal Y Koordinate
	-------------------------------------------------------------
	VGA_HS: in std_logic;		--Horizontal Synchronimpuls, High aktiv
	VGA_VS: in std_logic;		--Vertikal Synchronimpuls, High aktiv
	-------------------------------------------------------------
	ImageGen_En: in std_logic		--Enable für Image Generator, High aktiv
	);


end entity VGA_Controller_tester;


architecture behaviour of VGA_Controller_tester is
	signal iClk: std_logic := '0';

begin

process

begin

	Reset <= '1';
	wait for 20 ns;
	
	Reset <= '0';
	wait for 14 ms;
	
	
end process;
	
	
iClk <= not iClk after 10 ns; --für 50MHz
Clk <= iClk;

end architecture behaviour;