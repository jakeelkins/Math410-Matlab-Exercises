% Tests stability of Gaussian elimination for random inputs.

%% Initialize experimental parameters.
diary('hw5bdiary')
% Matrix sizes.
n = [20; 40; 80; 160; 240];
nn = length(n);

% Number of trials.
ntrials = 10;

% Initialize error and L,U norm matrices.
err_np = zeros(nn, ntrials); % error without pivoting.
L_np = zeros(nn, ntrials); % matrix of L norms.
U_np = zeros(nn, ntrials); % matrix of U norms.

err = zeros(nn, ntrials); % error with pivoting.
L_p = zeros(nn, ntrials); 
U_p = zeros(nn, ntrials);

%% Run experiments.

for i = 1:nn % For each matrix size n(i).
    % Record current matrix size.
    ni = n(i); 
    
    for t = 1:ntrials % repeat ntrials times for each.
        
        % Generate a random ni x ni matrix using randn:
        A = rand(ni);
        
        % Replace A(1,1) with small number.
        A(1,1) = 10*(eps)*A(1,1);
        
        % Find LU decomposition using GE without pivoting.
        [L,U] = lu_wout_pivot(A);
        
        % Find LU decomposition with GE with pivoting.
        [L2, U2] = lu(A);
        
        % Calculate relative backward error using the infinity
        % norm.
        err_np(i, t) = norm(L*U - A, 'inf')/norm(A,'inf');
        
        % Calculate norms of L and U.
        L_np(i,t) = norm(L, 'inf');
        U_np(i,t) = norm(U, 'inf');
        
        % Calculate relative backward error using the infinity
        % norm.
        err(i,t) = norm(L2*U2 - A, 'inf')/norm(A,'inf');
        
        % Calculate norms of L and U.
        L_p(i,t) = norm(L2, 'inf');
        U_p(i,t) = norm(U2, 'inf');
    end        
    
end

%% Calculate error statistics.
% initialize average/standard deviation of errors.
results = zeros(12, nn);

% Record average errors and norms for GE without pivoting.
results(1,:) = mean(err_np, 2)'; % mean error
results(2,:) = std(err_np,0,2)'; % std error.
results(3,:) = mean(L_np, 2)'; % mean L norm.
results(4,:) = std(L_np, 0, 2)'; % std L norm.
results(5,:) = mean(U_np, 2)'; % mean U norm.
results(6,:) = std(U_np, 0, 2)'; % std U norm.

% Same for GE with pivoting.
results(7,:) = mean(err, 2)'; % mean error
results(8,:) = std(err, 0,2)'; % std error.
results(9,:) = mean(L_p, 2)'; % mean L norm.
results(10,:) = std(L_p, 0, 2)'; % std L norm.
results(11,:) = mean(U_p, 2)'; % mean U norm.
results(12,:) = std(U_p, 0, 2)'; % std U norm.

%% Print error statistics.

% Set up results table.
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('    | Without Pivoting (mean (standard deviation))                | With Pivoting (mean (standard deviation)) \n')
fprintf('n   | Error              | norm(L)            | norm(U)            | Error              | norm(L)            | norm(U)            \n')
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
for i = 1:nn
    ni = n(i);
    
    % Print error statistics for ni.
    fprintf('%3d ', ni)
    for j = 1:6
     fprintf('| %1.2e (%1.2e)', results(2*j-1, i), results(2*j, i) )
    end
    fprintf('\n')
    
end





