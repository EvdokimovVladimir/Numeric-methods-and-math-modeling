clear;
clc;

%% Input parameters
syms x;
f(x) = x - tan(x) + 1/5;
x_min = 0.5;
x_max = 1;
x_lim = [x_min, x_max];
eps = 1e-10;

%% Graph plot (not required)
fplot(f, x_lim);
set(gcf().CurrentAxes, "XAxisLocation" ,"origin");

%% Preparing

% derivatives
Df(x) = diff(f);
DDf(x) = diff(Df);

Df_min = stupidMin(abs(Df), x_lim);

%% Bisection
a = x_min;
b = x_max;
c = (a + b) / 2;
n_bisection = 0;

while (b - a >= 2 * eps)
    if f(a) * f(c) > 0
        a = c;
    else
        b = c;
    end

    c = (a + b) / 2;
    n_bisection = n_bisection + 1;
end

x0_bisection = c;

%% Chord
x0 = x_min;
n_chord = 0;

if DDf(x_min) * f(x_min) < 0
    while abs(f(x0)) > eps * Df_min
        x0 = double(x0 - f(x0) / (f(x_max) - f(x0)) * (x_max - x0));
        n_chord = n_chord + 1;
    end
else
    while abs(f(x0)) > eps * Df_min
        x0 = double(x0 - f(x_min) / (f(x0) - f(x_min)) * (x0 - x_min));
        n_chord = n_chord + 1;
    end
end

x0_chord = x0;

%% Tangent (Newton)

if f(x_min) * DDf(x_min) > 0
    x0 = x_min;
else
    x0 = x_max;
end

n_tangent = 0;

while abs(f(x0)) > eps * Df_min
    x0 = double(x0 - f(x0) / Df(x0));
    n_tangent = n_tangent + 1;
end

x0_tangent = x0;

%% Iteration

% magic number, should be Dphi_max < 1 (perfably < 0.5)
% use plot for help
k = 1.4;
phi(x) = x + f(x) / k;
Dphi(x) = diff(phi);
Dphi_max = -stupidMin(-abs(Dphi), x_lim);
% fplot(abs(Dphi(x)), x_lim);

p = Dphi_max / (1 - Dphi_max);
x0 = inf;
x1 = (x_min + x_max) / 2;
n_iteration = 0;

while p * abs(x0 - x1) > eps
    x0 = x1;
    x1 = double(phi(x0));
    n_iteration = n_iteration + 1;
end

x0_iteration = x1;

%% Summary

additionalWidth = 0.1;

x0_min = min([x0_bisection, x0_chord, x0_tangent, x0_iteration]);
x0_max = max([x0_bisection, x0_chord, x0_tangent, x0_iteration]);
dx0 = x0_max - x0_min;

x0_min = x0_min - additionalWidth * dx0;
x0_max = x0_max + additionalWidth * dx0;

x0_lim = [x0_min, x0_max];


MarkerSize = 16;
LineWidth = 2;

figure;
hold on;
fplot(f, x0_lim, "DisplayName", "Function", ...
    "Color", "blue", "LineWidth", 1);
plot(x0_bisection, f(x0_bisection), ...
    "DisplayName", "Bisection (" + string(n_bisection) + " iter) (x, y) = (" + ...
    string(x0_bisection) + ", " + string(double(f(x0_bisection))) + ")", ...
    "LineStyle", "none", "Marker", "x", "Color", "red", ...
    "MarkerSize", MarkerSize, "LineWidth", LineWidth);
plot(x0_chord, f(x0_chord), ...
    "DisplayName", "Chord (" + string(n_chord) + " iter)  (x, y) = (" + ...
    string(x0_chord) + ", " + string(double(f(x0_chord))) + ")", ...
    "LineStyle", "none", "Marker", "o", "Color", "green", ...
    "MarkerSize", MarkerSize, "LineWidth", LineWidth);
plot(x0_tangent, f(x0_tangent), ...
    "DisplayName", "Newton (" + string(n_tangent) + " iter)  (x, y) = (" + ...
    string(x0_tangent) + ", " + string(double(f(x0_tangent))) + ")", ...
    "LineStyle", "none", "Marker", "*", "Color", "magenta", ...
    "MarkerSize", MarkerSize, "LineWidth", LineWidth);
plot(x0_iteration, f(x0_iteration), ...
    "DisplayName", "Iteration (" + string(n_iteration) + " iter)  (x, y) = (" + ...
    string(x0_iteration) + ", " + string(double(f(x0_iteration))) + ")", ...
    "LineStyle", "none", "Marker", "+", "Color", "cyan", ...
    "MarkerSize", MarkerSize, "LineWidth", LineWidth);
legend;
set(gcf().CurrentAxes, "XAxisLocation" ,"origin");


%% MATLAB solver
ff = @(x) double(f(x));

options = optimset( ...
    "PlotFcns", {@optimplotx,@optimplotfval}, ...
    "Display", "iter", ...
    "TolX", 1e-300);

[x0, y0, exitflag, output] = fzero(ff, x_lim, options)


