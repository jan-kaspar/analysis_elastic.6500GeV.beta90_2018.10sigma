import root;
import pad_layout;
include "../run_info.asy";

string topDir = "../../";

string datasets[] = {
	"DS-6877",
	"DS-6879",
	"DS-6881",
	"DS-6882",
	"DS-6884",
	"DS-6885",
	"DS-6890",
	"DS-6891",
	"DS-6892",
};

string streams[];
pen s_pens[];
streams.push("ZeroBias"); s_pens.push(blue);
streams.push("TOTEM1"); s_pens.push(red+1pt);

pen p_fit = heavygreen;

string units[];
string unit_labels[];
real a_cens[], b_cens[], c_cens[];

units.push("L_2_F"); unit_labels.push("45-220-fr"); a_cens.push(-1.1); b_cens.push(20); c_cens.push(350);
units.push("L_1_F"); unit_labels.push("45-210-fr"); a_cens.push(-1.7); b_cens.push(30); c_cens.push(300);

units.push("R_1_F"); unit_labels.push("56-210-fr"); a_cens.push(-1.); b_cens.push(-20); c_cens.push(-150);
units.push("R_2_F"); unit_labels.push("56-220-fr"); a_cens.push(-1.7); b_cens.push(0); c_cens.push(-150);

xSizeDef = 12cm;
//xTicksDef = LeftTicks(Step=1, step=0.5);
drawGridDef = true;

bool draw_fits = true;

TGraph_errorBar = None;

real time_min = 10.;
real time_max = 140.;

//----------------------------------------------------------------------------------------------------

RootObject GetFitObject(string tag, string unit, string obj)
{
	//return RootGetObject(topDir + tag + "/alignment_fit.root", unit + "/" + obj);
	return RootGetObject(topDir + "alignment/global_fit.root", unit + "/" + obj);
}

//----------------------------------------------------------------------------------------------------

for (int ui : units.keys)
	NewPadLabel(unit_labels[ui]);

//----------------------------------------------------------------------------------------------------

NewRow();

for (int ui : units.keys)
{
	NewPad("time $\ung{h}$", "tilt $\ung{mrad}$", axesAbove=false);
	currentpad.yTicks = RightTicks(1., 0.5);
	real y_min = a_cens[ui] - 3, y_max = a_cens[ui] + 3;
	DrawRunBands(y_min, y_max);

	for (int dsi : datasets.keys)
	{
		for (int sti : streams.keys)
		{
			string tag = datasets[dsi] + "/" + streams[sti];
			pen p = s_pens[sti];

			draw(swToHours, RootGetObject(topDir+tag+"/alignment.root", "global/"+units[ui]+"/a"), "p,l,eb", p, mCi+1pt+p);

			if (draw_fits)
			{
				real unc = 1;
				RootObject fit = GetFitObject(tag, units[ui], "a_fit");
				draw(swToHours, fit, "l", p_fit+1.5pt);
				draw(shift(0, +unc)*swToHours, fit, "l", p_fit+dashed);
				draw(shift(0, -unc)*swToHours, fit, "l", p_fit+dashed);
			}
		}
	}

	limits((time_min, y_min), (time_max, y_max), Crop);
	//AttachLegend(unit_labels[ui], SE, SE);
}

//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("time $\ung{h}$", "horizontal position $\ung{\mu m}$", axesAbove=false);
	currentpad.yTicks = RightTicks(10., 5.);
	real y_min = b_cens[ui] - 50, y_max = b_cens[ui] + 50;
	DrawRunBands(y_min, y_max);

	for (int dsi : datasets.keys)
	{
		for (int sti : streams.keys)
		{
			string tag = datasets[dsi] + "/" + streams[sti];
			pen p = s_pens[sti];

			draw(swToHours, RootGetObject(topDir+tag+"/alignment.root", "global/"+units[ui]+"/b"), "p,l,eb", p, mCi+1pt+p);

			if (draw_fits)
			{
				RootObject fit = GetFitObject(tag, units[ui], "b_fit");
				real unc = 10;
				draw(swToHours, fit, "l", p_fit+1.5pt);
				draw(shift(0, +unc)*swToHours, fit, "l", p_fit+dashed);
				draw(shift(0, -unc)*swToHours, fit, "l", p_fit+dashed);
			}
		}
	}
	
	limits((time_min, y_min), (time_max, y_max), Crop);
	//AttachLegend(unit_labels[ui], SE, SE);
}

//----------------------------------------------------------------------------------------------------
NewRow();

for (int ui : units.keys)
{
	NewPad("time $\ung{h}$", "vertical position $\ung{\mu m}$", axesAbove=false);
	currentpad.yTicks = RightTicks(100., 50.);
	real y_min = c_cens[ui] - 500, y_max = c_cens[ui] + 500;
	DrawRunBands(y_min, y_max);

	for (int dsi : datasets.keys)
	{
		for (int sti : streams.keys)
		{
			string tag = datasets[dsi] + "/" + streams[sti];
			pen p = s_pens[sti];

			draw(swToHours, RootGetObject(topDir+tag+"/alignment.root", "global/"+units[ui]+"/c"), "p,l,eb", p, mCi+1pt+p);

			if (draw_fits)
			{
				RootObject fit = GetFitObject(tag, units[ui], "c_fit");
				real unc = 100;
				draw(swToHours, fit, "l", p_fit+1.5pt);
				draw(shift(0, +unc)*swToHours, fit, "l", p_fit+dashed);
				draw(shift(0, -unc)*swToHours, fit, "l", p_fit+dashed);
			}
		}
	}
	
	limits((time_min, y_min), (time_max, y_max), Crop);
	//AttachLegend(unit_labels[ui], SE, SE);
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=0mm, vSkip=0mm);
