% EulerRotation(A,B,C) computes the rotation matrix (in natural coordinates)
% corresponding to the Euler angles A,B,C.  That is, an object is first rotated
% around the z-axis by angle A; then around the x axis by angle B; then around
% the rotated z-axis by angle C.

% If R=EulerRotation(A,B,C) and X is a column vector of the coordinates of
% a point, then RX is the column vector of the image of the point under 
% the rotation.

function R=EulerRotation(A,B,C)
   RA = [ cos(A), -sin(A), 0 ; sin(A), cos(A), 0; 0, 0, 1];
   RB = [ 1, 0, 0; 0, cos(B), sin(B); 0, -sin(B), cos(B)];
   RC = [ cos(C), -sin(C), 0 ; sin(C), cos(C), 0; 0, 0, 1];
   R = RC * RB * RA;
end
