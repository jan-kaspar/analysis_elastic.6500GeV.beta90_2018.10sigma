import root;
import pad_layout;

string topDir = "../../";

TH2_palette = Gradient(blue, heavygreen, yellow, red);

string datasets[] = {
	/*
	"DS-6877/ZeroBias",
	"DS-6879/ZeroBias",
	"DS-6881/ZeroBias",
	"DS-6882/ZeroBias",
	"DS-6884/ZeroBias",
	"DS-6885/ZeroBias",
	"DS-6890/ZeroBias",
	"DS-6891/ZeroBias",
	"DS-6892/ZeroBias",
	*/

	"DS-6877/TOTEM1",
	"DS-6879/TOTEM1",
	"DS-6881/TOTEM1",
	"DS-6882/TOTEM1",
	"DS-6884/TOTEM1",
	"DS-6885/TOTEM1",
	"DS-6890/TOTEM1",
	"DS-6891/TOTEM1",
	"DS-6892/TOTEM1",
};

string dgns[] = {
	"45b_56t",
	"45t_56b"
};

int cuts[] = { 1, 2, 7 };

real scale_x[] = { 1e6, 1e6, 1e6, 1e6, 1e0, 1e0, 1e6, 1e6 };
real scale_y[] = { 1e6, 1e6, 1e0, 1e0, 1e0, 1e0, 1e0, 1e0 };

string label_x[] = { "$\th_x^{*R}\ung{\mu rad}$", "$\th_y^{*R}\ung{\mu rad}$", "$\th_x^{*R}\ung{\mu rad}$", "$\th_x^{*L}\ung{\mu rad}$", "$y^{R,N}\ung{mm}$", "$y^{L,N}\ung{mm}$", "$\th_x^*\ung{\mu rad}$", "$\th_y^*\ung{\mu rad}$" };
string label_y[] = { "$\th_x^{*L}\ung{\mu rad}$", "$\th_y^{*L}\ung{\mu rad}$", "$x^{*R}\ung{mm}$", "$x^{*L}\ung{mm}$", "$y^{R,F} - y^{R,N}\ung{mm}$", "$y^{L,F} - y^{L,N}\ung{mm}$", "$\De^{R-L} x^*\ung{mm}$", "$\De^{R-L} y^*\ung{mm}$" };
string label_cut[] = { "$\De^{R-L} \th_x^{*}\ung{\mu rad}$", "$\De^{R-L} \th_y^{*}\ung{\mu rad}$", "$x^{*R}\ung{mm}$", "$x^{*L}\ung{mm}$", "$cq5$", "$cq6$", "$cq7$", "$cq8$" };

real lim_x_low[] = { -200, +1, -1000, -1000, +1, +1, -400, -200 };
real lim_x_high[] = { +200, -1, +1000, +1000, -1, -1, +200, +200 };

real lim_y_low[] = { -200, +1, -0.8, -0.8, +1, +1, -1, -100 };
real lim_y_high[] = { +200, -1, +0.8, +0.8, -1, -1, +1, +100 };

real lim_q[] = { 100., 20, 10., 10., 1., 1., 0.1, 10. };

//----------------------------------------------------------------------------------------------------

NewPad(false);

for (int ci : cuts.keys)
{
	int cut = cuts[ci];
	int idx = cut - 1;

	NewPad(false);
	label("{\SetFontSizesXX " + format("cut %i", cut) + "}");
}

for (int dsi : datasets.keys)
{
	string dataset = datasets[dsi];

	write("* " + dataset);

	for (int dgi : dgns.keys)
	{
		string dgn = dgns[dgi];
		string f = topDir + dataset+"/distributions_" + dgn + ".root";
	
		NewRow();

		NewPad(false);
		label("\vbox{\SetFontSizesXX\hbox{"+dataset+"}\hbox{"+replace(dgn, "_", "--")+"}}");

		for (int ci : cuts.keys)
		{
			int cut = cuts[ci];
			int idx = cut - 1;
	
			// ---------- discriminator distribution ----------

			string obj_name_par = format("elastic cuts/cut %i", cut) + format("/g_cut_parameters", cut);
			RootObject obj_par = RootGetObject(f, obj_name_par);
			real ax[] = {0}, ay[] = {0};
			obj_par.vExec("GetPoint", 0, ax, ay); real cca = ay[0];
			obj_par.vExec("GetPoint", 1, ax, ay); real ccb = ay[0];
			obj_par.vExec("GetPoint", 2, ax, ay); real ccc = ay[0];
			obj_par.vExec("GetPoint", 3, ax, ay); real csi = ay[0];
			obj_par.vExec("GetPoint", 4, ax, ay); real n_si = ay[0];

			NewPad(label_cut[idx]);

			string obj_name_h = format("elastic cuts/cut %i", cut) + format("/h_cq%i", cut);
			RootObject obj_h = RootGetObject(f, obj_name_h);

			real scale = scale_y[idx];

			draw(scale(scale, 1.), obj_h, "vl,eb", red+1pt);

			xlimits(-lim_q[idx], +lim_q[idx], Crop);

			yaxis(XEquals(+n_si * csi * scale, false), blue+dashed);
			yaxis(XEquals(-n_si * csi * scale, false), blue+dashed);

			AddToLegend(format("<mean = $%#.3f$", obj_h.rExec("GetMean") * scale));
			AddToLegend(format("<RMS = $%#.3f$", obj_h.rExec("GetRMS") * scale));
			AddToLegend(format("<cut = $\pm%#.3f$", n_si * csi * scale));
			AttachLegend();
		}
	}
}

GShipout(hSkip=0mm, vSkip=0mm);
