function [L,U] = lu_wout_pivot(A)
% Performs Gaussian elimination for input matrix A without pivoting.
% Note: requires input matrix A be n x n nonsingular.

% Get size of A.
n = length(A);

% Initialize L and U.
L = eye(n); U = zeros(n);

% Perform Gaussian elimination.
for k = 1:n
    % Update entries of U in kth row.
    U(k, k:n) = A(k, k:n) - L(k, 1:k-1)*U(1:k-1, k:n);
    
    % Update entries of L in kth column.
    L(k+1:n, k) = ( A(k+1:n,k) - L(k+1:n, 1:k-1)*U(1:k-1, k) )/U(k,k);
end



