import root;
import pad_layout;
include "../run_info.asy";

string topDir = "../../";

string datasets[] = { "DS-TOTEM1-347" };

string units[];
string unit_labels[];
real a_cens[], b_cens[], c_cens[];

units.push("L_2_F"); unit_labels.push("45-220-fr"); a_cens.push(-1); b_cens.push(240); c_cens.push(35);
units.push("L_1_F"); unit_labels.push("45-210-fr"); a_cens.push(-1.5); b_cens.push(620); c_cens.push(230);

units.push("R_1_F"); unit_labels.push("56-210-fr"); a_cens.push(0); b_cens.push(+40); c_cens.push(-400);
units.push("R_2_F"); unit_labels.push("56-220-fr"); a_cens.push(-1); b_cens.push(+800); c_cens.push(-570);


xSizeDef = 12cm;
xTicksDef = LeftTicks(Step=1, step=0.5);
drawGridDef = true;


TGraph_errorBar = None;

real time_min = 5.0;
real time_max = 7.5;

//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("time $\ung{h}$", "tilt $\ung{mrad}$", axesAbove=false);
	currentpad.yTicks = RightTicks(1., 0.5);
	real y_min = a_cens[ui] - 3, y_max = a_cens[ui] + 3;
	DrawRunBands(y_min, y_max);

	for (int di : datasets.keys)
	{
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/a_p"), "p,l,eb", cyan, mCi+1pt+cyan);
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/a_g"), "p,l,eb", green, mCi+1pt+green);
		
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/a"), "p,l,eb", blue, mCi+1pt+blue);

		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/a_fit"), "l", red+1.5pt);
		real unc = 1;
		draw(shift(0, +unc)*swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/a_fit"), "l", red+dashed);
		draw(shift(0, -unc)*swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/a_fit"), "l", red+dashed);
	}

	limits((time_min, y_min), (time_max, y_max), Crop);
	AttachLegend(unit_labels[ui], SE, SE);
}

//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("time $\ung{h}$", "horizontal position $\ung{\mu m}$", axesAbove=false);
	currentpad.yTicks = RightTicks(10., 5.);
	real y_min = b_cens[ui] - 50, y_max = b_cens[ui] + 50;
	DrawRunBands(y_min, y_max);

	/*
	TGraph_reducePoints = 30;
	draw(unixToHours * shift(0, sh_x[ui]), RootGetObject("bpm.root", "LHC.BOFSU:POSITIONS_H::"+bpms[ui]), black);
	TGraph_reducePoints = 1; 
	*/

	for (int di : datasets.keys)
	{
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/b_p"), "p,l,eb", cyan, mCi+1pt+cyan);
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/b_g"), "p,l,eb", green, mCi+1pt+green);

		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/b"), "p,l,eb", blue+1pt, mCi+1pt+blue);

		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/b_fit"), "l", red+1.5pt);
		real unc = 10;
		draw(shift(0, +unc)*swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/b_fit"), "l", red+dashed);
		draw(shift(0, -unc)*swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/b_fit"), "l", red+dashed);
	}
	
	limits((time_min, y_min), (time_max, y_max), Crop);
	AttachLegend(unit_labels[ui], SE, SE);
}

//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("time $\ung{h}$", "vertical position $\ung{\mu m}$", axesAbove=false);
	currentpad.yTicks = RightTicks(100., 50.);
	real y_min = c_cens[ui] - 500, y_max = c_cens[ui] + 500;
	DrawRunBands(y_min, y_max);

	/*
	TGraph_reducePoints = 30;
	draw(unixToHours*shift(0, sh_y[ui]), RootGetObject("bpm.root", "LHC.BOFSU:POSITIONS_V::"+bpms[ui]), black);
	TGraph_reducePoints = 1;
	*/

	for (int di : datasets.keys)
	{
		pen p = StdPen(di+1);
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/c_min_diff"), "p,l,eb", cyan, mCi+1pt+cyan);
		//draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/c_prob"), "p,l,eb", green, mCi+1pt+green);
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/c_mean_diff_sq"), "p,l,eb", magenta, mCi+1pt+magenta);
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/c_hist_chi_sq"), "p,l,eb", green, mCi+1pt+green);
		
		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment.root", "global/"+units[ui]+"/c"), "p,l,eb", blue+1pt, mCi+1pt+blue);

		draw(swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/c_fit"), "l", red+1.5pt);
		real unc = 100;
		draw(shift(0, +unc)*swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/c_fit"), "l", red+dashed);
		draw(shift(0, -unc)*swToHours, RootGetObject(topDir+datasets[di]+"/alignment_fit.root", ""+units[ui]+"/c_fit"), "l", red+dashed);
	}
	
	limits((time_min, y_min), (time_max, y_max), Crop);
	AttachLegend(unit_labels[ui], SE, SE);
}

//----------------------------------------------------------------------------------------------------

GShipout();
