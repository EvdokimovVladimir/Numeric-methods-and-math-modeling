clear;
clc;
format compact;
format long;

%% Input parameters
f = @(x) exp(-x .^ 2) ./ (1 + cos(x));
x_min = 0;
x_max = 1;
int_builtin = integral(f, x_min, x_max, "AbsTol", eps)

%% Cotes formula
n = 9;
coefficients = cotes_coefficients(n);
x_cotes = linspace(x_min, x_max, n + 1);
f_cotes = f(x_cotes);
int_cotes = f_cotes * coefficients'
delta_int_cotes = abs(int_cotes - int_builtin)

%% Chebyshev formula
n = 9;
x_chebyshev = chebyshev_coefficients(n);
x_chebyshev = x_min + (x_max - x_min) * (x_chebyshev + 1) / 2;
f_chebyshev = f(x_chebyshev);
int_chebyshev = (x_max - x_min) / n * sum(f_chebyshev)
delta_int_chebyshev = abs(int_chebyshev - int_builtin)

%% Gauss formula
n = 9;
[weights, nodes] = gauss_coefficients(n);
x_gauss = x_min + (x_max - x_min) * (nodes + 1) / 2;
f_gauss = f(x_gauss);
int_gauss = (x_max - x_min) * f_gauss' * weights
delta_int_gauss = abs(int_gauss - int_builtin)

