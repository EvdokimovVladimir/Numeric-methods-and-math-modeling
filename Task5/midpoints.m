function y = midpoints(f, x0, y0, x, n)
    h = (x - x0) / n;
    y = y0;

    for i = 0:(n - 1)
        yy = y + h / 2 * f(x0 + i * h, y);
        y = y + h * f(x0 + (i + 0.5) * h, yy);
    end
end

