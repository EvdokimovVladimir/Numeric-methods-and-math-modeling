function y = euler_cauchy(f, x0, y0, x, n)
    h = (x - x0) / n;
    y = y0;

    for i = 0:(n - 1)
        yy = y + h * f(x0 + i * h, y);
        y = y + h * (f(x0 + i * h, y) + f(x0 + (i + 1) * h, yy)) / 2;
    end
end

