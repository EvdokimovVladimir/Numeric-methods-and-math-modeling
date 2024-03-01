clear;
clc;

%% Input parameters

A = [1 2 -5 3;
     1 3 2 0;
     -5 1 9 -4;
     -1 3 8 0];
b = [1 -2 0 4].';
eps = 1e-100;

dA = det(A);

if abs(dA) < 1e-10
    error("Det(A) is close to zero! \nIt should be non zero: det(A) = " + string(det(A)));
elseif abs(dA) < 1e-5
    warning("It should be non zero: det(A) = " + string(det(A)));
end
disp("It should be non zero: det(A) = " + string(det(A)));

%% Gauss method
Ab = cat(2, A, b);

% % forward course 
% for i = 1:size(A, 1)
%     for j = (i + 1):size(A, 1)
%         if Ab(i, i) == 0
%             error("Zero division!")
%         end
%         Ab(j, :) = Ab(j, :) - Ab(j, i) / Ab(i, i) * Ab(i, :);
%     end
% end
% 
% % reverse course
% for i = size(A, 1):-1:1
%     for j = (i - 1):-1:1
%         if Ab(i, i) == 0
%             error("Zero division!")
%         end
%         Ab(j, :) = Ab(j, :) - Ab(j, i) / Ab(i, i) * Ab(i, :);
%     end
% end

% forward and reverse
for i = 1:size(A, 1)
    for j = 1:size(A, 1)
        if i == j 
            continue; 
        end
        if Ab(i, i) == 0
            error("Zero division!")
        end
        Ab(j, :) = Ab(j, :) - Ab(j, i) / Ab(i, i) * Ab(i, :);
    end
end

%% Solution

x = Ab(:, end) ./ diag(Ab)
A \ b



