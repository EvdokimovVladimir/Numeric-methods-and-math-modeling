function y = runge_kutta(f, x0, y0, x, n)
    h = (x - x0) / n;
    y = y0;

    for i = 0:(n - 1)
        k0 = f(x0 + i * h,         y);
        k1 = f(x0 + (i + 0.5) * h, y + h * k0 / 2);
        k2 = f(x0 + (i + 0.5) * h, y + h * k1 / 2);
        k3 = f(x0 + (i + 1) * h,   y + h * k2);

        y = y + h / 6 * (k0 + 2 * k1 + 2 * k2 + k3);
    end
end

