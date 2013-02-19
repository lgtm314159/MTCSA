% Function to create stopwords vector.

function s = createSWVector()
  %largeOdd = 39916801
  largeOdd = 10000001;
  s = sparse(1, largeOdd);
  GetStopwords();
  for i = 1:length(stopwords)
    j = hash(char(stopwords(i)), largeOdd);
    s(1, j) = 1;
  end
  s;
end

