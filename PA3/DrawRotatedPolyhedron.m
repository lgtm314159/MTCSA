function R = DrawRotatedPolyhedron(M, P)
  sizeP = size(P);
  RotP = cell(1, sizeP(1, 2));

  % Apply matrix M to each of the points in P.
  for i = 1:sizeP(1, 2)
    RotP{i} = M * P{i};
  end

  % Exclude faces that are not visible from below.
  for i = 1:sizeP(1, 2)
    a = RotP{i}(:, 1);
    b = RotP{i}(:, 2);
    c = RotP{i}(:, 3);
    crossProd = cross(c - b, a - b);
    if crossProd(3, 1) > 0
      % Delete the invisible face for easier debugging.
      RotP{i} = [];
    else
      X = RotP{i}(1, :);
      Y = RotP{i}(2, :);
      plot([X, X(1)],[Y, Y(1)], 'black');
      hold on;

      sizeFace = size(RotP{i});
      o = RotP{i} * ones(sizeFace(2), 1) / sizeFace(2);
      % Calculate the vector of each edge and its length.
      edgeVecMat = [RotP{i}(:, 2:sizeFace(2)), RotP{i}(:, 1)] - RotP{i};
      edgeVecLenMat = sqrt(diag(edgeVecMat' * edgeVecMat)');
      % Calculate the direction vector of each edge.
      dirVecMat = edgeVecMat ./ repmat(edgeVecLenMat, 3, 1);
      % Calculate the coordinate of o's projection on each edge.
      dotProdVec = diag((repmat(o, 1, sizeFace(2)) - RotP{i})' * dirVecMat)';
      projMat = RotP{i} + repmat(dotProdVec, 3, 1) .* dirVecMat;
      % Calculate the radius r.
      perpMat = repmat(o, 1, sizeFace(2)) - projMat;
      distVec = sqrt(diag(perpMat' * perpMat));
      r = min(distVec) / 2;
      % Find two othorgonal vector on the face.
      u = (a - b) / norm(a - b);
      dirU = u / norm(u);
      cProjOnAB = b + dot(c - b, dirU) * dirU;
      v = (c - cProjOnAB) / norm(c - cProjOnAB);
      tVec = 0:100;
      pointMat = repmat(o, 1, 101) + u * r * cos(2 * pi / 100 * tVec) + v * r * sin(2 * pi / 100 * tVec);
      plot(pointMat(1, :), pointMat(2, :), 'black');
    end
  end
  axis equal;
  R = RotP;
end
