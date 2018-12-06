% LU factorization problem generator.

function [A, L,U] = LUprob(n)

% Makes n times n random matrix with integer entries of practicing LU
% decomposition.

A = zeros(n); % initialize A as all-zeros matrix.

while (det(A) == 0) % Run until A is nonsingular.
    
    % Make random lower triangular L matrix with integer entries between -10
    % and 10.
    L = round(20*rand(n)-10); L = tril(L);
    
    % Replace diagonal entries of L with ones.
    L = L - diag(diag(L)) + eye(n);
    
    % Make random lower triangular matrixU with integer entries between -10
    % and 10.
    U = round(20*rand(n)-10); U = triu(U);
    
    % Make A.
    A = L*U;       
        
    
end

