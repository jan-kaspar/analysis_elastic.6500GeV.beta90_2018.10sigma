import root;
import pad_layout;
include "../run_info.asy";

string topDir = "../../";

string dataset = "DS-TOTEM1-347";

string units[] = { "L_2_F", "L_1_F", "R_1_F", "R_2_F" };
string unit_labels[] = { "45-220-fr", "45-210-fr", "56-210-fr", "56-220-fr" };

//string units[] = { "L_2_F", "L_2_N" };
//string unit_labels[] = { "Left Far", "Left Near" };

xSizeDef = 10cm;
drawGridDef = true;

TGraph_errorBar = None;

string period = "period 3";

//----------------------------------------------------------------------------------------------------

NewPad(false);
label("\vbox{\hbox{" + dataset + "}\hbox{" + period + "}}");

//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("$y\ung{mm}$", "$\hbox{mean } x\ung{mm}$");

	draw(RootGetObject(topDir+dataset+"/alignment.root", period + "/unit "+units[ui]+"/horizontal/horizontal profile/p"), "d0,eb", blue);
	draw(RootGetObject(topDir+dataset+"/alignment.root", period + "/unit "+units[ui]+"/horizontal/horizontal profile/p|ff"), "l", red+1pt);
	

	//limits((time_min, -10), (time_max, +10), Crop);
	AttachLegend(unit_labels[ui], SE, SE);
}

//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("$y\ung{mm}$", "");
	scale(Linear, Log);

	draw(RootGetObject(topDir+dataset+"/alignment.root", period + "/unit "+units[ui]+"/vertical/y_hist|y_hist"), "d0,vl", blue);
	draw(RootGetObject(topDir+dataset+"/alignment.root", period + "/unit "+units[ui]+"/vertical/y_hist|y_hist_range"), "d0,vl", red);

	limits((-30, 1), (+30, 1e3), Crop);
	//limits((-6, 1), (+6, 1e3), Crop);
	AttachLegend(unit_labels[ui], SE, SE);
}


//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("$\de y\ung{mm}$", "");

	draw(RootGetObject(topDir+dataset+"/alignment.root", period + "/unit "+units[ui]+"/vertical/g_max_diff"), "l,p", heavygreen, mCi+1pt+heavygreen);

	limits((-1, 0), (+1, 0.3), Crop);
	AttachLegend(unit_labels[ui], SE, SE);
}
