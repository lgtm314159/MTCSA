function condProb = CondProbConnected(E, P, PairA, PairB, BConn)
  Subnets = GenerateSubnets(E);
  condProb = 0;
  if (BConn)
    % The probability of having both PairA and PairB connected.
    interProb = 0;
    % The probability of having PairB connected.
    probB = 0;
    for i = 1:length(Subnets)
      subnet = cell2mat(Subnets(i));
      CCs = ConnComps(subnet);
      foundA = false;
      foundB = false;
      for j = 1:length(CCs)
        cc = cell2mat(CCs(j));
        if (not(isempty(find(cc==PairA(1)))) && not(isempty(find(cc==PairA(2)))))
          foundA = true;
        end
        if (not(isempty(find(cc==PairB(1)))) && not(isempty(find(cc==PairB(2)))))
          foundB = true;
        end
        if (foundA && foundB)
          break;
        end
      end
      if (foundB)
        subnetProb = CalcSubnetProb(subnet, E, P);
        % When PairB is connected, increase probB.
        probB = probB + subnetProb;
        if (foundA)
          % When PairA is also connected, increase interProb.
          interProb = interProb + subnetProb;
        end
      end
    end
    if (probB > 0)
      % P(PairA | PairB) = P(PairA, PairB) / P(PairB)
      condProb = interProb / probB;  
    end
  else
    % The probability of having PairA connected but PairB disconnected.
    interProb = 0;
    % The probabiliyt of having PairB disconnected.
    probNotB = 0;
    for i = 1:length(Subnets)
      subnet = cell2mat(Subnets(i));
      CCs = ConnComps(subnet);
      foundA = false;
      foundB = false;
      for j = 1:length(CCs)
        cc = cell2mat(CCs(j));
        if (not(isempty(find(cc==PairA(1)))) && not(isempty(find(cc==PairA(2)))))
          foundA = true;
        end
        if (not(isempty(find(cc==PairB(1)))) && not(isempty(find(cc==PairB(2)))))
          foundB = true;
          break;
        end
      end
      if (not(foundB))
        subnetProb = CalcSubnetProb(subnet, E, P);
        % If PairB is disconnected, increase probNotB.
        probNotB = probNotB + subnetProb;
        if (foundA)
          % If PairA is connected while PairB is disconnected, increase interProb.
          interProb = interProb + subnetProb;
        end
      end
    end
    % Add the probability of the subnet that has no link.
    probNotB = probNotB + P ^ (length(find(tril(E))));
    % P(PairA | Not PairB) = P(PairA, Not PairB) / P(Not PairB)
    condProb = interProb / probNotB;  
  end
end
