clear;
clc;
format compact;
format long;

%% Input parameters
f = @(x) (x(1) + 2 * x(2) - 3) ./ sqrt(x(1).^2 + x(2).^2 + 1);

X0 = [-0.5 -0.5];

step = ones(size(X0)) * 1e-3;
epsilon = ones(size(X0)) * eps;
max_iter = 100000;

%% Parabola minimization
X(1, :) = X0;
condition = true;
i = 1;

while condition  
    X(i + 1, :) = parabola_min(f, X(i, :), step);

    condition = all(abs(X(i + 1, :) - X(i, :)) > epsilon);

    i = i + 1;
    if i == max_iter
        break;
    end
end

% minimum point
X_min = X(end, :)
% minimum value
f_min = f(X(end, :))

% theoretical value and absolute error
X_theory = [-1/3, -2/3];
abs(X_min - X_theory)
abs(f(X(end, :)) + sqrt(14))

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
z = zeros(size(x));

for i = 1:num_points
    for j = 1:num_points
        z(i, j) = f([x(i, j), y(i, j)]);
    end
end

figure;
hold on;
contourf(x, y, z, 20);
plot(X(:, 1), X(:, 2), ...
    "Color", "r", "MarkerSize", 5, "Marker", "*", "LineWidth", 1);


