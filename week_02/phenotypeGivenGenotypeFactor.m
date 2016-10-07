function phenotypeFactor = phenotypeGivenGenotypeFactor(alphaList, genotypeVar, phenotypeVar)
% This function computes the probability of each phenotype given the 
% different genotypes for a trait. Genotypes (assignments to the genotype
% variable) are indexed from 1 to the number of genotypes, and the alphas
% are provided in the same order as the corresponding genotypes so that the
% alpha for genotype assignment i is alphaList(i).
%
% For the phenotypes, assignment 1 maps to having the physical trait, and 
% assignment 2 maps to not having the physical trait.
%
% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES
%
% Input:
%   alphaList: Vector of alpha values for each genotype (n x 1 vector,
%   where n is the number of genotypes) -- the alpha value for a genotype
%   is the probability that a person with that genotype will have the
%   physical trait 
%   genotypeVar: The variable number for the genotype variable (goes in the
%   .var part of the factor)
%   phenotypeVar: The variable number for the phenotype variable (goes in
%   the .var part of the factor)
%
% Output:
%   phenotypeFactor: Factor in which the val has the probability of having 
%   each phenotype for each genotype combination (note that this is the 
%   FULL CPD with no evidence observed)

phenotypeFactor = struct('var', [], 'card', [], 'val', []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INSERT YOUR CODE HERE
% The number of genotypes is the length of alphaList.
% The number of phenotypes is 2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  


%test...
% alphaList = [0.8; 0.6; 0.3; 0.4; 0.3; 0.1; 0.2; 0.4; 0.5;]
% genotypeVar = [1,4]
% phenotypeVar = 3
% phenotypeFactorAlpha = phenotypeGivenGenotypeFactor(alphaList, genotypeVar, phenotypeVar);


% Fill in phenotypeFactor.var.  This should be a 1-D row vector.
% Fill in phenotypeFactor.card.  This should be a 1-D row vector.
phenotypeFactor.var = [phenotypeVar genotypeVar];
phenotypeFactor.card = [2,  ones(1,length(genotypeVar))*3];  % genotype has cardinality of 2, each phenotype has cardinality of 3

phenotypeFactor.val = zeros(1, prod(phenotypeFactor.card));
% Replace the zeros in phentoypeFactor.val with the correct values.
% each increment of alpha increments the CPD table entry by 2 - we are given p(ph1|ge) and we calculate p(ph2|ge) as 1 minus that
for (aIndex=[1:length(alphaList)])
  fIndex = (aIndex-1)*2 + 1;
  fIndices = IndexToAssignment(fIndex, phenotypeFactor.card);
  phenotypeFactor = SetValueOfAssignment(phenotypeFactor, fIndices, alphaList(aIndex));
  
  fIndices = IndexToAssignment(fIndex + 1, phenotypeFactor.card);
  phenotypeFactor = SetValueOfAssignment(phenotypeFactor, fIndices, 1-alphaList(aIndex));
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
