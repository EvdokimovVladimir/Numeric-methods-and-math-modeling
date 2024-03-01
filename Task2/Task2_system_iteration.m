clear;
clc;

%% Input parameters 

% M = [0.32 -0.05 0.11 -0.08;
%      0.11 0.16 -0.28 -0.06;
%      0.08 -0.15 0.00 0.12;
%      -0.21 0.13 -0.27 0.00];
% A = eye(size(M)) - M;

A = [0.68 0.05 -0.11 0.08;
     -0.11 0.84 0.28 0.06;
     -0.08 0.15 1.00 -0.12;
     0.21 -0.13 0.27 1.00];
b = [0.77; 2.65; 2.74; 4.76];
eps = 1e-100;

dA = det(A);

if abs(dA) < 1e-10
    error("Det(A) is close to zero! \nIt should be non zero: det(A) = " + string(det(A)));
elseif abs(dA) < 1e-5
    warning("It should be non zero: det(A) = " + string(det(A)));
end
disp("It should be non zero: det(A) = " + string(det(A)));


%% Preparing matrix and vector

% Lower-Upper-Diagonal decomposition
% L = tril(A, -1);
% U = triu(A, 1);
% D = diag(diag(A));
% 
% // A = M - N
% // x = (M^-1 * N) * x + (M^-1 * b)
% select M, N - calculated
% M = D; % Jacobi
% M = D + L; % Gauss-Zeidel
% N = M - A;
% 
% shorts for (M^-1 * N) and (M^-1 * b)
% alpha = M \ N;
% beta = M \ b;

% anoter method
% cast some magic to solve error)
magicNumber = 1;
alpha = eye(size(A)) - A / magicNumber;
beta = b / magicNumber;

if max(sum(abs(alpha), 2)) < 1
    q = max(sum(abs(alpha), 2));
    rho = @(x) max(abs(x));
elseif max(sum(abs(alpha), 1)) < 1
    q = max(sum(abs(alpha), 1));
    rho = @(x) sum(abs(x));
elseif sum(abs(alpha.^2), "all") < 1
    q = sum(abs(alpha.^2), "all");
    rho = @(x) sqrt(sum(x.^2));
else
    q = 0.5;
    rho = @(x) 0;
    error("Method will not converge");
end

%% Iteration solving
p = q / (1 - q);

x0 = zeros(size(beta));
x1 = beta;
iterNum = 0;

while p * rho(x0 - x1) > eps
    x0 = x1;
    x1 = alpha * x1 + beta;
    iterNum = iterNum + 1;
end

x_iteration = x1;

%% Zeidel iteration

x0 = zeros(size(beta));
x1 = beta;
iterNum_Zeidel = 0;

while p * rho(x0 - x1) > eps
    x0 = x1;
    for i = 1:length(x1)
        x1(i) = alpha(i, :) * x1 + beta(i);
    end
    iterNum_Zeidel = iterNum_Zeidel + 1;
end

x_Zeidel = x1;

%% Results
x_iteration
x_Zeidel
x_matrix = A \ b
dx_iteration = rho(x_iteration - x_matrix)
dx_Zeidel = rho(x_Zeidel - x_matrix)

iterNum
iterNum_Zeidel




