function prob = MCProbConnected(E, P, PairA)
  % Enlarge P in order to avoid floating point comparison.
  enlargedP = P * 1000;
  count = 0;
  N = 10000;
  lowTriE = tril(E);
  [r, c] = find(lowTriE);
  for i = 1:N
    randSubnet = lowTriE;
    for j = 1:(length(r))
      p = floor(1000 * rand());
      if p <= enlargedP
        randSubnet(r(j), c(j)) = 0;
      end
    end
    randSubnet = randSubnet + randSubnet';
    CCs = ConnComps(randSubnet);
    for j = 1:length(CCs)
      if (not(isempty(find(cell2mat(CCs(j)) == PairA(1)))) && ...
          not(isempty(find(cell2mat(CCs(j)) == PairA(2)))))
        count = count + 1;
        break;
      end
    end
  end
  prob = count / N;
end

