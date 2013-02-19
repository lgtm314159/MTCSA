% Function to draw an ellipse.
% Solution to Problem 2.A.

function pointMat = Ellipse(p, a, b, theta)
  iMat = 1:101;
  fineMat = (iMat - 1) * 2 * pi / 100;
  xDiffMat = a * cos(theta) * cos(fineMat) - b * sin(theta) * sin(fineMat);
  yDiffMat = a * sin(theta) * cos(fineMat) + b * cos(theta) * sin(fineMat);
  diffMat = [xDiffMat; yDiffMat];
  pointMat = repmat(p, 1, 101) + diffMat;
  plot(pointMat(1, :), pointMat(2, :), 'color', [0,0,0]);
  axis equal;
  pointMat;
end
