
function Uout = FactorSum( U1, U2 )
% Inputs:  factors U1 and U2.  These are the constituent factors to be added.
% Output: factor which is the "sum" of the two factors.

%%%% test
%  U1 = struct('var', [1, 3], 'card', [2, 2], 'val', [1 2 3 4]);
%  U2 = struct('var', [2], 'card', [3], 'val', [10 20 30]);
%  
%  FactorSum(U1, U2);
%%%%


Uout = struct('var', [], 'card', [], 'val', []);
Uout.var = union (U1.var, U2.var);

[tf,positions] = ismember(U1.var, Uout.var);
Uout.card(positions) = U1.card;
[tf,positions] = ismember(U2.var, Uout.var);
Uout.card(positions) = U2.card;
Uout.val = zeros(1,prod(Uout.card));

for (Un=[U1,U2])
  [tf,positions] = ismember(Un.var, Uout.var);
  for (i=1:length(Uout.val))
    %i
    wholeIndices = IndexToAssignment(i, Uout.card);
    %wholeIndices
    constituentIndices = wholeIndices(positions);
    %constituentIndices
    val1 = GetValueOfAssignment(Un, constituentIndices);
    val2 = GetValueOfAssignment(Uout, wholeIndices);
    Uout = SetValueOfAssignment(Uout, wholeIndices, val1+val2);
  end
end
%Uout.val
%assert(false)
