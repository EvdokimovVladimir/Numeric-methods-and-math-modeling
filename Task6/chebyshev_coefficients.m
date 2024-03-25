function coeffitients = chebyshev_coefficients(n)
    if n == 8 || n > 10
        error("n must less then 10 and not 8");
    end

    x = optimvar("x", n);
    prob = eqnproblem;
    
    for i = 1:n
        eq = 0;
        for j = 1:n
            eq = eq + x(j)^i;
        end
    
        if mod(i, 2) == 0
            eq = eq == n / (i + 1);
        else
            eq = eq == 0;
        end
        prob.Equations.("eq" + i) = eq;
    end
    
    
    x0.x = linspace(-1, 1, n);
    options = optimoptions("fsolve", "Display", "none");
    coeffitients = solve(prob, x0, "Options", options);
    coeffitients = coeffitients.x';
end

