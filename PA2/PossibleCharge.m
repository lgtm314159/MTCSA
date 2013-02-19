% Function to return a possible solution to the charges.

function C = PossibleCharge(PA, PB, TF)
  FM = ForceMatrix(PA, PB);
  C = FM \ TF;
end

