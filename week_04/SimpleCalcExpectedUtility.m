% Copyright (C) Daphne Koller, Stanford University, 2012

function EU = SimpleCalcExpectedUtility(I)

  % Inputs: An influence diagram, I (as described in the writeup).
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return Value: the expected utility of I
  % Given a fully instantiated influence diagram with a single utility node and decision node,
  % calculate and return the expected utility.  Note - assumes that the decision rule for the 
  % decision node is fully assigned.

  % In this function, we assume there is only one utility node.
  F = [I.RandomFactors I.DecisionFactors];
  U = I.UtilityFactors(1);
  EU = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The approach is to create a joint probability distribution from the network
% marginalizing out everything except those factors which are parents of the utility node.
% The product of this JPD and the utility values is the expected utility. 


%setOfAllFactors = union(F.RandomFactors.var(), F.DecisionFactors.var())
%setOfUtilityParents = U.UtilityFactors.var()
%setOfNotUtilityParentFactors = X less Y
setOfAllNonUtilityFactors = [];
for (i=1:length(F))
  setOfAllNonUtilityFactors = union(setOfAllNonUtilityFactors, F(i).var);
end
setOfUtilityParents = U.var();
setOfNotUtilityParentFactors = setdiff( setOfAllNonUtilityFactors, setOfUtilityParents);

% To create a JPD - two steps - first product of factors, then marginalize out certain factors
% they have a routine that does factor product - FactorProduct()
% they have a routine that does the marginalization - VariableElimination()
%fullJPD = factorProduct(setOfAllFactors)
%jointProbabilityDistUtilityParents = F.marginalizeOut(setOfNotUtilityParentFactors);
fullJPD = F(1);
for (i=2:length(F))
  fullJPD = FactorProduct(fullJPD, F(i));
end
jointProbabilityDistUtilityParents = VariableElimination(fullJPD, setOfNotUtilityParentFactors);

% The sum of elements in the product of this JPD and the utility values is the expected utility.
factorProductOfUtilityAndRestOfNetwork = FactorProduct(jointProbabilityDistUtilityParents, U);
EU = sum(factorProductOfUtilityAndRestOfNetwork.val);
  
end
