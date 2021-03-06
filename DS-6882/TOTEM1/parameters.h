#include "parameters_global.h"

void Init_base()
{
	// load global settings
	Init_global();

	ApplyTOTEM1Settings();

	// list of (sub-)directories with distilled ntuples
	distilledNtuples.push_back(".");
}

//----------------------------------------------------------------------------------------------------

void Init_45b_56t()
{
	Init_global_45b_56t();

	// analysis settings
	anal.cut1_a = 1.; anal.cut1_c = +3.5E-6; anal.cut1_si = 10E-6;
	anal.cut2_a = 1.; anal.cut2_c = +1.1E-6; anal.cut2_si = 2.5E-6;

	anal.cut7_a = -1250.; anal.cut7_c = -0.033; anal.cut7_si = 0.01;
}

//----------------------------------------------------------------------------------------------------

void Init_45t_56b()
{
	Init_global_45t_56b();

	anal.cut1_a = 1.; anal.cut1_c = -6.4E-6; anal.cut1_si = 10E-6;
	anal.cut2_a = 1.; anal.cut2_c = +1.3E-6; anal.cut2_si = 2.5E-6;

	anal.cut7_a = -1250.; anal.cut7_c = -0.005; anal.cut7_si = 0.01;
}
