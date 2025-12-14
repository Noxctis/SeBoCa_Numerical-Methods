function [solution, success] = GaussianSolver(A, b)
% GaussianSolver - Solves a system of linear equations using Gaussian Elimination
%
% USAGE:
%   [solution, success] = GaussianSolver(A, b)
%
% INPUT:
%   A - Coefficient matrix (3x3, 4x4, or 5x5)
%   b - Right-hand side vector (column vector)
%
% OUTPUT:
%   solution - Solution vector
%   success - Boolean indicating if solution was successful
%
% MEDICAL CONTEXT:
%   This solver is designed for medical dosage calculations including:
%   - 3x3: Drug/Saline/Buffer mixture calculations
%   - 4x4: Addition of Sodium to the mixture
%   - 5x5: Addition of Potassium to the mixture
%
% EXAMPLES:
%   For Oncology drug mixture (3x3):
%   A = [2 1 1; 1 3 2; 1 1 2];
%   b = [100; 150; 80];
%   [solution, success] = GaussianSolver(A, b);
%
%   For TPN (Total Parenteral Nutrition) with Sodium (4x4):
%   A = [2 1 1 0.5; 1 3 2 1; 1 1 2 0.5; 0.5 1 0.5 2];
%   b = [100; 150; 80; 60];
%   [solution, success] = GaussianSolver(A, b);

    % Initialize output
    success = false;
    solution = [];
    
    % Input validation
    [rows, cols] = size(A);
    
    % Check if matrix is square
    if rows ~= cols
        error('GaussianSolver:InvalidMatrix', 'Coefficient matrix must be square.');
    end
    
    % Check if matrix size is supported (3x3, 4x4, or 5x5)
    if rows < 3 || rows > 5
        error('GaussianSolver:UnsupportedSize', ...
              'Matrix must be 3x3, 4x4, or 5x5 for medical dosage calculations.');
    end
    
    % Check if b is a column vector of correct size
    if ~isvector(b) || length(b) ~= rows
        error('GaussianSolver:InvalidVector', ...
              'Right-hand side must be a vector of length %d.', rows);
    end
    
    % Ensure b is a column vector
    if size(b, 2) > 1
        b = b';
    end
    
    % Create augmented matrix [A|b]
    augmentedMatrix = [A, b];
    n = rows;
    
    % Forward Elimination
    for k = 1:n-1
        % Partial pivoting: find the row with maximum element in column k
        [maxVal, maxRow] = max(abs(augmentedMatrix(k:n, k)));
        maxRow = maxRow + k - 1;
        
        % Check for singular matrix
        if abs(maxVal) < eps
            warning('GaussianSolver:SingularMatrix', ...
                    'Matrix is singular or nearly singular. Solution may not exist.');
            return;
        end
        
        % Swap rows if necessary
        if maxRow ~= k
            augmentedMatrix([k, maxRow], :) = augmentedMatrix([maxRow, k], :);
        end
        
        % Eliminate entries below pivot
        for i = k+1:n
            factor = augmentedMatrix(i, k) / augmentedMatrix(k, k);
            augmentedMatrix(i, k:n+1) = augmentedMatrix(i, k:n+1) - ...
                                         factor * augmentedMatrix(k, k:n+1);
        end
    end
    
    % Check if last diagonal element is zero
    if abs(augmentedMatrix(n, n)) < eps
        warning('GaussianSolver:SingularMatrix', ...
                'Matrix is singular. Solution does not exist or is not unique.');
        return;
    end
    
    % Back Substitution
    solution = zeros(n, 1);
    solution(n) = augmentedMatrix(n, n+1) / augmentedMatrix(n, n);
    
    for i = n-1:-1:1
        sum = augmentedMatrix(i, n+1);
        for j = i+1:n
            sum = sum - augmentedMatrix(i, j) * solution(j);
        end
        solution(i) = sum / augmentedMatrix(i, i);
    end
    
    % Check for negative solutions (invalid for dosage calculations)
    if any(solution < 0)
        warning('GaussianSolver:NegativeSolution', ...
                'Warning: Some dosage values are negative. Check your input constraints.');
    end
    
    success = true;
end
