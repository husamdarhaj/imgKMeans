
-- VHDL Instantiation Created from source file euclid.vhd -- 21:13:19 01/05/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT euclid
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;
		rdy_in : IN std_logic;
		cntrd1 : IN std_logic_vector(31 downto 0);
		cntrd2 : IN std_logic_vector(31 downto 0);
		cntrd3 : IN std_logic_vector(31 downto 0);
		din : IN std_logic_vector(31 downto 0);          
		rdy_out : OUT std_logic;
		dist1 : OUT std_logic_vector(15 downto 0);
		dist2 : OUT std_logic_vector(15 downto 0);
		dist3 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_euclid: euclid PORT MAP(
		clk => ,
		clr => ,
		rdy_in => ,
		rdy_out => ,
		dist1 => ,
		dist2 => ,
		dist3 => ,
		cntrd1 => ,
		cntrd2 => ,
		cntrd3 => ,
		din => 
	);


