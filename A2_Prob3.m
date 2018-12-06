% Runs experiment for HW2, Problem 3
diary('forwardSubDiary4')
%% Initialization.
clear; clc


% Set vector of problem sizes.
m = [50; 100; 200; 400; 800; 1600; 3200; 6400];


% number of problems to solve.
Nm = length(m);

% number of trials to run for each m.
Nt = 10;

% Matrix of run-times.
rt = zeros(Nm, Nt);

%% Run the experiment.

% Step table of results.
fprintf('\n+++++++++++++++++++++++++++++++++++++++++++')
fprintf('\nRun-times')
fprintf('\n+++++++++++++++++++++++++++++++++++++++++++\n')

for i = 1:Nm;    
    
    % Record the current problem size (for simplicity in code).
    mm = m(i);
    
    % Initialize x.
    x = zeros(m(i),1);
    
    % Run Nt trials.
    for t = 1:Nt
        w = rand((m(i))) + ones((m(i)));
        L = tril(w);
        % Generate L. Make m by m random matrix with entries in [1,2]. 
        % Then use tril to transform to a lower triangular one.      
        
        
        % Generate b.
        b = rand((mm),1);
        
        % Start timer.
        tic;
        
        % Call forward sub solver.
        x = forwardsub(L, b);
        
        % Stop timer.
        rt(i,t) = toc;
        
        % Print results.
        % Reports relative error between b and L*x and run time.
        fprintf('m: %5d |err: %1.5e | run-time: %1.5e\n', mm, norm(L*x - b)/norm(x), rt(i,t))
    end
    
end

%% Plot data.
figure; % Make new plot window.
loglog(m, mean(rt,2)); % Log-log plot.
xlabel('Problem size (m)')
ylabel('Run-time')
set(gca, 'FontSize', 14)

save('HW2Workspace')

