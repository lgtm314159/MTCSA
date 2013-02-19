function prob = FindVolume()
  count = 0;
  N = 1000000000;
  for i = 1:N
    x = rand() * 32;
    x = x - 16;
    y = rand() * 16;
    y = y - 8;
    z = rand() * 2;
    z = z - 1;
    if ((abs(x))^(1/2) + 2*(abs(y))^(1/3) + 4*(abs(z))^(1/4) <= 4)
      count = count + 1;
    end
  end
  count
  prob = count / N;
end
