%%%%%%%%%%%%%%%%%%%%%% MGT-418 Convex Optimization %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Project 3 / Question 1.3 %%%%%%%%%%%%%%%%%%%%%%%%%%
                       %% Regularization Swipe %%

clearvars; close all; clc;
%Load the image
img_true = imread('dog.png');
%Convert to double
img_true = double(img_true);
%Resize
m = 256;
img_true = imresize(img_true,[m m]);
%Add noise
gamma = 20;
img_noisy = img_true + gamma*randn(size(img_true));
%Adjust the pixel values such that they are in [0,255]
img_noisy(img_noisy>255) = 255;
img_noisy(img_noisy<0) = 0;

%%
%%%%%%%%%%%%% Solve problem (1) for different values of rho %%%%%%%%%%%%%%%

n=40;
rho_vec = logspace(-4,-1,n);
perf = zeros(n,1);
opt_x = zeros(m,m,n);

for i=1:n

% Display current iteration count
fprintf('Current iteration: %d out of %d \n',i,n);

% Decision variables
x = sdpvar(m,m,'full');

% Objective function
x_11 = diff(x);
x_12 = transpose(diff(x'));
objective = norm(img_noisy - x,'fro') + rho_vec(i)*(norm([x_11(:)' x_12(:)'],1));

% Constraints
constraints = [];

% Specify solver settings and run solver
ops = sdpsettings('solver', 'mosek', 'verbose', 1);
diagnosis = optimize(constraints, objective, ops);

% Save performance
perf(i) = norm(value(x) - img_true,'fro')/norm(img_noisy - img_true,'fro');
opt_x(:,:,i) = value(x);

end

%%
%Visualization

% Plot the performance of the various rho values
figure; loglog(rho_vec, perf,'LineWidth',2);

% Plot the reconstructed image for rho = {10^(-4), 10^(-1), 'best_rho'}
idx_bestrho = find(perf == min(perf));
figure;
subplot(131); imshow(opt_x(:,:,1),[]); axis image off; title('weak reg.'); 
subplot(132); imshow(opt_x(:,:,40),[]); axis image off; title('strong reg.'); 
subplot(133); imshow(opt_x(:,:,idx_bestrho),[]); axis image off; title('best reg.');
