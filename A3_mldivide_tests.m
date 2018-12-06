% Runs trials to reverse engineer factorizations used by mldivide

% Clear screen and workspace.
clear;
clc;

%% Initialization.
diary('mldivide')
% dimension of problem.
m = 2000;

% number of trials.
nTrials = 25;

% perturbation parameter.
beta = 1e-15;

% Run-time matrix. Columns store runtimes for each perturbation. Rows for
% each trial.
times = zeros(nTrials, 7);

% Make standard basis vectors.
e1 = zeros(m,1); e1(1) = 1;
e2 = zeros(m,1); e2(2) = 1;

% Initialize/allocate solution variable x.
x = zeros(m,1);

% Set up results table.
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('i   | solvediag  | mldivide   | A1         | A2         | A3         | A4         | A5     \n')
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')

%% Timing experiment.
for i = 1:nTrials
    
    % Make A.
    % *** insert code for generating A here.
    A = diag(rand(m,1));
    % Make b.
    % *** insert code for generating b here
    b = rand(m,1);
    %% Test your diagonal solver.
    
    % Start tic.
    tic
    % Call solvediag(A,b);
    x = solvediag(A,b);

    
    % Stop timer with toc. Save elapsed time as times(i, 1);
    times(i, 1) = toc;
    
    %% Repeat using mldivide.
    
    % Start tic.

    tic
    % Solve Ax = b using backslash/mldivide.
    x = b.\A;
    
    % Stop timer with toc. Save elapsed time as times(i, 2);
    times(i, 2) = toc;
    
    %% Perturb by e1e2'.
    I = eye(m);
    e1 = I(1,m);
    e2 = I(2,m);
    % Form E1.
    E1 = e1*e2';
    
    % Form A1 = A +beta E1.    
    A1 = A +(beta*E1);
    
    % Start tic.
    tic
    
    % Solve using backslash.
    x = b.\A;
    
    % Stop timer. Save elapsed time as times(i,3);
    times(i,3) = toc;
    
    %% Perturb by e1e2' + e2'e1.
    
    % Form E2.
    E2 = E1+E1';
    
    % Form A2 = A +beta E2.   

    A2 = A +(beta*E2);
    % Start tic.

    tic
    % Solve using backslash.
    x = b.\A;
    
    % Stop timer. Save elapsed time as times(i,4);
    times(i,4) = toc;
    
    %% Perturb by upper triangular matrix.
    
    % Form E3.
    E3 = triu(rand(m));
    
    % Form A3 = A +beta E3.   
    A3 = A +(beta*E3);
    
    % Start tic.
    tic
    
    % Solve using backslash.
    x = b.\A;
    
    % Stop timer. Save elapsed time as times(i,5);
    times(i,5) = toc;
    
    %% Perturb by Hermitian positive definite matrix.
    
    % Form E4.
    E4 = rand(m);
    E4 = E4*E4';
    % Form A4.
    A4 = A +(beta*E4);
    
    % Start tic.
    tic
    
    % Solve using backslash.

    x = b.\A;
    % Stop timer. Save elapsed time as times(i,6);

    times(i,6) = toc;
    %% Perturb by unstructured matrix.
    
    % form E5.
    E5 = rand(m);
    
    % Form A5.
    A5 = A +(beta*E5);
    
    % Start tic.
    tic
    
    % Solve using backslash.

    x = b.\A;
    % Stop timer. Save elapsed time as times(i,7).
    times(i,7) = toc;
    
    %% Print iteration statistics.
    fprintf('%3d | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e \n', i, times(i,1), times(i,2), times(i,3), times(i,4), times(i,5), times(i,6), times(i,7));
    
end

%% Summary Statistics.

% Compute mean and standard deviation.
avg = mean(times);
dev = std(times);

%%

% Make table.
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('avg | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e \n', avg(1), avg(2), avg(3), avg(4), avg(5), avg(6), avg(7));
fprintf('std | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e | %1.4e \n', dev(1), dev(2), dev(3), dev(4), dev(5), dev(6), dev(7));
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')