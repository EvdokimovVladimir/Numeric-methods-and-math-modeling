function f_min = stupidMin(f, x_lim, n)
    arguments 
        f;
        x_lim;
        n = 1000; 
    end


    dx = (x_lim(2) - x_lim(1)) / n;
    x = x_lim(1):dx:x_lim(2);
    
    f_min = min(double(f(x)));
end

