%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Project 4, Question 3 %
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
alpha = ...;           % meet active power demand
beta = ...;            % meet reactive power demand
gammal = ...;          % lower bound active power generation
gammau = ...;          % upper bound active power generation
deltal = ...;          % lower bound reactive power generation
deltau = ...;          % upper bound reactive power generation
phil = ...;            % lower bound nodal voltage magnitude
phiu = ...;            % upper bound nodal voltage magnitude

%% 3, Define objective
obj = ...;
    
%% 4, Define constraints
con = [];
...

%% 5, Set and run solver
ops = sdpsettings('solver', 'mosek', 'verbose',0);
diagnosis = ...;

%% 6, Retrieve results
obj = value(obj);
alpha = value(alpha);
beta = value(beta);
gammal = value(gammal);
gammau = value(gammau);
deltal = value(deltal);
deltau = value(deltau);
phil = value(phil);
phiu = value(phiu);