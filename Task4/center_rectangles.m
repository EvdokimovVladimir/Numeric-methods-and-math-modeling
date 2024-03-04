function I = center_rectangles(f, x_min, x_max, n)
    h = (x_max - x_min) / n;
    
    I = 0;
    
    for i = 1:n
        I = I + f(x_min + (i - 0.5) * h);
    end

    I = I * h;
end

