function gradient = num_gradient(F, X, step)
    gradient = [F(X(1) + step, X(2)) - F(X(1) - step, X(2)), ...
        F(X(1), X(2) + step) - F(X(1), X(2) - step)] / (2 * step);
end
