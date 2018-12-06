function x = solvediag(D,b)

% Solves Dx = Diag(d)x = b for x
%+++++++++++++++++++++++++++++++++++++++++++++++
% Input:
%+++++++++++++++++++++++++++++++++++++++++++++++
% D: diagonal coefficient matrix.
% b: right-hand side vector.
%+++++++++++++++++++++++++++++++++++++++++++++++
% Output:
%+++++++++++++++++++++++++++++++++++++++++++++++
% x: solution of linear system Dx = b.
%+++++++++++++++++++++++++++++++++++++++++++++++

% Extract diagonal of D.
d = diag(D);

% Check that D is nonsingular. Break and give an error if not.
if(any(d==0))
   % D is singular.
   error('Zero diagonal entry detected'); 
 
else
    % If D is not singular, solve for x.
    % *** Insert your code for solving Dx = b here.
    x = b./d
end



end
