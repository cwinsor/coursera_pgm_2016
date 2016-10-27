%% section 2.4
clear
pedigree = struct('parents', [0,0;1,3;0,0]);
pedigree.names = {'Ira','James','Robin'};
alleleFreqs = [0.1; 0.9];
alphaList = [0.8; 0.6; 0.1];
% baseline - use the sampleFactorList that is given to us
load('sampleFactorList.mat'); % Comment out this line for testing
% sampleFactorList = constructGeneticNetwork(pedigree, alleleFreqs, alphaList);

alleleNames = {"A"; "a"};
phenoNames = {"POS"; "NEG"};
positions = [1 1 1 2;
	     2 1 2 2; 
	     3 1 3 2];
sendToSamiam(pedigree, sampleFactorList, alleleNames, phenoNames, positions, 'toSam24Them');
~/bin/samiam/runsamiam toSam24Them.net &

sendToSamiamGeneCopy
~/bin/samiam/runsamiam  cysticFibrosisBayesNet.net &
sendToSamiamInfoDecoupled
~/bin/samiam/runsamiam cysticFibrosisBayesNetGeneCopy.net &


% questions 10
~/bin/samiam/runsamiam spinalMuscularAtrophyBayesNet.net &
