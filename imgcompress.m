diary('imgcompressdiary')
%% Read image from Matlab's image library.

A = imread('moon.tif');
A = double(A);

%% Display as a grayscale image.
figure; % Open new figure box.
colormap('gray') % Make image grayscale.
imagesc(A); set(gca,'DataAspectRatio',[1 1 1]); % Display matrix as image. Last part maintains aspect ratio.

%% Take SVD.

[U,S,V] = svd(A); % Use "svd" to find SVD A = U*S*V'.


%% Use singular values to estimate an acceptable rank k for compression.

% Number of k to try (k = 1,2,..., r).
r = 100;

sig = diag(S); % Extract vector of singular values using "diag" command. Store as variable
               % called "sig".


% Make vector of relative errors between rank k approximation Ak and A for
% k = 1,2, ..., r.
relerr = (1/sig(1))*sig;

%% Display relative 2-norm errors between A and A1, A2, etc.
% (Don't change).
fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('   k \t| relerr \t| k \t| relerr    \n')
fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++\n')
for k = 1:r/2
    fprintf('% 4d \t| %1.5f \t| %4d \t| %1.5f \n', k, relerr(k), r/2 + k, relerr(r/2 + k))
end
fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++\n')


%% Plot relative errors.
% (Don't change).
figure;
plot(1:50, sig(1:50)/sig(1))

%% Plot compressed A.
% (Don't change).

% Ask user for choice of rank k.
k = input('What choice of k gives relative error < 1%?\nType this value now to compress A.\n>> ')


% Compress A.
Ak = U(:,1:k)*S(1:k, 1:k)*V(:, 1:k)';

% Display Ak.
figure;
colormap('gray')
imagesc(Ak); set(gca,'DataAspectRatio',[1 1 1]); % Display matrix as image. Last part maintains aspect ratio.

%% Display storage required.
% (Don't change).

[m, n] =size(A);

fprintf('\n Image is %d by %d\n', m,n)
fprintf('\n\nStorage needed for A: %d matrix entries (m*n)\n', m*n)
fprintf('Storage needed for Ak: %d entries (k + mk + nk)\n', k + m*k + n*k)
fprintf('Reduction: %f\n\n', 1 - (k + m*k + n*k)/(m*n))

diary off