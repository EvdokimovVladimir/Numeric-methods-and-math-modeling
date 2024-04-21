function y = calc_cubic_spline(a, b, c, d, x_i, x)
    if any(x > max(x_i)) || any(x < min(x_i))
        error("x is outside the interval");
    end

    y = zeros(length(x), 1);

    for i = 1:length(x)
        j = 1;
        while x(i) > x_i(j)
            j = j + 1;
        end

        if j > 1
            j = j - 1;
        end
        
        y(i) = a(j) + b(j) * (x(i) - x_i(j + 1)) + ...
            c(j) * (x(i) - x_i(j + 1)).^2 + d(j) * (x(i) - x_i(j + 1)).^3;
    end
end

