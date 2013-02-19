function res = myFunc(v, B)
  c = zeros(7,1);
  for i=1:length(B(1,:))
    c = c + dot(v, B(:,i))/dot(B(:,i), B(:,i)) * B(:,i);
  end
  res = v - c;
  res = res / norm(res);
end
