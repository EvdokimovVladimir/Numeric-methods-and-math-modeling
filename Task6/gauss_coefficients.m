function [weights, nodes] = gauss_coefficients(n)
    syms x;
    % nodes = vpasolve(legendreP(n, x) == 0);
    nodes = roots(sym2poly(legendreP(n, x)));
    weights = (1 - nodes.^2) ./ ((n + 1) * legendreP(n + 1, nodes)).^2;
end

