function prob = ProbConnected(E, P, PairA)
  prob = 0;
  Subnets = GenerateSubnets(E);
  for i = 1:length(Subnets)
    CCs = ConnComps(cell2mat(Subnets(i)));
    for j = 1:length(CCs)
      if (not(isempty(find(cell2mat(CCs(j)) == PairA(1)))) && ...
          not(isempty(find(cell2mat(CCs(j)) == PairA(2)))))
        prob = prob + CalcSubnetProb(cell2mat(Subnets(i)), E, P);
        break;
      end
    end
  end
end

