%% CVX 2021-2022 Project 5 
% Make sure you have a SDP solver 
clear all; close all; clc; 


% The given data contains for E trajectories (different initial conditions)
% the vector x_{K+1}.

% load the data 
load xdata

% the dynamics 
Adyn = [0.5 0.8; 0 0.5];
n = size(Adyn,1); 
Q0 = eye(n);
Qw = eye(n); 

% Compute the moments 
K = 10;
(your code here) 

% compute the empirical probability of x being in the safeset 
r = 8; 
E = size(Xdata,2);
(your code here) 

% Define and solve the SDP 
(your code here)

% Print the results (compare the SDP and empirical values).