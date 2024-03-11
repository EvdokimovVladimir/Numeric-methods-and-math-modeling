clear;
clc;
format compact;
format long;

%% Input parameters
f = @(x, y) exp(-(y.^2 + 1)) + 2 * x;
x0 = 0;
y0 = 0.3;
x = 0.5;
n1 = 2;
n2 = 100;

%% Calculate values
y_euler = euler(f, x0, y0, x, n1)
y_euler_cauchy = euler_cauchy(f, x0, y0, x, n1)
y_midpoints = midpoints(f, x0, y0, x, n1)
y_runge_kutta = runge_kutta(f, x0, y0, x, n2)
y_adams = adams(f, x0, y0, x, n2)

%% Errors
y_euler2 = euler(f, x0, y0, x, n1 / 2);
y_euler_cauchy2 = euler_cauchy(f, x0, y0, x, n1 / 2);
y_midpoints2 = midpoints(f, x0, y0, x, n1 / 2);
y_runge_kutta2 = runge_kutta(f, x0, y0, x, n2 / 2);
y_adams2 = adams(f, x0, y0, x, n2 / 2);

dy_euler = abs(y_euler2 - y_euler)
dy_euler_cauchy = abs(y_euler_cauchy2 - y_euler_cauchy) / 3
dy_midpoints = abs(y_midpoints2 - y_midpoints) / 3
dy_runge_kutta = abs(y_runge_kutta2 - y_runge_kutta) / 15
dy_adams = abs(y_adams2 - y_adams) / 15

%% Calculate values with ode functions
% settings = odeset("OutputFcn", @odeplot);
settings = odeset("OutputFcn", []);

% figure;
[t_23, y_23] = ode23(f, [x0 x], y0, settings);
y_ode23 = y_23(end)

% figure;
[t_45, y_45] = ode45(f, [x0 x], y0, settings);
y_ode45 = y_45(end)

% figure;
[t_78, y_78] = ode78(f, [x0 x], y0, settings);
y_ode78 = y_78(end)

% figure;
[t_89, y_89] = ode89(f, [x0 x], y0, settings);
y_ode89 = y_89(end)

% figure;
[t_113, y_113] = ode113(f, [x0 x], y0, settings);
y_ode113 = y_113(end)

%%
% figure;
% hold on;
% plot(t_23, y_23, "DisplayName", "ode23", "LineStyle", "none", "Color", "r", "Marker", "+");
% plot(t_45, y_45, "DisplayName", "ode45", "LineStyle", "none", "Color", "g", "Marker", "o");
% plot(t_78, y_78, "DisplayName", "ode78", "LineStyle", "none", "Color", "b", "Marker", "*");
% plot(t_89, y_89, "DisplayName", "ode89", "LineStyle", "none", "Color", "c", "Marker", ".");
% plot(t_113, y_113, "DisplayName", "ode113", "LineStyle", "none", "Color", "m", "Marker", "x");
% 





