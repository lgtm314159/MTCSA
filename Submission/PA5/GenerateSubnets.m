function Subnets = GenerateSubnets(E)
  Subnets = {E};
  lowTriE = tril(E);
  % Get the row and column indexes of the none-zero elments (1 in our case)
  % of lowTriE;
  [r, c] = find(lowTriE);
  % This is a vector consisting the index of the row/column indexes.
  % I am going to use the combinations of its values to help indexing into
  % the links that should be change to broken in order to exaust all the
  % possible subnets.
  v = [1:length(r)];
  for i = 1:(length(r) - 1)
    % Get the combinations of C(n,i).
    comb = nchoosek(v, i);
    combSize = size(comb);
    for j = 1:combSize(1)
      tempE = lowTriE;
      for k = 1:combSize(2)
        % Change the link to be broken in order to generate a possible subnet.
        tempE(r(comb(j, k)), c(comb(j, k))) = 0;
      end
      tempE = tempE + tempE';
      Subnets(end + 1) = {tempE};
    end
  end
end

