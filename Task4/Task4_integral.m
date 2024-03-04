clear;
clc;
format compact;
format long;

%% Input parameters
f = @(x) exp(-x .^ 2) ./ (1 + cos(x));
x_min = 0;
x_max = 1;
N = 100;
eps = 1e-5;

%% First solve
int_left = left_rectangles(f, x_min, x_max, N)
int_right = right_rectangles(f, x_min, x_max, N)
int_center = center_rectangles(f, x_min, x_max, N)
int_trapezoid = (int_left + int_right) / 2
int_sympson = sympson(f, x_min, x_max, N)

%% Second solve
int_left2 = left_rectangles(f, x_min, x_max, 2 * N)
int_right2 = right_rectangles(f, x_min, x_max, 2 * N)
int_center2 = center_rectangles(f, x_min, x_max, 2 * N)
int_trapezoid2 = (int_left2 + int_right2) / 2
int_sympson2 = sympson(f, x_min, x_max, 2 * N)

% absolute error estimation
Dint_left = abs(int_left2 - int_left)
Dint_right = abs(int_right2 - int_right)
Dint_center = abs(int_center2 - int_center) / 3
Dint_trapezoid = abs(int_trapezoid2 - int_trapezoid) / 3
Dint_sympson = abs(int_sympson2 - int_sympson) / 3

%% left rectangles
n = N;

I1 = 0;
I2 = Inf;

while abs(I2 - I1) > eps
    I1 = I2;
    n = 2 * n;
    I2 = left_rectangles(f, x_min, x_max, n);
end

int_left_eps = I2


%% right rectangles
n = N;

I1 = 0;
I2 = Inf;

while abs(I2 - I1) > eps
    I1 = I2;
    n = 2 * n;
    I2 = right_rectangles(f, x_min, x_max, n);
end

int_right_eps = I2

%% center rectangles
n = N;

I1 = 0;
I2 = Inf;

while abs(I2 - I1) > 3 * eps
    I1 = I2;
    n = 2 * n;
    I2 = center_rectangles(f, x_min, x_max, n);
end

int_center_eps = I2

%% Sympson formula
n = N;

I1 = 0;
I2 = Inf;

if mod(n, 2) == 1
    n = n + 1;
end

while abs(I2 - I1) > 15 * eps
    I1 = I2;
    n = 2 * n;
    I2 = sympson(f, x_min, x_max, n);
end

int_sympson_eps = I2

%% built-in function and analytical value
int_builtin = integral(f, x_min, x_max)

%%
format default;

