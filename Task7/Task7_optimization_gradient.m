clear;
clc;
format compact;
format long;

%% Input parameters
f = @(x, y) (x + 2 * y - 3) ./ sqrt(x.^2 + y.^2 + 1);

X0 = [0 0];

grad_step = 1e-8;
epsilon = eps;
max_iter = 100000;

grad0 = num_gradient(f, X0, grad_step);
grad0 = sqrt(grad0(1)^2 + grad0(2)^2);

step = 1e-2;
grad_factor = 10;
step_decrement = 2;

%% Gradient descent 
X(1, :) = X0;
metric = Inf;
i = 1;
step_multiplicator = 1;

while metric > epsilon
    gradient = num_gradient(f, X(i, :), grad_step);
    gradient_abs = sqrt(gradient(1)^2 + gradient(2)^2);
    current_step = step * gradient * step_multiplicator;
    X(i + 1, :) = X(i, :) - current_step;

    step_length = sqrt(current_step(1)^2 + current_step(2)^2);
    function_step = abs(f(X(i, 1), X(i, 2)) - f(X(i + 1, 1), X(i + 1, 2)));

    metric = gradient_abs;

    i = i + 1;

    if grad0 / gradient_abs > grad_factor
        step_multiplicator = step_decrement * step_multiplicator;
        grad0 = gradient_abs;
    end

    if i == max_iter
        break;
    end
end

% minimum point
X_min = X(end, :)
% minimum value
f_min = f(X(end, 1), X(end, 2))
% metric value on minimum
metric

% theoretical value and absolute error
X_theory = [-1/3 -2/3];
abs(X_min - X_theory)
abs(f(X(end, 1), X(end, 2)) + sqrt(14))

%% Plot of the trajectory
additional_width = 0.1;
num_points = 1000;

Xmin = min(X);
Xmax = max(X);
dX = Xmax - Xmin;
Xmin = Xmin - dX * additional_width;
Xmax = Xmax + dX * additional_width;

x = linspace(Xmin(1), Xmax(1), num_points);
y = linspace(Xmin(2), Xmax(2), num_points);

[x, y] = meshgrid(x,y);
figure;
hold on;
contourf(x, y, f(x, y), 20);
plot(X(:, 1), X(:, 2), ...
    "Color", "r", "MarkerSize", 5, "Marker", "*", "LineWidth", 1);


