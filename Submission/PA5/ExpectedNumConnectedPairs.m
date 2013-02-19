function expPairs = ExpectedNumConnectedPairs(E, P)
  % Enlarge P in order to avoid floating point comparison.
  enlargedP = P * 1000;
  total = 0;
  N = 15000;
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
    total = total + CountSubnetConnPairs(randSubnet);
  end
  expPairs = total / N;
end

% Answer to Part C:
% P = 0.1, EXP = 31.3811; P = 0.6, EXP = 5.5557
% Confident intervals are [31.0672, 31.6949] and [5.5001, 5.6113] respectively.
% For P = 0.1, my answer to Part C is 7018.
% For P = 0.6, my answer to Part C is 24019.
% Code for Part C is in file findN.m.
% Thank you.

