%%%%%%%%%%%% common stuff
clear
load PA3Data  % gives us allWords
load PA3Models  % gives imageModel, pairwiseModel, tripletList
imageModel.ignoreSimilarity = true;
%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% 1
factors = BuildOCRNetwork(allWords{1}, imageModel, [], []);
[charAcc, wordAcc] = ScoreModel(allWords, imageModel, [], []);

%%%%%%%%%%%%%%%%%%% 2
%%% EDIT LINE 53/54 OF BuildOCRNetwork.m to call ComputeEqualPairwiseFactors
epwf = ComputeEqualPairwiseFactors(allWords, 26);
%factors = BuildOCRNetwork(allWords{1}, imageModel, epwf, []);
[charAcc, wordAcc] = ScoreModel(allWords, imageModel, epwf, []);

%%%%%%%%%%%%%%%%%%  3
%%% EDIT LINE 53/54 OF BuildOCRNetwork.m to call ComputePairwiseFactors
pwf = ComputePairwiseFactors(allWords, pairwiseModel,  26);
[charAcc, wordAcc] = ScoreModel(allWords, imageModel, pairwiseModel, []);

%%%%%%%%%%%%%%%%%%  4
%%% EDIT LINE 53/54 OF BuildOCRNetwork.m to call ComputePairwiseFactors
tripletFactors = ComputeTripletFactors(allWords, tripletList, imageModel.K);
[charAcc, wordAcc] = ScoreModel(allWords(14), imageModel, pairwiseModel, tripletList);
[charAcc, wordAcc] = ScoreModel(allWords,     imageModel, pairwiseModel, tripletList);

%%%%%%%%%%%%%%%%%%  5
imageModel.ignoreSimilarity = false;
[charAcc, wordAcc] = ScoreModel(allWords(14), imageModel, pairwiseModel, tripletList);
[charAcc, wordAcc] = ScoreModel(allWords, imageModel, pairwiseModel, tripletList);
