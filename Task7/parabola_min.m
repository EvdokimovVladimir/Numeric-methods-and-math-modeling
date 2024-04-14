function x_min = parabola_min(f, x, step)
    x_min = zeros(size(x));

    for i = 1:length(x)
        Xl = x;
        Xl(i) = Xl(i) - step(i);

        Xr = x;
        Xr(i) = Xr(i) + step(i);
    
        Yc = f(x);
        Yl = f(Xl);
        Yr = f(Xr);

        x_min(i) = (Yl * (Xr(i) + x(i)) - 2 * Yc * (Xr(i) + Xl(i)) + Yr * (x(i) + Xl(i))) / ...
        (2 * (Yl - 2 * Yc + Yr));
    end
end

