%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Project 4, Solution 2 %
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
pg = sdpvar(N,1);           % active power generation
qg = sdpvar(N,1);           % reactive power generation   
E = sdpvar(N,N,'symmetric');% matrix of products between real parts of nodal voltage phasors, needs to be symmetric
F = sdpvar(N,N,'symmetric');% matrix of products between imaginary parts of nodal voltage phasors, needs to be symmetric
H = sdpvar(N,N,'full');     % matrix of products between real and imaginary parts of nodal voltage phasors, does not need to be symmetric

%% 3, Define objective
obj = data.c' * pg;

%% 4, Define constraints
con = [];
% nodal power balances
for n = 1:N
    % active power balance
    con = [con; sum( data.G(n,:) .* (E(n,:) + F(n,:)) - data.B(n,:).*(H(n,:) - H(:,n)' )) == pg(n) - data.p.d(n)];
    % reactive power balance
    con = [con; -sum( data.B(n,:) .* (E(n,:) + F(n,:)) + data.G(n,:).*(H(n,:) - H(:,n)' )) == qg(n) - data.q.d(n)];
end
% generation limits
% active power
con = [con; data.p.min <= pg <= data.p.max];
% reactive power
con = [con; data.q.min <= qg <= data.q.max];
% voltage limits
con = [con; data.v.min.^2 <= diag(E) + diag(F) <= data.v.max.^2];
% positive semi-definite
X = [E H; H' F];
% non-negativity of diagonal entries
con = [con; diag(X) >= 0];
% dominance of diagonal elements
for i = 1:2*N
    for j = i+1:2*N
        con = [con; norm( [2*X(i,j); X(i,i) - X(j,j)],2) <= X(i,i) + X(j,j) ];
    end
end

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
X = value(X);