% Copyright (C) Daphne Koller, Stanford University, 2012

function EUF = CalculateExpectedUtilityFactor( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: A factor over the scope of the decision rule D from I that
  % gives the conditional utility given each assignment for D.var
  %
  % Note - We assume I has a single decision node and utility node.
  EUF = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%  I.RandomFactors(1)
%I.RandomFactors(2)
%  I.DecisionFactors
%  I.UtilityFactors
%foo = FactorProduct(I.RandomFactors(1), I.RandomFactors(2))
%bar = FactorProduct(foo,  I.UtilityFactors)
%assert(false)

%I.RandomFactors(1)
%I.UtilityFactors(1)
%FactorProduct(I.RandomFactors(1), I.UtilityFactors(1))



%I.RandomFactors
%I.DecisionFactors
%I.UtilityFactors
%assert(false)

% Procedure:
% Compute a factor that includes everything except the decision rule.
% This is done using "factor product".
% Marginalize out everything except the factors that are parents of the decision rule itself.
% This is the factor  U-d(D, PaD)
%
% Step through each of the combinations the parent will present.
% for each of the combinations, choose the decision rule (value of d)
% that will result in greatest value.  That is the rule for that combination of inputs.

% Implementation:
% we will need a list of all factors, and a list of parents of D
setOfFactorsAll = [];
for (i=1:length(I.RandomFactors))
  setOfFactorsAll = union(setOfFactorsAll, I.RandomFactors(i).var);
end
for (i=1:length(I.DecisionFactors))
  setOfFactorsAll = union(setOfFactorsAll, I.DecisionFactors(i).var);
end
for (i=1:length(I.UtilityFactors))
  setOfFactorsAll = union(setOfFactorsAll, I.UtilityFactors(i).var);
end


setOfFactorsDandParentsOfD =  I.DecisionFactors(1).var;
setOfFactorsNotParentsOfD = setdiff(setOfFactorsAll, setOfFactorsDandParentsOfD);

% Compute a factor that includes everything except the decision rule.
factorEverythingLessDecisionRule = I.RandomFactors(1);
for (i=2:length(I.RandomFactors))
  factorEverythingLessDecisionRule = FactorProduct(factorEverythingLessDecisionRule, I.RandomFactors(i));
end

factorEverythingLessDecisionRule = FactorProduct(factorEverythingLessDecisionRule, I.UtilityFactors(1));

% Marginalize out everything except the factors that are parents of the decision rule itself.
factorEverythingLessDrMarginalizedKeepingDrParents = VariableElimination(factorEverythingLessDecisionRule, setOfFactorsNotParentsOfD);

EUF = factorEverythingLessDrMarginalizedKeepingDrParents;


end  
