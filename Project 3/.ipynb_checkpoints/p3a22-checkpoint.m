%%%%%%%%%%%%%%%%%%%%%% MGT-418 Convex Optimization %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Project 3 / Question 2.2 %%%%%%%%%%%%%%%%%%%%%%%%%%
                       %% Reconstruct Mona Lisa %%

clearvars; close all; clc;
%Load the image
img_true = imread('monalisa.png');
%Convert to double
img_true = double(img_true);
%Resize the image
m = 256; 
img_true = imresize(img_true,[m m]);

%%
%%%%%%%%%%%%%%%%%%%%%%% Generate the partial image %%%%%%%%%%%%%%%%%%%%%%%%

% Randomly select indices to be kept
I_keep = (rand(m,m) < 0.40);
I_keep = repmat(I_keep,[1,1,3]);

% Construct partial image and set deleted pixels to white = (255,255,255)
img = img_true.*I_keep + 255*(ones(m,m,3) - I_keep);

%%
%%%%%%%%%%%%%%% Solve problem (2) to reconstruct the image %%%%%%%%%%%%%%%%

% Decision variables
x = sdpvar(m,m,3,'full');

% Objective function
x_11 = diff(x(:,:,1));
x_12 = transpose(diff(x(:,:,1)'));
x_21 = diff(x(:,:,2));
x_22 = transpose(diff(x(:,:,2)'));
x_31 = diff(x(:,:,3));
x_32 = transpose(diff(x(:,:,3)'));
objective = norm([x_11(:)' x_12(:)'],1) + norm([x_21(:)' x_22(:)'],1) + norm([x_31(:)' x_32(:)'],1);

% Constraints
constraints = [];
constraints = [constraints, x.*I_keep == img.*I_keep];

% Specify solver settings and run solver
ops = sdpsettings('solver', 'mosek', 'verbose', 1);
diagnosis = optimize(constraints, objective, ops);

%%
%Visualization
figure;
subplot(131); imagesc(uint8(img_true)); axis image off; title('true image'); 
subplot(132); imagesc(uint8(img)); axis image off; title('partial image');
subplot(133); imagesc(uint8(value(x))); axis image off; title('reconstructed image');
