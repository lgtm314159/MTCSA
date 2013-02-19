function D = NumConnectedPairs(E, P)
  D = zeros(1, length(E(1,:)) * (length(E(1,:)) - 1) / 2);
  Subnets = GenerateSubnets(E);
  for i = 1:length(Subnets)
    subnet = cell2mat(Subnets(i));
    D(CountSubnetConnPairs(subnet)) = ...
        D(CountSubnetConnPairs(subnet)) + CalcSubnetProb(subnet, E, P);
  end
end

