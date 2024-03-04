function I = sympson(f, x_min, x_max, n)
    if mod(n, 2) == 1
        n = n + 1;
    end

    h = (x_max - x_min) / n;

    I = f(x_min) + f(x_max);
    
    for i = 1:2:(n - 1)
        I = I + 4 * f(x_min + i * h);
    end

    for i = 2:2:(n - 1)
        I = I + 2 * f(x_min + i * h);
    end
    
    I = I * h / 3;
end

