function factors = ComputeAllSimilarityFactors (images, K)
% This function computes all of the similarity factors for the images in
% one word.
%
% Input:
%   images: An array of structs containing the 'img' value for each
%     character in the word.
%   K: The alphabet size (accessible in imageModel.K for the provided
%     imageModel).
%
% Output:
%   factors: Every similarity factor in the word. You should use
%     ComputeSimilarityFactor to compute these.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

n = length(images);
nFactors = nchoosek (n, 2);

factors = repmat(struct('var', [], 'card', [], 'val', []), nFactors, 1);

% Your code here:
f = 1;
for c1=1:n
for c2=c1+1:n
    
    %factors(f).var = [c1 c2];
    %factors(f).card = [1 1];
    fSingle = ComputeSimilarityFactor(images,K,c1,c2);
    factors(f) = fSingle;
    %factors(f).val = fSingle.val;
    f = f + 1;
  end
end

end

