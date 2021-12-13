%%%%%%%%%%%%%%%%%%%%%% MGT-418 Convex Optimization %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Project 3 / Question 2.2 %%%%%%%%%%%%%%%%%%%%%%%%%%
                     %% Reconstruct the unknown %%
clear;
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
%Solve problem (2) to reconstruct the image (denote the reconstructed image by x)
%Try to use vector and matrix operations 
%as well as the matlab function diff(.) and norm(.) for efficiency

%Type your code here

%%
%Visualization
figure; axis image off;
subplot(121); imagesc(uint8(img)); axis image off; title('partial image');
subplot(122); imagesc(uint8(value(x))); axis image off; title('reconstructed image');