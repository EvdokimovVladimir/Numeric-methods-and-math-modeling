clear;
clc;
format compact;

%% Input parameters

f = @(x) 1 ./ (1 + x.^2);
x_min = 0;
x_max = 1;
n = 1000;

%% First solve
h = (x_max - x_min) / n;

int_left = 0;
int_right = 0;
int_center = 0;

for i = 1:n
    int_left = int_left + f(x_min + (i - 1) * h);
    int_right = int_right + f(x_min + i * h);
    int_center = int_center + f(x_min + (i - 0.5) * h);
end

% results
int_left = int_left * h
int_right = int_right * h
int_center = int_center * h
int_trapezoid = (int_left + int_right) / 2

%% Second solve

n = 2 * n;
int_left2 = 0;
int_right2 = 0;
int_center2 = 0;
h = (x_max - x_min) / n;

for i = 1:n
    int_left2 = int_left2 + f(x_min + (i - 1) * h);
    int_right2 = int_right2 + f(x_min + i * h);
    int_center2 = int_center2 + f(x_min + (i - 0.5) * h);
end

% results
int_left2 = int_left2 * h
int_right2 = int_right2 * h
int_center2 = int_center2 * h
int_trapezoid2 = (int_left2 + int_right2) / 2

% absolute error estimation
Dint_left2 = abs(int_left2 - int_left)
Dint_right2 = abs(int_right2 - int_right)
Dint_center2 = abs(int_center2 - int_center) / 3
Dint_trapezoid2 = abs(int_trapezoid2 - int_trapezoid) / 3

% absolute error
Dint_left2 = abs(int_left2 - pi / 4)
Dint_right2 = abs(int_right2 - pi / 4)
Dint_center2 = abs(int_center2 - pi / 4)
Dint_trapezoid2 = abs(int_trapezoid2 - pi / 4)


%% left rectangles
eps = 1e-5;

I1 = 0;
I2 = Inf;

while abs(I2 - I1) > eps
    I1 = I2;
    I2 = 0;

    n = 2 * n;
    h = (x_max - x_min) / n;

    for i = 1:n
        I2 = I2 + f(x_min + (i - 1) * h);
    end
    I2 = I2 * h;
end

int_left2 = I2


%% right rectangles
eps = 1e-5;

I1 = 0;
I2 = Inf;

while abs(I2 - I1) > eps
    I1 = I2;
    I2 = 0;

    n = 2 * n;
    h = (x_max - x_min) / n;

    for i = 1:n
        I2 = I2 + f(x_min + i * h);
    end
    I2 = I2 * h;
end

int_right2 = I2

%% center rectangles
eps = 1e-5;

I1 = 0;
I2 = Inf;

while abs(I2 - I1) > 3 * eps
    I1 = I2;
    I2 = 0;

    n = 2 * n;
    h = (x_max - x_min) / n;

    for i = 1:n
        I2 = I2 + f(x_min + (i - 0.5) * h);
    end
    I2 = I2 * h;
end

int_center2 = I2

%% built-in function and analytical value
int_builtin = integral(f, x_min, x_max)
int_analytical = pi / 4

%%
format default;

