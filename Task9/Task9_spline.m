clear;
clc;

%%
f = @(x) 2.^x;

x_i = [-1, 0, 1, 2]';
y_i = f(x_i);

x = 0.3;

%% calculate coeffitients
[a, b, c, d] = cubic_spline(x_i, y_i, 0, 0);

%% calculate spline value at x
y = calc_cubic_spline(a, b, c, d, x_i, x)
dy = abs(y - f(x))

%% data for plotting
x = min(x_i):0.01:max(x_i);
y = calc_cubic_spline(a, b, c, d, x_i, x);
t = f(x)';

%% plot knots, spline and interpolated function
figure;
hold on;
plot(x_i, y_i, "ok", "DisplayName", "Узлы")
plot(x, y, "-r", "LineWidth", 1, "DisplayName", "Кубический сплайн");
plot(x, t, "-k", "LineWidth", 1, "DisplayName", "Интерполируемая функция");
legend("Location", "northwest");

%% plot absolute error
figure;
hold on;
plot(x, t - y);
title("Абсолютная погрешность")














