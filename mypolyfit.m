%% Initialization.
diary('polysysdiary')
% Declare function to be fit.
f = @(x) sin(2*pi*x);

% Choose number of sampling points.
m = 50;

% Choose degree of polynomial to fit (n-1).
n = 12;

% Choose interval [a,b] to fit on.
a = 0;
b = 1;

% Make set of sampling points.
x = linspace(a, b, m);
x = x';

%% Make least squares problem.

% Call polysys function.
[A,b] = polysys(f, x, n);

%% Normal Equations.

% Start timer.
tic; 

% Form normal equations coefficient matrix. A'A = C
C = A'*A;

% Form normal equations right-hand side.
y = A'*b;

% Solve normal equations using \ (call solution cn).
cn = C\y;

% Stop timer.
tn = toc;

%% QR factorization.

%Start timer.
tic;

% Take QR factorization of A.
[Q,R] = qr(A);

% Solve least squares problem using QR (call solution cq).
cq = R\(Q'*b);

% Stop timer.
tq = toc;

%% SVD.

% Start timer.
tic;

% Take reduced SVD A = U*S*V';
[U,S,V] = svd(A);
% Solve the system U*S*V'*x = b.
x = (U*S*V')\b;
% "Invert" U.
U = U';
% Invert S.
S = S';
S = inv(S(1:12,1:12));
S = [S, zeros(12,38)];
% Invert V' to solve least squares problem (call solution cs).
cs = V'\(S*U*b);
% Stop timer.
ts = toc;

%% Print results.

fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('Method: Normal eqs | QR            | SVD       \n')
fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('Time: %+1.5e | %+1.5e  | %+1.5e     \n', tn, tq, ts)


for i = 1:n
    
    fprintf('c%2d:  %+1.5e | %+1.5e  | %+1.5e  \n', i-1, cn(i), cq(i), cs(i) )
end
diary off