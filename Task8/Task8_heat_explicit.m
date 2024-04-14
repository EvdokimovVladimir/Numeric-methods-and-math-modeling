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

magic_number = dt * lambda / (rho * capacitance * dL^2);

if magic_number > 1
    error("magic_number is too big!")
end

%% Calculation
T(1, :) = T0;

for i = 1:(length(t) - 1)
    T(i + 1, :) = T(i, :) + magic_number * ...
        (circshift(T(i, :), 1) - 2 * T(i, :) + circshift(T(i, :), -1));

    T(i + 1, 1) = T_left;
    T(i + 1, end) = T_right;
end

T(end, :)
%% Final temp plot
figure;
plot(x, T(end, :));

%% Temp evolution plot
[x, y] = meshgrid(x, t);
figure;
contourf(x, y, T, 20);

















