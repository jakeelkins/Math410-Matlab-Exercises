
function [A,b] = polysys(f, x, n)

% Takes function and vector of sampling points x and generates the
% coefficient matrix A and right-hand side b for the polynomial fitting
% linear system.
%+++++++++++++++++++++++++++++++++++++++++++++++++++
% Input.


% x: vector of sampling points.


% n: degree of poly we would like, plus 1 (n coeffs to find).

%+++++++++++++++++++++++++++++++++++++++++++++++++++
% Output.
% A: Vandermonde matrix corresponding to polyfit linear system.
% b: right-hand side of polyfit system.
%+++++++++++++++++++++++++++++++++++++++++++++++++++
% (N.B. don't change this, it is just a description of the function with 
% list of inputs/outputs).

%% Make A using vander function.

% Initialize A as Vandermonde matrix corresponding to x.
A = vander(x);

% Need to flip from left to right: a_ij = x_i^(m-j). 
A = fliplr(A);

% vander(x) is m by m, need to truncate to m by n.
% Extract first n columns.
A = A(:, 1:n);


%% Make b using function evaluation.
b = f(x);

end