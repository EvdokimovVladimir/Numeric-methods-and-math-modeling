function [a, b, c, d] = cubic_spline(x, y, dd_left, dd_right)
    dd_left = 0;
    dd_right = 0;
    
    n = length(x);
    h = x - circshift(x, 1); % h(0) is mess, but it will be used)
    
    % create linear system for c
    Ac = zeros(n);
    Ac(1, 1) = 1;
    Ac(end, end) = 1;
    bc = zeros(n, 1);
    bc(1) = dd_left;
    bc(end) = dd_right;
    
    for i = 2:(n-1)
        Ac(i, i - 1) = h(i);
        Ac(i, i) = 2 * (h(i) + h(i + 1));
        Ac(i, i + 1) = h(i + 1);
    
        bc(i) = 3 * ((y(i + 1) - y(i)) / h(i + 1) - (y(i) - y(i - 1)) / h(i));
    end
    
    % solve linear system
    c = Ac \ bc;

    % calculate other coeffitients
    d = (c - circshift(c, 1)) ./ h / 3;
    b = (y - circshift(y, 1)) ./ h + c .* h - d .* h.^2;
    a = y;

    % exclude first value
    a = a(2:end);
    b = b(2:end);
    c = c(2:end);
    d = d(2:end);
end

