/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *XILINXCORELIB_P_1837083571;
char *IEEE_P_1242562249;
char *XILINXCORELIB_P_2265558964;
char *IEEE_P_2592010699;
char *XILINXCORELIB_P_1494456928;
char *IEEE_P_3972351953;
char *STD_STANDARD;
char *XILINXCORELIB_P_2342578331;
char *XILINXCORELIB_P_2183896384;
char *STD_TEXTIO;
char *XILINXCORELIB_P_3155556343;
char *IEEE_P_3499444699;
char *XILINXCORELIB_P_1556348217;
char *XILINXCORELIB_P_3743709326;
char *XILINXCORELIB_P_4233351403;
char *IEEE_P_0774719531;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_0774719531_init();
    ieee_p_1242562249_init();
    std_textio_init();
    xilinxcorelib_p_1837083571_init();
    xilinxcorelib_p_3155556343_init();
    xilinxcorelib_p_1494456928_init();
    ieee_p_3972351953_init();
    xilinxcorelib_p_4233351403_init();
    xilinxcorelib_p_2265558964_init();
    xilinxcorelib_p_2342578331_init();
    xilinxcorelib_p_2183896384_init();
    xilinxcorelib_p_1556348217_init();
    xilinxcorelib_p_3743709326_init();
    xilinxcorelib_a_2954457130_3212880686_init();
    xilinxcorelib_a_1434960732_3212880686_init();
    xilinxcorelib_a_1994389728_3212880686_init();
    xilinxcorelib_a_1650256458_3212880686_init();
    work_a_3300223489_0168160707_init();
    work_a_1424139744_2674888595_init();
    work_a_1134145955_2662196644_init();
    work_a_0703335757_3212880686_init();


    xsi_register_tops("work_a_0703335757_3212880686");

    XILINXCORELIB_P_1837083571 = xsi_get_engine_memory("xilinxcorelib_p_1837083571");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    XILINXCORELIB_P_2265558964 = xsi_get_engine_memory("xilinxcorelib_p_2265558964");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    XILINXCORELIB_P_1494456928 = xsi_get_engine_memory("xilinxcorelib_p_1494456928");
    IEEE_P_3972351953 = xsi_get_engine_memory("ieee_p_3972351953");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    XILINXCORELIB_P_2342578331 = xsi_get_engine_memory("xilinxcorelib_p_2342578331");
    XILINXCORELIB_P_2183896384 = xsi_get_engine_memory("xilinxcorelib_p_2183896384");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    XILINXCORELIB_P_3155556343 = xsi_get_engine_memory("xilinxcorelib_p_3155556343");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    XILINXCORELIB_P_1556348217 = xsi_get_engine_memory("xilinxcorelib_p_1556348217");
    XILINXCORELIB_P_3743709326 = xsi_get_engine_memory("xilinxcorelib_p_3743709326");
    XILINXCORELIB_P_4233351403 = xsi_get_engine_memory("xilinxcorelib_p_4233351403");
    IEEE_P_0774719531 = xsi_get_engine_memory("ieee_p_0774719531");

    return xsi_run_simulation(argc, argv);

}
