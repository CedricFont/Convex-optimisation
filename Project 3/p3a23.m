%%%%%%%%%%%%%%%%%%%%%% MGT-418 Convex Optimization %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Project 3 / Question 2.2 %%%%%%%%%%%%%%%%%%%%%%%%%%
                     %% Reconstruct the unknown %%

clearvars; close all; clc;
%Load the image
img = imread('unknown.png');
%Convert to double
img = double(img);
m = 256; %the size of the image is 256*256

%%
%Find the pixels that are not white
%Specifically, generate a logical matrix I by letting
%I(i,j) = 1 if pixel (i,j) is not white, I(i,j) = 0 otherwise
I = (img(:,:,1)~=255 | img(:,:,2)~=255 | img(:,:,3)~=255);

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
constraints = [constraints, x.*repmat(I,[1,1,3]) == img.*repmat(I,[1,1,3])];

% Specify solver settings and run solver
ops = sdpsettings('solver', 'mosek', 'verbose', 1);
diagnosis = optimize(constraints, objective, ops);

%%
%Visualization
figure; axis image off;
subplot(121); imagesc(uint8(img)); axis image off; title('partial image');
subplot(122); imagesc(uint8(value(x))); axis image off; title('reconstructed image');
