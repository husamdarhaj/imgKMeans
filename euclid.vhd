----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:06:27 08/14/2016 
-- Design Name: 
-- Module Name:    euclid - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity euclid is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           rdy_in : in  STD_LOGIC;
           rdy_out : out  STD_LOGIC;
           dist1 : out  STD_LOGIC_VECTOR (15 downto 0);
			  dist2 : out  STD_LOGIC_VECTOR (15 downto 0);
			  dist3 : out  STD_LOGIC_VECTOR (15 downto 0);
           din   : in  STD_LOGIC_VECTOR (31 downto 0)
			  );
end euclid;

architecture Behavioral of euclid is

signal R, R1, R2, R3, G, G1, G2, G3, B, B1, B2, B3 : std_logic_vector (4 downto 0);
signal distx1, disty1, distz1 : std_logic_vector(4 downto 0);
signal distx2, disty2, distz2 : std_logic_vector(4 downto 0);
signal distx3, disty3, distz3 : std_logic_vector(4 downto 0);
signal xsq1, ysq1, zsq1 : std_logic_vector(9 downto 0);
signal xsq2, ysq2, zsq2 : std_logic_vector(9 downto 0);
signal xsq3, ysq3, zsq3 : std_logic_vector(9 downto 0);
signal d1,d2,d3 : std_logic_vector(13 downto 0);

SIGNAL cntrd1 : STD_LOGIC_VECTOR (31 DOWNTO 0):= X"00000000"; -- black
SIGNAL cntrd2 : STD_LOGIC_VECTOR (31 DOWNTO 0):= X"00000888"; -- grey
SIGNAL cntrd3 : STD_LOGIC_VECTOR (31 DOWNTO 0):= X"00000fff"; -- white

--signal und_sqr: STD_LOGIC_VECTOR( 15 downto 0);
signal s_valid_out1, s_valid_out2, s_valid_out3, s_valid_out: STD_LOGIC:= '0';
signal s_valid_in : STD_LOGIC:= '0';
signal s_dout1: STD_LOGIC_VECTOR(15 DOWNTO 0):= x"0000";
signal s_dout2: STD_LOGIC_VECTOR(15 DOWNTO 0):= x"0000";
signal s_dout3: STD_LOGIC_VECTOR(15 DOWNTO 0):= x"0000";

signal s_din1 : STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";
signal s_din2 : STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";
signal s_din3 : STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";

TYPE FSM IS(   STANDBY,
				 RD_DATA,
				 ST_SEND
				 );
signal state : FSM;		 
COMPONENT sqrt
  PORT (
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

COMPONENT sqrt2
  PORT (
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

COMPONENT sqrt3
  PORT (
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;


begin
R <= '0' & din(11 downto 8);
G <= '0' & din(7 downto 4);
B <= '0' & din(3 downto 0);

R1 <= '0' & cntrd1(11 downto 8);
G1 <= '0' & cntrd1(7 downto 4);
B1 <= '0' & cntrd1(3 downto 0);

R2 <= '0' & cntrd2(11 downto 8);
G2 <= '0' & cntrd2(7 downto 4);
B2 <= '0' & cntrd2(3 downto 0);

R3 <= '0' & cntrd3(11 downto 8);
G3 <= '0' & cntrd3(7 downto 4);
B3 <= '0' & cntrd3(3 downto 0);


distx1 <= R - R1 ;
disty1 <= G - G1 ;
distz1 <= B - B1 ;

distx2 <= R - R2 ;
disty2 <= G - G2 ;
distz2 <= B - B2 ;

distx3 <= R - R3 ;
disty3 <= G - G3 ;
distz3 <= B - B3 ;

xsq1 <= distx1 * distx1;
ysq1 <= disty1 * disty1;
zsq1 <= distz1 * distz1;

xsq2 <= distx2 * distx2;
ysq2 <= disty2 * disty2;
zsq2 <= distz2 * distz2;

xsq3 <= distx3 * distx3;
ysq3 <= disty3 * disty3;
zsq3 <= distz3 * distz3;

d1 <=  (x"0" & xsq1) + (x"0" & ysq1 )+ (x"0" & zsq1);
d2 <=  (x"0" & xsq2) + (x"0" & ysq2 )+ (x"0" & zsq2);
d3 <=  (x"0" & xsq3) + (x"0" & ysq3 )+ (x"0" & zsq3); 

s_din1 <= "00" & d1;
s_din2 <= "00" & d2;
s_din3 <= "00" & d3;

dist1 <= s_dout1;
dist2 <= s_dout2;
dist3 <= s_dout3;

s_valid_out <= s_valid_out1 and s_valid_out2 and s_valid_out3;

state_proc1: process(clk, clr, rdy_in, state, s_valid_out)
              begin
               if clr = '1' or rdy_in = '0' then state <= STANDBY;
            elsif clk'event and clk = '1' then 
                case state is
                    when STANDBY =>
          						  if( rdy_in = '1' ) then 
									       state <= RD_DATA; 
										else state <= STANDBY; 
							         end if;
                    when RD_DATA => 
						            if( s_valid_out = '1') then 
										     state <= ST_SEND; 
									   else state <= RD_DATA;
										end if;
                    when ST_SEND => state <= STANDBY;
                end case;
               end if; 
             end process;

state_proc2: process( clk, clr, state)
              begin
               if clk'event and clk = '1' then 
                if( state = STANDBY ) then 
                                        rdy_out <= '0';
                                        s_valid_in <= '0';

                elsif(state = RD_DATA) then
                                        s_valid_in <= '1';
                elsif( state = ST_SEND) then
					                          rdy_out <= '1';
					else null;

                end if;
               end if;
             end process; 

your_instance_name : sqrt
  PORT MAP (
    s_axis_cartesian_tvalid => s_valid_in,
    s_axis_cartesian_tdata => s_din1,
    m_axis_dout_tvalid => s_valid_out1,
    m_axis_dout_tdata => s_dout1
  );
  
  your_instance_name2 : sqrt2
  PORT MAP (
    s_axis_cartesian_tvalid => s_valid_in,
    s_axis_cartesian_tdata => s_din2,
    m_axis_dout_tvalid => s_valid_out2,
    m_axis_dout_tdata => s_dout2
  );
  
    your_instance_name3 : sqrt3
  PORT MAP (
    s_axis_cartesian_tvalid => s_valid_in,
    s_axis_cartesian_tdata => s_din3,
    m_axis_dout_tvalid => s_valid_out3,
    m_axis_dout_tdata => s_dout3
  );
end Behavioral;


