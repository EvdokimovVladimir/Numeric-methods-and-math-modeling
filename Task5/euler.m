function y = euler(f, x0, y0, x, n)
    h = (x - x0) / n;
    y = y0;

    for i = 0:(n - 1)
        y = y + h * f(x0 + i * h, y);
    end
end

