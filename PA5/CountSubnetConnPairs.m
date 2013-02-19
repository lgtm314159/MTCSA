% Function to count the connected pairs of a subnet.

function numPairs = countSubnetConnPairs(Subnet)
  CCs = ConnComps(Subnet);
  numPairs = 0;
  for i = 1:length(CCs)
    cc = cell2mat(CCs(i));
    numPairs = numPairs + length(cc) * (length(cc) - 1) / 2;
  end
end

