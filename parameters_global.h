#include <string>
#include <vector>
#include <map>
#include <cmath>

double timestamp0 = 1530482400;

double timestamp_min = 18E3, timestamp_max = 27E3;

vector<string> distilledNtuples;

vector<AlignmentSource> alignmentSources;
Analysis anal;
Environment env;

string unsmearing_file;
string unsmearing_object;

string luminosity_data_file;

bool simulated_dataset = false;

//----------------------------------------------------------------------------------------------------

void Init_global()
{
	// environment settings
	env.InitNominal();

	// selection of bunches
	keepAllBunches = true;

	// binning
	// TODO
	anal.t_min = 8E-4; anal.t_max = 1.0;
	anal.t_min_full = 0.; anal.t_max_full = 1.1;

	// approximate (time independent) resolutions
	// TODO
	anal.si_th_y_1arm = 0.37E-6 / sqrt(2.);
	anal.si_th_y_1arm_unc = 0.02E-6 / sqrt(2.);

	anal.si_th_y_2arm = anal.si_th_y_1arm / sqrt(2.);
	anal.si_th_y_2arm_unc = 0.01E-6;

	anal.si_th_x_1arm_L = 12.5E-6 / sqrt(2.);
	anal.si_th_x_1arm_R = 12.5E-6 / sqrt(2.);
	anal.si_th_x_1arm_unc = 0E-6;

	//anal.si_th_x_LRdiff = 12.5E-6;
	//anal.si_th_x_LRdiff_unc = 0.3E-6;

	//anal.si_th_y_LRdiff = anal.si_th_y_1arm * sqrt(2.);
	//anal.si_th_y_LRdiff_unc = 0.007E-6;

	anal.si_th_x_2arm = 0.29E-6;
	anal.si_th_x_2arm_unc = 0.04E-6;

	// alignment-determination settings
	anal.alignment_t0 = 18172.;		// beginning of the first time-slice
	anal.alignment_ts = 10.*60.;	// time-slice in s
	
	anal.alignmentYRanges["L_2_F"] = Analysis::AlignmentYRange(-18.0, -5.0, +5.0, +18.0);
	anal.alignmentYRanges["L_1_F"] = Analysis::AlignmentYRange(-17.0, -4.5, +4.5, +17.0);

	anal.alignmentYRanges["R_1_F"] = Analysis::AlignmentYRange(-18.0, -4.5, +4.5, +18.0);
	anal.alignmentYRanges["R_2_F"] = Analysis::AlignmentYRange(-18.0, -5.0, +5.0, +18.0);

	// correction settings
	// TODO
	//anal.use_resolution_fits = false;

	anal.use_3outof4_efficiency_fits = false;
	anal.inefficiency_3outof4 = 0.;
	anal.inefficiency_shower_near = 0.03;	// probability of shower created in near and spreading to far: 2 * 1.5%

	anal.use_pileup_efficiency_fits = false;
	anal.inefficiency_pile_up = 0.;

	anal.inefficiency_trigger = 0.;
	anal.inefficiency_DAQ = 0.;

	anal.bckg_corr = 1.;

	// normalisation settings
	anal.L_int = 1.;	// mb^-1
}

//----------------------------------------------------------------------------------------------------

void Init_global_45b_56t()
{
	// fiducial cuts
	/*
	anal.fc_L_l = FiducialCut(4.15E-6, -20E-6, -0.01, +10E-6, +0.05);
	anal.fc_L_h = FiducialCut(102E-6, 0E-6, 0., 0E-6, 0.);

	anal.fc_R_l = FiducialCut(4.15E-6, -20E-6, -0.01, +20E-6, 0.05);
	anal.fc_R_h = FiducialCut(102E-6, 0E-6, 0., 0E-6, 0.);

	anal.fc_G_l = FiducialCut(4.35E-6, -20E-6, -0.01, +10E-6, +0.05);
	anal.fc_G_h = FiducialCut(100E-6, 0E-6, 0., 0E-6, 0.);
	*/

	// analysis settings
	anal.cut1_a = 1.; anal.cut1_c = -149.4E-6; anal.cut1_si = 10E-6;
	anal.cut2_a = 1.; anal.cut2_c = -1.4E-6; anal.cut2_si = 2.5E-6;

	anal.cut7_a = -1250.; anal.cut7_c = -0.036; anal.cut7_si = 0.01;

	// unfolding settings
	//unsmearing_file = "unfolding_cf_ni_45b_56t.root";
	//unsmearing_object = "fitN-2/<binning>";
}

//----------------------------------------------------------------------------------------------------

void Init_global_45t_56b()
{
	// fiducial cuts
	/*
	anal.fc_L_l = FiducialCut(4.15E-6, -12E-6, -0.05, +20E-6, +0.01);
	anal.fc_L_h = FiducialCut(102E-6, 0E-6, 0., 0E-6, 0.);

	anal.fc_R_l = FiducialCut(4.15E-6, -20E-6, -0.05, +15E-6, +0.04);
	anal.fc_R_h = FiducialCut(102E-6, 0E-6, 0., 0E-6, 0.);

	anal.fc_G_l = FiducialCut(4.35E-6, -12E-6, -0.05, +15E-6, +0.04);
	anal.fc_G_h = FiducialCut(100E-6, 0E-6, 0., 0E-6, 0.);
	*/

	anal.cut1_a = 1.; anal.cut1_c = -157.6E-6; anal.cut1_si = 10E-6;
	anal.cut2_a = 1.; anal.cut2_c = -1.6E-6; anal.cut2_si = 2.5E-6;

	anal.cut7_a = -1250.; anal.cut7_c = -0.017; anal.cut7_si = 0.01;

	// unfolding settings
	//unsmearing_file = "unfolding_cf_ni_45t_56b.root";
	//unsmearing_object = "fitN-2/<binning>";
}
