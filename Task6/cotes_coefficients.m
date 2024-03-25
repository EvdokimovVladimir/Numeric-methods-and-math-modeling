function coeffitients = cotes_coefficients(n)
    syms z;

    coeffitients = zeros(1, n + 1);
    for i = 0:floor(n / 2)
        numerator = 1;
        denominator = 1;

        for j = 0:n
            if i == j
                continue;
            end

            numerator = numerator * (z - j / n);
            denominator = denominator * (i / n - j / n);
        end
        numerator = int(numerator, 0, 1);
        coeffitients(i + 1) = numerator / denominator;
        coeffitients(n - i + 1) = coeffitients(i + 1);
    end
end

