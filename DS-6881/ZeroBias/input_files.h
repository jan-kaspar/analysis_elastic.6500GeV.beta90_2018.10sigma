#include <string>
#include <vector>

std::vector<std::string> input_files;

void InitInputFiles()
{
	input_files.clear();

	input_files.push_back("root://eostotem.cern.ch//eos/totem/user/j/jkaspar/reco/2018_90m/10sigma-ZeroBias-version2/run_319159.0_re_reco_ZeroBias.root");
	input_files.push_back("root://eostotem.cern.ch//eos/totem/user/j/jkaspar/reco/2018_90m/10sigma-ZeroBias-version2/run_319160.0_re_reco_ZeroBias.root");
}
