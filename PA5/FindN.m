function maxN = FindN(E, P)
  % Enlarge P in order to avoid floating point comparison.
  % P = 0.1, Exp = 31.3811; P = 0.6, Exp = 5.5557
  % [31.0672, 31.6949], [5.5001, 5.6113]
  v = NumConnectedPairs(E, P); 
  res = 0;
  for i = 1:length(v)
    res = res + i * v(i);
  end
  lower = res - res * 0.01;
  higher = res + res * 0.01;  

  enlargedP = P * 1000;
  lowTriE = tril(E);
  maxN = 0;
  [r, c] = find(lowTriE);
  for n = 1:100
    N = 100;
    total = 0;
    stablizing = false;
    for i = 1:N
      randSubnet = lowTriE;
      for j = 1:(length(r))
        p = floor(1000 * rand());
        if p <= enlargedP
          randSubnet(r(j), c(j)) = 0;
        end
      end
      randSubnet = randSubnet + randSubnet';
      total = total + CountSubnetConnPairs(randSubnet);
    end
    expPairs = total / N;
    if (expPairs >= lower && expPairs <= higher)
      stablizing = true;
      stableN = N;
    end

    while 1
      N = N + 1;
      randSubnet = lowTriE;
      for j = 1:(length(r))
        p = floor(1000 * rand());
        if p <= enlargedP
          randSubnet(r(j), c(j)) = 0;
        end
      end
      randSubnet = randSubnet + randSubnet';
      total = total + CountSubnetConnPairs(randSubnet);
      expPairs = total / N;
      if (expPairs >= lower && expPairs <= higher)
        if (stablizing)
          if (N - stableN >= 100)
            break;
          end
        else 
          stablizing = true;
          stableN = N;
        end
      else
        stablizing = false;
      end
    end

    if (maxN < N)
      maxN = N;
    end
  end
end

