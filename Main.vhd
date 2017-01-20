----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Husam Darhaj
-- 
-- Create Date:    03:35:08 07/10/2016 
-- Design Name: 
-- Module Name:    Main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- DepENDencies: 
--
-- RevISion: 
-- RevISion 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following LIBRARY declaration IF using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following LIBRARY declaration IF instantiating
-- any Xilinx primitives IN thIS code.
--LIBRARY UNISIM;
--USE UNISIM.VComponents.all;

ENTITY Main IS
    Port ( clk : IN  STD_LOGIC;
           clr , do: IN  STD_LOGIC;
          -- din : IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
			  k   : IN STD_LOGIC_VECTOR ( 7 DOWNTO 0):= x"00";
			  n   : IN STD_LOGIC_VECTOR ( 31 downto 0):= x"0000FE01";
           grp_out : OUT  STD_LOGIC_VECTOR (15 DOWNTO 0));
END Main;

architecture Behavioral of Main IS

COMPONENT RGB_Ram
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

	COMPONENT euclid
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;
		rdy_in : IN std_logic;
		cntrd : IN std_logic_vector(31 downto 0);
		din : IN std_logic_vector(31 downto 0);          
		rdy_out : OUT std_logic;
		dist : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;


CONSTANT p : NATURAL := 3;
--CONSTANT n : NATURAL := 1000;
--SIGNAL c_addra : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL RGB_addra : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL RGB_wea: STD_LOGIC_VECTOR( 3 DOWNTO 0):= x"0";
SIGNAL RGB_dina: STD_LOGIC_VECTOR( 31 DOWNTO 0):= x"00000000";
SIGNAL RGB_douta: STD_LOGIC_VECTOR( 31 DOWNTO 0):= x"00000000";

SIGNAL i_cnt : STD_LOGIC_VECTOR (31 DOWNTO 0):= x"00000000";
SIGNAL cent1 : STD_LOGIC_VECTOR (32 DOWNTO 0):= X"000"; -- black
SIGNAL cent2 : STD_LOGIC_VECTOR (32 DOWNTO 0):= X"888"; -- grey
SIGNAL cent3 : STD_LOGIC_VECTOR (32 DOWNTO 0):= X"fff"; -- white

SIGNAL n_cnt : STD_LOGIC_VECTOR (31 DOWNTO 0):= x"00000000";
SIGNAL euc_dist : STD_LOGIC_VECTOR(7 DOWNTO 0):= x"00";
SIGNAL euc_cntrd, euc_din : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL euc_dist_cpy : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL euc_rdy_in : STD_LOGIC;
SIGNAL euc_rdy_out: STD_LOGIC;
TYPE StateType IS ( 
                    ST_IDLE,
                    ST_GEN_CNTRD,
                    ST_FTCH,
						  ST_SND,
						  
						  ST_CMPR,
						  --ST_AVG,
						  ST_FNL
						 );
SIGNAL state : StateType;                 

BEGIN

grp_out <= x"0000";

 state_PROCESS:PROCESS(clr, clk, state, k, do)
                BEGIN
                     IF(clr = '1') THEN state <= ST_IDLE;
                     ELSIF(clk'event AND clk = '1') THEN
							
                      CASE state IS 
                        WHEN ST_IDLE => IF ( do = '0') THEN 
                              state <= ST_GEN_CNTRD; 
		                     ELSE
                              state <= ST_IDLE; END IF;
										
                        WHEN ST_GEN_CNTRD =>  state <= ST_FTCH; 
										
                        WHEN ST_FTCH => state <= ST_SND; 
		                                   
								WHEN ST_SND => if( euc_rdy_out = '1') then state <= ST_CMPR; else state <= ST_SND; END IF;
								when ST_CMPR => if(n_cnt = n - x"4") then state <= ST_FNL; else state <= ST_CMPR; END IF;
								WHEN ST_FNL  => state <= ST_IDLE;


                       END CASE;
                       END IF;
                   END PROCESS;
                       

n_cnt    :PROCESS(clk, clr, state)
               BEGIN
                    IF(clr = '1' or state = ST_IDLE) THEN 
                          n_cnt <= x"00000000" ; 								  
                    ELSIF(clk'event AND clk = '1') THEN
                       IF( state = ST_CMPR ) THEN  
							     if( n_cnt = n) then
                                n_cnt <= x"00000000" ;
										  ELSE
                  			n_cnt <= n_cnt + x"4";
									
                         
                          END IF;									
                       END IF;
                    END IF;
               END PROCESS;					

state_PROCESS2 :PROCESS( clk, state)
                 BEGIN
                      IF(clk'event AND clk = '1') THEN
                       IF( state = ST_IDLE) THEN
                          c_wea <= x"0";
                          RGB_wea <= x"0";
                        
                        ELSIF( state = ST_GEN_CNTRD) THEN
                            c_wea <= x"f";
                            c_addra <=  i_cnt;
                            RGB_addra <= i_cnt(26 DOWNTO 0) & "00000";
                            c_dina <= RGB_douta;

                         ELSIF( state = ST_FTCH) THEN 
                            c_wea <= x"0";
								 ELSIF( state = ST_SND) then
								     RGB_addra <= n_cnt ;
									  c_addra <= k_cnt;
									  euc_cntrd <= c_douta;
									  euc_din <= RGB_douta;
								 ELSIF( state <= ST_CMPR) then
								    euc_rdy_in <= '1';  
								 
                         END IF;
                       END IF;
                   END PROCESS;


your_instance_name : RGB_Ram
  PORT MAP (
		 clka => clk,
		 wea => RGB_wea,
		 addra => RGB_addra,
		 dina => RGB_dina,
		 douta => RGB_douta
  );


	Inst_euclid: euclid PORT MAP(
		clk => clk,
		clr => clr,
		rdy_in => euc_rdy_in ,
		rdy_out => euc_rdy_out ,
		dist => euc_dist ,
		cntrd => euc_cntrd,
		din => euc_din
	);
END Behavioral;
