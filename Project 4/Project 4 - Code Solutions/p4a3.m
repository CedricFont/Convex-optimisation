%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Project 4, Solution 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 0, Clean up Matlab
clc
clear
close all

%% 1, Load data in per unit format and extract useful information
% load either 'IEEE9data' or 'IEEE118data'
load IEEE9data
% number of nodes
N = length(data.p.min);

%% 2, Declare decision variables
alpha = sdpvar(N,1);           % meet active power demand
beta = sdpvar(N,1);            % meet reactive power demand
gammal = sdpvar(N,1);          % lower bound active power generation
gammau = sdpvar(N,1);          % upper bound active power generation
deltal = sdpvar(N,1);          % lower bound reactive power generation
deltau = sdpvar(N,1);          % upper bound reactive power generation
phil = sdpvar(N,1);            % lower bound nodal voltage magnitude
phiu = sdpvar(N,1);            % upper bound nodal voltage magnitude

%% 3, Define objective
obj = data.p.d'*alpha + data.q.d'*beta + data.p.min'*gammal - data.p.max'*gammau + data.q.min'*deltal - data.q.max'*deltau + data.v.min.^2'*phil - data.v.max.^2'*phiu;

%% 4, Define constraints
con = [];
% equality constraint for dual variables associated with active power
con = [con; data.c - alpha - gammal + gammau == 0];
% equality constraint for dual variables associated with reactive power
con = [con; beta + deltal - deltau == 0];
% positive semi-definiteness constraint for dual variables associated with
% the active and reactive nodal power balance
X = ([diag(alpha)*data.G + data.G'*diag(alpha) , -diag(alpha)*data.B + data.B'*diag(alpha); diag(alpha)*data.B - data.B'*diag(alpha) , diag(alpha)*data.G + data.G'*diag(alpha)]) ...
    + ([-diag(beta)*data.B - data.B'*diag(beta) , -diag(beta)*data.G + data.G'*diag(beta) ; diag(beta)*data.G - data.G'*diag(beta) , -diag(beta)*data.B - data.B'*diag(beta)]) ...
    + 2*diag([phiu - phil; phiu - phil]);
con = [con; X >= 0];
% non-negativity of dual variables associated with primal inequality
% constraints
con = [con; [gammal; gammau; deltal; deltau; phil; phiu] >= 0];

%% 5, Set and run solver - maximizing obj is equivalent to minimizing -obj
ops = sdpsettings('solver', 'mosek', 'verbose',0);
diagnosis = optimize(con, -obj, ops);

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
X = value(X);