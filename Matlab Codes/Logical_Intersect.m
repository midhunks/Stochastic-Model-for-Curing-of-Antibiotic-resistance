function A = Logical_Intersect(A)
% Identifies the length of 3rd dimension of input logical matrix A
n= size(A,3); 

% Sum of 2d matrices in the 3d input matrix A
A = sum(A,3); 

% Find a logical matrix that giives the intersecton
      % of all 2d logical matrices in the input matrix A
A = (A == n); 

% Identifies the number of occurances rowwise
A = sum(A,2); %Change 2 to 1 for column-wise checking
end