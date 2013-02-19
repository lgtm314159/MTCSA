% Function to calculate the 2xk Matrix F with the property that for any
% vector of charges Q, the value <F,Q> is the net force on A.

function F = ForceMatrix(PA, PB)
  repPA = repmat(PA, 1, length(PB(1, :)));
  BAMat = repPA - PB;
  BANorm = sqrt(diag(BAMat'*BAMat));
  repBANormTrans = repmat(BANorm', 2, 1);  
  F = BAMat ./ repBANormTrans.^3;
end