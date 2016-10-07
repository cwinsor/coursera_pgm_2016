% ObserveEvidence Modify a vector of factors given some evidence.
%   F = ObserveEvidence(F, E) sets all entries in the vector of factors, F,
%   that are not consistent with the evidence, E, to zero. F is a vector of
%   factors, each a data structure with the following fields:
%     .var    Vector of variables in the factor, e.g. [1 2 3]
%     .card   Vector of cardinalities corresponding to .var, e.g. [2 2 2]
%     .val    Value table of size prod(.card)
%   E is an N-by-2 matrix, where each row consists of a variable/value pair. 
%     Variables are in the first column and values are in the second column.

function F = ObserveEvidence(F, E)

% Iterate through all evidence

for i = 1:size(E, 1),
    v = E(i, 1); % variable
    x = E(i, 2); % value

%    printf("variable X_%d value x%d\n",v,x);

    % Check validity of evidence
    if (x == 0),
        warning(['Evidence not set for variable ', int2str(v)]);
        continue;
    end;

    for j = 1:length(F),
		  % Does factor contain variable?
        indx = find(F(j).var == v);

        if (~isempty(indx)),
        
		  	   % Check validity of evidence
            if (x > F(j).card(indx) || x < 0 ),
                error(['Invalid evidence, X_', int2str(v), ' = ', int2str(x)]);
            end;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % YOUR CODE HERE
            % Adjust the factor F(j) to account for observed evidence
            % Hint: You might find it helpful to use IndexToAssignment
            %       and SetValueOfAssignment
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% F1 = struct('var', [3, 1, 4], 'card', [2, 2, 2], 'val', (10:17));
% F2 = struct('var', [4, 5], 'card', [2, 3], 'val', (20:25));
% F3 = ObserveEvidence([F1,F2], [4 2; 5 3]);

% FACTORS.EVIDENCE = ObserveEvidence(FACTORS.INPUT, [2 1; 3 2]);
%FACTORS.EVIDENCE(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);
%FACTORS.EVIDENCE(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0, 0.22, 0]);
%FACTORS.EVIDENCE(3) = struct('var', [3, 2], 'card', [2, 2], 'val', [0, 0.61, 0, 0]);


%printf("   factor %d contains the variable\n",j);


for ass=1:prod(F(j).card)
	  ass_set = IndexToAssignment(ass,F(j).card);
	  if (ass_set(indx) != x)
	    F(j) = SetValueOfAssignment(F(j), ass_set, 0);
          end
end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

				% Check validity of evidence / resulting factor
            if (all(F(j).val == 0)),
                warning(['Factor ', int2str(j), ' makes variable assignment impossible']);
            end;

        end;
    end;
end;

end
