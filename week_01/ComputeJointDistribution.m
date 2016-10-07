%ComputeJointDistribution Computes the joint distribution defined by a set
% of given factors
%
%   Joint = ComputeJointDistribution(F) computes the joint distribution
%   defined by a set of given factors
%
%   Joint is a factor that encapsulates the joint distribution given by F
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%

function Joint = ComputeJointDistribution(F)

  % Check for empty factor list
  if (numel(F) == 0)
      warning('Error: empty factor list');
      Joint = struct('var', [], 'card', [], 'val', []);      
      return;
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% Compute the joint distribution defined by F
% You may assume that you are given legal CPDs so no input checking is required.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%Joint = struct('var', [], 'card', [], 'val', []); % Returns empty factor. Change this.

  
  % F1 = struct('var', [1], 'card', [2], 'val', (30:31));
  % F4 = struct('var', [4], 'card', [2], 'val', (20:21));
  % F3 = struct('var', [3, 1, 4], 'card', [2, 2, 2], 'val', (10:17));
  % F = [F3 F1 F4];
  % RESULT = ComputeJointDistribution(F);

  Joint = struct('var', [], 'card', [], 'val', []);

  % create a map - factor number to F index
  fIndex = [];
  to_do = [];
  for (x=1 : length(F))
    fIndex(F(x).var(1)) = x;
    to_do = [to_do F(x).var(1)];
  end
  done_total = [];
  
  %fIndex
  
  
  while (length(to_do)>0)
    %printf("--------------------\n");
    %to_do
    %done_total
    
    progress = 0;  % make sure we make progress in each go-round
    done_this_round = [];
    
    for td=1 : length(to_do)
      %printf("------ td %d\n",td);
      f = to_do(td);
      index = fIndex(f);      
      %printf("considering F(%d) which is indexed at %d\n",f,index);  

      num_vars = length(F(index).var);
      conditioned_on = F(index).var(2:num_vars);
      
      % are all the conditioned variables computed?
      %  (is the set of conditioned variables inside the computed set?)

      %printf(">>>>>>\n");
      %conditioned_on
      %done_total
      %(ismember(conditioned_on, done_total))
      %(and(ismember(conditioned_on, done_total)))
      %printf("<<<<<<<\n");      

      if ((length(conditioned_on)==0) || (and(ismember(conditioned_on, done_total))))
	%printf("   CAN compute\n");
	Joint = FactorProduct(Joint, F(index));
        done_this_round = [done_this_round, td];
        progress = 1;
      else
	%printf("   CANNOT compute\n");
      end
    end
    if (progress == 0)
      printf("no progress!\n");
    end
    done_total = [done_total, to_do(done_this_round)];
    to_do(done_this_round) = [];
  end
  %printf("done!\n");
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

