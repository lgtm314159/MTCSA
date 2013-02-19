% Function to draw two ellipses, a line between the furthest two points
% and a line or asterisk between the closest two points.
% Solution for Problem 2.B.

function [minDist, maxDist] = TwoEllipses(p1, a1, b1, theta1, p2, a2, b2, theta2)
  iMat = 1:101;
  fineMat = (iMat - 1) * 2 * pi / 100;
  x1DiffMat = ...
      a1 * cos(theta1) * cos(fineMat) - b1 * sin(theta1) * sin(fineMat);
  y1DiffMat = ...
      a1 * sin(theta1) * cos(fineMat) + b1 * cos(theta1) * sin(fineMat);
  x2DiffMat = ...
      a2 * cos(theta2) * cos(fineMat) - b2 * sin(theta2) * sin(fineMat);
  y2DiffMat = ...
      a2 * sin(theta2) * cos(fineMat) + b2 * cos(theta2) * sin(fineMat);
  diffMat1 = [x1DiffMat; y1DiffMat];
  diffMat2= [x2DiffMat; y2DiffMat];
  pointMat1 = repmat(p1, 1, 101) + diffMat1;
  pointMat2 = repmat(p2, 1, 101) + diffMat2;
  % Draw the two ellipses in black line.
  plot(pointMat1(1, :), pointMat1(2, :), 'color', [0, 0, 0]);
  hold on;
  plot(pointMat2(1, :), pointMat2(2, :), 'color', [0, 0, 0]);
  hold on;
  
  minP1Index = 1;
  minP2Index = 1;
  maxP1Index = 1;
  maxP2Index = 1;
  minDist = norm([(pointMat1(1,1) - pointMat2(1,1)), ...
      (pointMat1(2,1) - pointMat2(2,1))]);
  maxDist = norm([(pointMat1(1,1) - pointMat2(1,1)), ...
      (pointMat1(2,1) - pointMat2(2,1))]);

  % Find the min and max in one pass through the distance values.
  % Process them in pair so the number of comparisons is only 3*(n-1)/2
  % which is optimal (here n = 10201 which is odd).
  for j = 2:2:length(pointMat2(1, :))
    j1 = j;
    tempDist1 = norm([(pointMat1(1,1) - pointMat2(1, j1)), ...
        (pointMat1(2, 1) - pointMat2(2, j1))]);
    j2 = j + 1;
    tempDist2 = norm([(pointMat1(1,1) - pointMat2(1, j2)), ...
        (pointMat1(2, 1) - pointMat2(2, j2))]);
    if (tempDist1 < tempDist2)
      if (tempDist1 < minDist)
        minDist = tempDist1;
        minP2Index = j1;
      end
      if (tempDist2 > maxDist)
        maxDist = tempDist2;
        maxP2Index = j2;
      end
    else       
      if (tempDist2 < minDist)
        minDist = tempDist2;
        minP2Index = j2;
      end
      if (tempDist1 > maxDist)
        maxDist = tempDist1;
        maxP2Index = j1;
      end
    end
  end
  for j = 1:length(pointMat2(1, :))
    for i = 2:2:length(pointMat1(1, :))
      i1 = i;
      tempDist1 = norm([(pointMat1(1,i1) - pointMat2(1, j)), ...
          (pointMat1(2, i1) - pointMat2(2, j))]);
      i2 = i + 1;
      tempDist2 = norm([(pointMat1(1,i2) - pointMat2(1, j)), ...
          (pointMat1(2, i2) - pointMat2(2, j))]);
      if (tempDist1 < tempDist2)
        if (tempDist1 < minDist)
          minDist = tempDist1;
          minP1Index = i1;
          minP2Index = j;
        end
        if (tempDist2 > maxDist)
          maxDist = tempDist2;
          maxP1Index = i2;
          maxP2Index = j;
        end
      else       
        if (tempDist2 < minDist)
          minDist = tempDist2;
          minP1Index = i2;
          minP2Index = j;
        end
        if (tempDist1 > maxDist)
          maxDist = tempDist1;
          maxP1Index = i1;
          maxP2Index = j;
        end
      end
    end
  end

  % Draw a line between the furthest two points and a line/asterisk between
  % the closet two points.
  plot([pointMat1(1,maxP1Index), pointMat2(1,maxP2Index)], ...
      [pointMat1(2,maxP1Index), pointMat2(2,maxP2Index)], 'b');
  hold on;
  if (minDist < 0.1)
    plot((pointMat1(1,minP1Index) + pointMat2(1,minP2Index))/2, ...
        (pointMat1(2,minP1Index) + pointMat2(2,minP2Index))/2, 'r*');
  else
    plot([pointMat1(1,minP1Index), pointMat2(1,minP2Index)], ...
        [pointMat1(2,minP1Index), pointMat2(2,minP2Index)], 'r');
  end
  axis equal;
  [minDist, maxDist];
end
