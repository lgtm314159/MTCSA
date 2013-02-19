% Calculate the similarity (cosine of the angle) between two document
% vectors.
% Solution to Problem 1.

function sim = DocSimilarity(D, E)
  largeOdd = 10000001;
  DV = sparse(1, largeOdd);
  EV = sparse(1, largeOdd);
  SV = createSWVector();
  for i = 1:length(D)
    j = hash(char(D(i)), largeOdd);
    if (length(char(D(i))) >= 3) && SV(1, j) ~= 1
      DV(1, j) = DV(1, j) + 1;
    end
  end
  for i = 1:length(E)
    j = hash(char(E(i)), largeOdd);
    if length(char(E(i))) >= 3 && SV(1, j) ~= 1
      EV(1, j) = EV(1, j) + 1;
    end
  end
  display(DV);
  display(EV);
  sim = dot(DV, EV) / (norm(DV) * norm(EV));
end