%%%%%%%%%%%%%%%%%%%%%% MGT-418 Convex Optimization %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Project 3 / Question 2.2 %%%%%%%%%%%%%%%%%%%%%%%%%%
                       %% Reconstruct Mona Lisa %%
clear;
%Load the image
img_true = imread('monalisa.png');
%Convert to double
img_true = double(img_true);
%Resize the image
m = 256; 
img_true = imresize(img_true,[m m]);

%%
%Generate the partial image (denote by img)
%Try to use vector and matrix operations for efficiency

%Type your code here...

%%
%Solve problem (2) to reconstruct the image (denote the reconstructed image by x)
%Try to use vector and matrix operations 
%as well as the matlab function diff(.) and norm(.) for efficiency

%Type your code here

%%
%Visualization
figure; axis image off;
subplot(131); imagesc(uint8(img_true)); axis image off; title('true image'); 
subplot(132); imagesc(uint8(img)); axis image off; title('partial image');
subplot(133); imagesc(uint8(value(x))); axis image off; title('reconstructed image');
