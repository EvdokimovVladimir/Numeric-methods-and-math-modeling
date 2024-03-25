clear;
clc;

%% Input parameters
x = [0.05 0.1 0.17 0.25 0.3 0.36];
y = [0.050042 0.100335 0.171657 0.255342 0.309336 0.376403];
x0 = 0.263;

%% Lagrange interpolation
f = 0;
for i = 1:length(y)
    numerator = 1;
    denominator = 1;

    for j = 1:length(y)
        if i == j
            continue;
        end

        numerator = numerator * (x0 - x(j));
        denominator = denominator * (x(i) - x(j));
    end
    f = f + y(i) * numerator / denominator;
end

f