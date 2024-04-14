clear;
clc;
format compact;
format long;

%% Input parameters
lambda = 384;
rho = 8800;
capacitance = 381;

L = 0.1;
N_L = 100;
dL = L / N_L;

t = 100;
N_t = 8000;
dt = t / N_t;

x = 0:dL:L;
t = 0:dt:t;

T_left = 550;
T_right = 700;

T0 = linspace(350, 350, length(x));
T0(1) = T_left;
T0(end) = T_right;

%% Additional variables
T = zeros(length(t), length(x));

A = lambda / dL^2;
B = 2 * lambda / dL^2 + rho * capacitance / dt;
C = lambda / dL^2;
D = - rho * capacitance / dt;

%% Calculation
T(1, :) = T0;

alpha = zeros(size(x));
for i = 2:length(x)
    alpha(i) = A / (B - C * alpha(i - 1));
end
beta = zeros(size(x));
beta(1) = T_left;

for k = 1:(length(t) - 1)
    T(k + 1, end) = T_right;

    for i = 2:length(beta)
        beta(i) = (C * beta(i - 1) - D * T(k, i)) / (B - C * alpha(i - 1));
    end

    for i = length(T(k + 1, :)):-1:2
        T(k + 1, i - 1) = T(k + 1, i) * alpha(i - 1) + beta(i - 1);  
    end

    T(k + 1, 1) = T_left;  
end


% T(end, :)
%% Final temp plot
figure;
plot(x, T(end, :));

%% Temp evolution plot
[x, y] = meshgrid(x, t);
figure;
contourf(x, y, T, 20);



