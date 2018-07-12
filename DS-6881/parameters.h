#include "parameters_global.h"

void Init_base()
{
	// load global settings
	Init_global();

	// list of (sub-)directories with distilled ntuples
	distilledNtuples.push_back(".");
}

//----------------------------------------------------------------------------------------------------

void Init_45b_56t()
{
	Init_global_45b_56t();
}

//----------------------------------------------------------------------------------------------------

void Init_45t_56b()
{
	Init_global_45t_56b();
}
