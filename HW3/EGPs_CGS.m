function [Q,R]=cgs(A)
% Implementation of the Classical Gram-Schmidt orthogonalization
% of column vectors of the input matrix A.

[m,n]=size(A);
V = A;

Q = zeros(m,n);
R = zeros(n,n);

for j=1:n

  for i=1:(j-1)
    R(i,j) = Q(:,i)'*A(:,j);
    V(:,j) = V(:,j)-R(i,j)*Q(:,i);
  end % for(i)
  
  R(j,j) = norm(V(:,j));
  Q(:,j) = V(:,j)/R(j,j);
  
end % for(j)
