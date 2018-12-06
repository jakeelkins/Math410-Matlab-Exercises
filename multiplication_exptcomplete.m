diary('HW1diary')

% Set vector of dimensions.
n = 2500:-100:100;

% set number of trials.
ntrials = 10;

% Matrices of runtimes (all initially zero matrices).
tmm = zeros(length(n), ntrials);
tmv = tmm;
tmatlab = tmm;

% Initialize display.
fprintf(' n    | matmat   | matvec   | matlab  \n ')
fprintf('++++++++++++++++++++++++++++++++++++++++\n')

for i = 1:length(n)
    for t = 1:ntrials
        

        % Randomly sample A, B and x.
        A = rand(length(n));
        B = rand(length(n));
        x = rand((length(n)),1);

        % Initialize intermediate products.
        AB = zeros(n(i));
        Bx = zeros(n(i), 1);
        ABx = Bx; % also all-zeros vector.

        % record runtime to calculate A*B*x using three methods.
        % 1. (AB)*x.
        tic % start timer.
        % Evaluate A*B then AB*x
        AB = A*B;
        ABx = (AB)*x;
        tmm(i,t) = toc; % stop timer.

        % 2. A*(Bx)
        tic % start timer.
        % Evaluate B*x then A*(B*x).
        Bx = B*x;
        ABx = A*(B*x);
        tmv(i,t) = toc; % stop timer.

        % 3. Matlab's choice.
        tic % start timer.
        % Evaluate A*b*x.
        ABx = A*B*x;
        tmatlab(i,t) = toc;  % stop timer.

    end

    % Print average run-times for this particular n.
    fprintf('%5g | %3.2e | %3.2e | %3.2e  \n', n(i), mean(tmm(i,:)), mean(tmv(i,:)), mean(tmatlab(i,:)))
end

save('HW1workspace')
%%
% Plot runtimes.
loglog(n, mean(tmm,2), n, mean(tmv,2), n, mean(tmatlab,2))
hold('on')
xlim([100, 2500])
xlabel('n')
ylabel('mean run time')
set(gca, 'FontSize', 14)
legend('Matrix-Matrix', 'Matrix-Vector', 'Matlab default', 'Location', 'northwest')
hold('off')
