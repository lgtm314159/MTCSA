% Function to calculate total force.
function F = TotalForce(PA, PB, QB)
  F = ForceMatrix(PA, PB) * QB;
end

