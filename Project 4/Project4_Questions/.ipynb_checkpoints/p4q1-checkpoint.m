%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Project 4, Question 1 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 0, Clean up Matlab
clc
clear
close all

%% 1, Load data in per unit format and extract useful information
% load either 'IEEE9data' or 'IEEE118data'
load ...

% number of nodes
N = length(data.p.min);

%% 2, Declare decision variables
pg = ...;           % active power generation
qg = ...;           % reactive power generation   
E = ...;			% matrix of products between real parts of nodal voltage phasors, needs to be symmetric
F = ...;			% matrix of products between imaginary parts of nodal voltage phasors, needs to be symmetric
H = ...;		    % matrix of products between real and imaginary parts of nodal voltage phasors, does not need to be symmetric

%% 3, Define objective
obj = ...;

%% 4, Define constraints
con = [];
...

%% 5, Set and run solver
ops = sdpsettings('solver', 'mosek', 'verbose',0);
diagnosis = optimize(con, obj, ops);

%% 6, Retrieve results
obj = value(obj);
pg = value(pg);
qg = value(qg);
E = value(E);
F = value(F);
H = value(H);