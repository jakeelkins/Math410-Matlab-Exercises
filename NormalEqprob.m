% least squares and normal equation problem generation. 


function [A, b, ATA, ATb, x] = NormalEqprob(m,n)

% Generates solution of the least squares problem min norm(Ax -b) using the
% normal equations (NA)x = Nb.

if m < n
    error('m < n')
end

A = zeros(m,n);

while (det(A(1:n, 1:n)) == 0) % Run until A has full column rank.
      
% Make A.
A = round(6*rand(m,n) - 3);

% Make normal equations coefficient matrix.
ATA = A'*A;

% Make b and A'b.
b = round(6*rand(m,1) - 3);
ATb = A'*b;

% Solve normal equations.
x = ATA\ATb;
    
end