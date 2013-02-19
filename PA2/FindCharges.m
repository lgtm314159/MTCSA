% Function to find a solution to the charges. Maybe be just a unique one,
% or one among the many, or there might not be a solution at all, depending
% on the parameters given.

function C = FindCharges(PA, PB, TF)
  sizePA = size(PA);
  sizePB = size(PB);
  % Make a matrix of the same dimension of the final coefficients matrix
  % to store the coordinates.
  reshapePA = reshape(PA, prod(sizePA), 1);
  repAndReshapePA = repmat(reshapePA, 1, sizePB(1,2));
  repPB = repmat(PB, sizePA(1,2), 1);
  BAMat = repAndReshapePA - repPB;

  % The following 6 lines are getting the norms of the vectors PA-PB
  % and shape them into a matrix of same dimensions as BAMat.
  coords = reshape(BAMat, 2, prod(size(BAMat)) / 2);
  norms = sqrt(diag(coords' * coords));
  intmedNormsMat1 = reshape(norms, sizePA(1,2), sizePB(1,2));
  intmedNormsMat2 = repmat(intmedNormsMat1', 2, 1);
  intmedNormsMat3 = reshape(intmedNormsMat2, sizePB(1,2), sizePA(1,2) * 2)
  normsMat = intmedNormsMat3'

  % Getting the final coefficients matrix and constant vector, and solve
  % the system of linear equations.
  ForceMat = BAMat ./ normsMat.^3;
  reshapeTF = reshape(TF, prod(size(TF)), 1);
  C = ForceMat \ reshapeTF;
end

