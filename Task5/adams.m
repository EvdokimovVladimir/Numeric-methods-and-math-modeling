function y = adams(f, x0, y0, x, n)
    arguments
        f function_handle
        x0 double
        y0 double
        x double {mustBeGreaterThan(x, x0)}
        n double {mustBeGreaterThan(n, 4), mustBeInteger}
    end

    h = (x - x0) / n;
    y = y0;
    f_n = [y0 0 0 0];

    % initial values by Runge-Kutta
    for i = 1:3
        k0 = f(x0,         y);
        k1 = f(x0 + h / 2, y + h * k0 / 2);
        k2 = f(x0 + h / 2, y + h * k1 / 2);
        k3 = f(x0 + h,     y + h * k2);
    
        y = y + h / 6 * (k0 + 2 * k1 + 2 * k2 + k3);
        x0 = x0 + h;
        f_n(i + 1) = f(x0 + (i - 1) * h, y);
    end
    
    for i = 4:n
        % predictor
        yy = y + h / 24 * (55 * f_n(4) - 59 * f_n(3) + ...
                          37 * f_n(2) - 9 * f_n(1));
        x0 = x0 + h;
        f_n = [f_n(2:4) f(x0, yy)];
        
        % corrector
        y = y + h / 24 * (9 * f_n(4) + 19 * f_n(3) - ...
                          5 * f_n(2) + f_n(1));
        f_n(4) = f(x0, y);
    end
end

