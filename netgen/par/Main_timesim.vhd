--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: Main_timesim.vhd
-- /___/   /\     Timestamp: Sun Aug 07 21:44:44 2016
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -s 1 -pcf Main.pcf -rpw 100 -tpw 0 -ar Structure -tm Main -insert_pp_buffers true -w -dir netgen/par -ofmt vhdl -sim Main.ncd Main_timesim.vhd 
-- Device	: 7a100tcsg324-1 (PRODUCTION 1.10 2013-10-13)
-- Input file	: Main.ncd
-- Output file	: C:\Users\husamhaj\Desktop\Personal Projects\KMeans_img\netgen\par\Main_timesim.vhd
-- # of Entities	: 1
-- Design Name	: Main
-- Xilinx	: C:\Xilinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity Main is
  port (
    clk : in STD_LOGIC := 'X'; 
    clr : in STD_LOGIC := 'X'; 
    do : in STD_LOGIC := 'X'; 
    k : in STD_LOGIC_VECTOR ( 3 downto 0 ); 
    grp_out : out STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end Main;

architecture Structure of Main is
begin
  grp_out_7_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y142"
    )
    port map (
      I => '0',
      O => grp_out(7)
    );
  grp_out_0_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y149"
    )
    port map (
      I => '0',
      O => grp_out(0)
    );
  grp_out_2_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y147"
    )
    port map (
      I => '0',
      O => grp_out(2)
    );
  grp_out_1_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y148"
    )
    port map (
      I => '0',
      O => grp_out(1)
    );
  grp_out_4_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y145"
    )
    port map (
      I => '0',
      O => grp_out(4)
    );
  grp_out_6_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y143"
    )
    port map (
      I => '0',
      O => grp_out(6)
    );
  grp_out_5_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y144"
    )
    port map (
      I => '0',
      O => grp_out(5)
    );
  grp_out_3_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y146"
    )
    port map (
      I => '0',
      O => grp_out(3)
    );
  grp_out_14_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y135"
    )
    port map (
      I => '0',
      O => grp_out(14)
    );
  grp_out_8_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y141"
    )
    port map (
      I => '0',
      O => grp_out(8)
    );
  grp_out_12_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y137"
    )
    port map (
      I => '0',
      O => grp_out(12)
    );
  grp_out_15_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y134"
    )
    port map (
      I => '0',
      O => grp_out(15)
    );
  grp_out_9_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y140"
    )
    port map (
      I => '0',
      O => grp_out(9)
    );
  grp_out_11_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y138"
    )
    port map (
      I => '0',
      O => grp_out(11)
    );
  grp_out_10_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y139"
    )
    port map (
      I => '0',
      O => grp_out(10)
    );
  grp_out_13_OBUF : X_OBUF
    generic map(
      LOC => "IOB_X0Y136"
    )
    port map (
      I => '0',
      O => grp_out(13)
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

