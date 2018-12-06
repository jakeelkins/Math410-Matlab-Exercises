% Tests stability of Gaussian elimination for random inputs.


%% Initialize experimental parameters.
diary('HW5diary')
A = 0;
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
    
    for t = 1:ntrials; % repeat ntrials times for each.
        
        % Generate a random n x n matrix using randn:
        A = rand(ni);
        
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
averr = zeros(4, nn);

% Record average errors for GE without pivoting.
averr(1,:) = mean(err_np, 2)';
averr(2,:) = std(err_np,0,2)';

% Same for GE with pivoting.
averr(3,:) = mean(err_np, 2)';
averr(4,:) = std(err_np,0, 2)';

%% Print error statistics.

% Set up results table.
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('    | Average (standard deviation) of Backward Error \n')
fprintf('n   | without pivoting        | with pivoting \n')
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
for i = 1:nn
    ni = n(i);
    
    % Print error statistics for ni.
    fprintf('%3d | %1.4e (%1.4e) | %1.4e (%1.4e) \n', ni, averr(1, i) , averr(2,i), averr(3,i), averr(4,i));
    
end






