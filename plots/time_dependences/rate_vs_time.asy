import root;
import pad_layout;
include "../run_info.asy";

string datasets[], d_labels[];
datasets.push("DS-TOTEM1-347"); d_labels.push("DS-TOTEM1-347");
//datasets.push("DS-TOTEM1-348"); d_labels.push("DS-TOTEM1-348");
//datasets.push("DS-TOTEM3-349"); d_labels.push("DS-TOTEM3-349");

string diagonals[] = { "45b_56t", "45t_56b" };
string dgn_labels[] = { "45b -- 56t", "45t -- 56b" };

string types[], t_labels[];
pen t_pens[];
types.push("dgn"); t_labels.push("diagonal"); t_pens.push(red);
types.push("sel"); t_labels.push("selected"); t_pens.push(blue);

string topDir = "../../";

xSizeDef = 10cm;
ySizeDef = 6cm;

//xTicksDef = LeftTicks(1., 0.5);

TGraph_errorBar = None;

int rebin = 10;

transform swToMinutes = shift(-1010, 0) * scale(1/60, 1);

//----------------------------------------------------------------------------------------------------

void SetPadWidth()
{
	/*
	real factorHoursToSize = 50cm / 3;
	real timespan = currentpicture.userMax2().x - currentpicture.userMin2().x;
	currentpad.xSize = timespan * factorHoursToSize;
	*/

	currentpad.xSize = 12cm;
}

//----------------------------------------------------------------------------------------------------

NewPad();

for (int dgni : diagonals.keys)
{
	NewPad(false);
	label("{\SetFontSizesXX " + dgn_labels[dgni] + "}");
}

for (int dsi : datasets.keys)
{
	NewRow();
	
	NewPad(false);
	label("{\SetFontSizesXX " + datasets[dsi] + "}");

	for (int dgni : diagonals.keys)
	{
		NewPad("time from 25 Jun 2018 $\ung{h}$", "rate$\ung{Hz}$");
		currentpad.yTicks = RightTicks(50., 10.);
		real y_min = 0, y_max = 300;

		DrawRunBands("", y_min, y_max);

		for (int ti : types.keys)
		{
			RootObject hist = RootGetObject(topDir+datasets[dsi]+"/distributions_"+diagonals[dgni]+".root", "metadata/rate cmp|h_timestamp_" + types[ti]);
			hist.vExec("Rebin", rebin);

			draw(scale(1., 1./rebin) * swToHours, hist, "vl", t_pens[ti]);
		}

		ylimits(y_min, y_max, Crop);
		SetPadWidth();
	}
}

/*
NewPad(false);
for (int dgni : diagonals.keys)
{
	AddToLegend(dgn_labels[dgni], dgn_pens[dgni]);
}
AttachLegend();

*/

GShipout(vSkip=0mm);
