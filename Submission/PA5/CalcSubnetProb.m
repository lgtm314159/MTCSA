% Function to calculate the probability of a subnet.

function prob = CalcSubnetProb(Subnet, OriginNet, P)
  prob = 0;
  totalLinks = length(find(tril(OriginNet)));
  currentLinks = length(find(tril(Subnet)));
  if (currentLinks == 0)
    prob = P ^ totalLinks;
  else if (totalLinks == currentLinks)
    prob = (1 - P) ^ totalLinks;
  else
    prob = (1 - P) ^ currentLinks * P ^ (totalLinks - currentLinks);
  end
end
