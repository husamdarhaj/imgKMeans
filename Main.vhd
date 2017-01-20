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
		din : IN std_logic_vector(31 downto 0);          
		rdy_out : OUT std_logic;
		dist1 : OUT std_logic_vector(15 downto 0);
		dist2 : OUT std_logic_vector(15 downto 0);
		dist3 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;


CONSTANT p : NATURAL := 3;
--CONSTANT n : NATURAL := 1000;
--SIGNAL c_addra : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL RGB_addra : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL RGB_wea: STD_LOGIC_VECTOR( 3 DOWNTO 0):= x"0";
SIGNAL RGB_dina: STD_LOGIC_VECTOR( 31 DOWNTO 0):= x"00000000";
SIGNAL RGB_douta: STD_LOGIC_VECTOR( 31 DOWNTO 0):= x"00000000";

--SIGNAL i_cnt : STD_LOGIC_VECTOR (31 DOWNTO 0):= x"00000000";

SIGNAL n_cnt : STD_LOGIC_VECTOR (31 DOWNTO 0):= x"00000000";
SIGNAL euc_dist1 : STD_LOGIC_VECTOR(15 DOWNTO 0):= x"0000";
SIGNAL euc_dist2 : STD_LOGIC_VECTOR(15 DOWNTO 0):= x"0000";
SIGNAL euc_dist3 : STD_LOGIC_VECTOR(15 DOWNTO 0):= x"0000";
SIGNAL euc_din : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL euc_dist_cpy : STD_LOGIC_VECTOR(31 DOWNTO 0):= x"00000000";
SIGNAL euc_rdy_in : STD_LOGIC;
SIGNAL euc_rdy_out: STD_LOGIC;
TYPE StateType IS ( 
                    ST_IDLE,
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
                              state <= ST_FTCH; 
		                     ELSE
                              state <= ST_IDLE; END IF;
										
                        WHEN ST_FTCH => state <= ST_SND; 
		                                   
								WHEN ST_SND => if( euc_rdy_out = '1') then state <= ST_CMPR; else state <= ST_SND; END IF;
								when ST_CMPR =>  state <= ST_FNL; 
								WHEN ST_FNL  =>if(n_cnt >= n - x"4") then state <= ST_IDLE; else state <= ST_FTCH; END IF;


                       END CASE;
                       END IF;
                   END PROCESS;
                       

n_cnt_proc :PROCESS(clk, clr, state)
               BEGIN
                    IF( state = ST_IDLE) THEN 
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
					
euc_din <= RGB_douta;
RGB_addra <= n_cnt ;

state_PROCESS2 :PROCESS( clk, state)
                 BEGIN
                      IF(clk'event AND clk = '1') THEN
                       IF( state = ST_IDLE) THEN
                          RGB_wea <= x"0";
                          
								 ELSIF( state = ST_SND) then
								     euc_rdy_in <= '1';
								 ELSIF( state = ST_CMPR ) THEN
								      euc_rdy_in <= '0';
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
		dist1 => euc_dist1 ,
		dist2 => euc_dist2 ,
		dist3 => euc_dist3 ,
		din => euc_din
	);
END Behavioral;
