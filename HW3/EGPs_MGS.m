function [Q,R]=mgs(A)

% Implementation of the Modified Gram-Schmidt orthogonalization
% of column vectors of the input matrix A.

[m,n]=size(A);

V = A;

Q = zeros(m,n);
R = zeros(n,n);

for j=1:n

  R(j,j) = norm(V(:,j),2);
  Q(:,j) = V(:,j)/R(j,j);
  
  for k=(j+1):n
    R(j,k) = Q(:,j)'*V(:,k);
    V(:,k) = V(:,k)-R(j,k)*Q(:,j);
  end % for(k)
  
end % for(j)
