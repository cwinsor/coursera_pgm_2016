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


for i=1:100
  i 
  foo = BuildOCRNetwork(allWords{i}, imageModel, pairwiseModel, []);
  foo
  pairwiseModel
  bar =  RunInference(foo);
  assert(false)
  %wordPredictions{i} = RunInference(BuildOCRNetwork(allWords{i}, imageModel, pairwiseModel, []));
end

[charAcc, wordAcc] = ScoreModel(allWords, imageModel, pwf, []);


» imageModel.ignoreSimilarity = true;
» factors = BuildOCRNetwork(allWords{i}, imageModel, [], tripletList);
