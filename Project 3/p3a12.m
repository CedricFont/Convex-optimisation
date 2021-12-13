%%%%%%%%%%%%%%%%%%%%%% MGT-418 Convex Optimization %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Project 3 / Question 1.2 %%%%%%%%%%%%%%%%%%%%%%%%%%
                      %% Denoise the dog image %%

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

%Regularization weight
rho = 0.0025; 

%%
%%%%%%%%%%%%%%%%% Solve problem (1) to denoise the image %%%%%%%%%%%%%%%%%%

% Decision variables
x = sdpvar(m,m,'full');

% Objective function
x_11 = diff(x);
x_12 = transpose(diff(x'));
objective = norm(img_noisy - x,'fro') + rho*(norm([x_11(:)' x_12(:)'],1));

% Constraints
constraints = [];

% Specify solver settings and run solver
ops = sdpsettings('solver', 'mosek', 'verbose', 1);
diagnosis = optimize(constraints, objective, ops);

%%
%Visualization
figure;
subplot(131); imshow(img_true,[]); axis image off; title('true image'); 
subplot(132); imshow(img_noisy,[]); axis image off; title('noisy image'); 
subplot(133); imshow(value(x),[]); axis image off; title('denoised image'); 
