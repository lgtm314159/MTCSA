% Function to get the connected components of a subnet.

function C = ConnComps(Subnet)
  % V is the list of verticies of a subnet.
  V = [1:length(Subnet(1,:))];
  % ConnComps is the list of connected components.
  C = {};
  stack = [];
  visited = zeros(length(V), 1);
  toPop = zeros(length(V), 1);
  for n = 1:length(Subnet(1,:))
    v = V(n);
    if (not(visited(v)))
      % S represents a connected component.
      S = [];
      stack(end + 1) = v;
      visited(v) = 1;
      S(end + 1) = v;
      % Delete v from the list of vertices of input graph.
      while (not(isempty(stack)))
        top = stack(end);
        if (toPop(top))
          stack(end) = [];
          continue;
        else 
          for i = 1:length(Subnet(1,:))
            if (Subnet(top, i) == 1) 
              if (not(visited(i)))
                stack(end + 1) = i;
                visited(i) = 1;
                S(end + 1) = i;
              end
            end
          end
          toPop(top) = 1;
        end
      end
      % Add S to the set of connected component.
      C(end + 1) = {S};
    end
  end
end

