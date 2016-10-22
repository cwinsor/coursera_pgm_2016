
X = struct('var', [1], 'card', [2], 'val', [.7, .3]);
Y = struct('var', [2], 'card', [2], 'val', [.6, .4]);
D = struct('var', [3 1], 'card', [2 2], 'val', [0 0 0 0]);
U = struct('var', [1, 2, 3], 'card', [2, 2, 2], 'val', [1 2 3 4 5 6 7 8]);

I1.RandomFactors = [X Y];
I1.DecisionFactors = D;
I1.UtilityFactors = U;

% Get EUF...
euf = CalculateExpectedUtilityFactor(I1);

