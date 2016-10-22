% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeMEU( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  
  % We assume I has a single decision node.
  % You may assume that there is a unique optimal decision.
  D = I.DecisionFactors(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  % 
  % Some other information that might be useful for some implementations
  % (note that there are multiple ways to implement this):
  % 1.  It is probably easiest to think of two cases - D has parents and D 
  %     has no parents.
  % 2.  You may find the Matlab/Octave function setdiff useful.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
EUF = CalculateExpectedUtilityFactor( I );

% Above gives us the factor  U-d(D, PaD)
% We now want to create the optimal decision rule.
% The optimal decision rule binarizes (is a multiplexer)
% taking as input factors and outputting a 1 or 0
% for each of the decision choices
%
% to get here - note the decision rule has the same
% elements as the EUF, except that it is binarized by
% row.  To help with the indexing we reshape the
% decision rule so the first index is the decision factor

% find the D variable in the EUF factor
[tf, s_idx] = ismember(I.DecisionFactors(1).var(1), EUF.var);
dIndex = s_idx(1);

% initialize new factor - OptimalDecisionRule
% this just reshuffles the EUF so the decision factor is first
OptimalDecisionRule  = struct('var', [], 'card', [], 'val', []);
OptimalDecisionRule.var  = [ EUF.var(dIndex) EUF.var(1:dIndex-1) EUF.var(dIndex+1:end) ];
OptimalDecisionRule.card = [ EUF.card(dIndex) EUF.card(1:dIndex-1) EUF.card(dIndex+1:end) ];
OptimalDecisionRule.val = zeros(1,prod(OptimalDecisionRule.card));
% reshape the array
for (i=1 : length(EUF.val))
  i
  indices = IndexToAssignment(i, EUF.card);
  v = GetValueOfAssignment(EUF, indices);
  newIndices = [ indices(dIndex) indices(1:dIndex-1) indices(dIndex+1:end) ];
  OptimalDecisionRule = SetValueOfAssignment(OptimalDecisionRule, newIndices, v);
end
EUF
OptimalDecisionRule

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% case where the decision rule is dependent on one or more factors
if (length(OptimalDecisionRule.card) > 1)
   
  % get the cartesian product of the non-decision variables
  sets = {};
  for (f=2:length(OptimalDecisionRule.card))
    sets = [sets [1:OptimalDecisionRule.card(f)]];
  end
  sets
  assert(false)
  combinations = cartesianProduct(sets)
  
  % iterate through rows
  maxOverallVal = -1000000;
  for (combNum = 1: length(combinations))
    combNum
    % iterate through columns
    maxThisRowVal = -1000000;
    for (rule=1 : OptimalDecisionRule.card(1));
      indicesRule =  [rule,combinations(combNum)];
      val = GetValueOfAssignment(OptimalDecisionRule, indicesRule)
      if (val > maxThisRowVal)
	maxThisRowVal = val;
	maxThisRowIndices = indicesRule;
      end
      if (val > maxOverallVal)
	maxOverallVal = val;
      end
      OptimalDecisionRule = SetValueOfAssignment(OptimalDecisionRule, indicesRule, 0); % we zero the array as we go
    end
    OptimalDecisionRule = SetValueOfAssignment(OptimalDecisionRule, maxThisRowIndices, 1); % set to 1 the rule which results in greatest result
  end
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% case where the decision rule is not dependent on anything
else
    
  % iterate through rows
  maxOverallVal = -1000000;
  for (rule=1 : OptimalDecisionRule.card(1));
    indicesRule =  [rule];
    val = GetValueOfAssignment(OptimalDecisionRule, indicesRule)
    if (val > maxOverallVal)
      maxOverallVal = val;
      maxThisRowIndices = indicesRule;
    end
    OptimalDecisionRule = SetValueOfAssignment(OptimalDecisionRule, indicesRule, 0); % we zero the array as we go
  end
  OptimalDecisionRule = SetValueOfAssignment(OptimalDecisionRule, maxThisRowIndices, 1); % set to 1 the rule which results in greatest result
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MEU = maxOverallVal;
end
