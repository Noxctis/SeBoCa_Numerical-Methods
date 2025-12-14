% main.m - Medical Dosage Calculator
% Main console menu for selecting numerical methods tools
%
% This program provides tools for calculating optimal drug mixtures
% in medical contexts such as Oncology and TPN (Total Parenteral Nutrition)

function main()
    clc;
    
    while true
        % Display main menu
        fprintf('\n========================================\n');
        fprintf('  MEDICAL DOSAGE CALCULATOR\n');
        fprintf('  Numerical Methods for Biomedical Applications\n');
        fprintf('========================================\n\n');
        fprintf('Select a tool:\n');
        fprintf('  1. Gaussian Elimination Solver (3x3 - Drug/Saline/Buffer)\n');
        fprintf('  2. Gaussian Elimination Solver (4x4 - Plus Sodium)\n');
        fprintf('  3. Gaussian Elimination Solver (5x5 - Plus Potassium)\n');
        fprintf('  4. Custom Matrix Solver\n');
        fprintf('  5. Help/Documentation\n');
        fprintf('  0. Exit\n\n');
        
        choice = input('Enter your choice: ');
        
        switch choice
            case 1
                solve3x3System();
            case 2
                solve4x4System();
            case 3
                solve5x5System();
            case 4
                solveCustomSystem();
            case 5
                displayHelp();
            case 0
                fprintf('\nThank you for using Medical Dosage Calculator.\n');
                fprintf('Stay safe and accurate with your calculations!\n\n');
                break;
            otherwise
                fprintf('\nInvalid choice. Please try again.\n');
        end
        
        if choice >= 1 && choice <= 4
            input('\nPress Enter to continue...');
        end
    end
end

function solve3x3System()
    % Solve 3x3 system for Drug/Saline/Buffer mixture
    fprintf('\n--- 3x3 System: Drug/Saline/Buffer Mixture ---\n');
    fprintf('Variables: Drug (x1), Saline (x2), Buffer (x3)\n\n');
    
    fprintf('Example scenario: Oncology chemotherapy preparation\n');
    fprintf('Enter coefficient matrix A (3x3):\n');
    
    A = zeros(3, 3);
    for i = 1:3
        for j = 1:3
            prompt = sprintf('  A(%d,%d) = ', i, j);
            A(i, j) = input(prompt);
        end
    end
    
    fprintf('\nEnter right-hand side vector b (target concentrations/volumes):\n');
    b = zeros(3, 1);
    for i = 1:3
        prompt = sprintf('  b(%d) = ', i);
        b(i) = input(prompt);
    end
    
    % Solve using Gaussian Elimination
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- Solution ---\n');
        fprintf('Drug amount:   %.4f units\n', solution(1));
        fprintf('Saline amount: %.4f units\n', solution(2));
        fprintf('Buffer amount: %.4f units\n', solution(3));
        
        % Verification
        fprintf('\n--- Verification (A*x = b) ---\n');
        result = A * solution;
        for i = 1:3
            fprintf('Equation %d: %.4f (expected: %.4f)\n', i, result(i), b(i));
        end
    else
        fprintf('\nFailed to solve the system. Please check your inputs.\n');
    end
end

function solve4x4System()
    % Solve 4x4 system for Drug/Saline/Buffer/Sodium mixture
    fprintf('\n--- 4x4 System: Drug/Saline/Buffer/Sodium Mixture ---\n');
    fprintf('Variables: Drug (x1), Saline (x2), Buffer (x3), Sodium (x4)\n\n');
    
    fprintf('Example scenario: TPN (Total Parenteral Nutrition) formulation\n');
    fprintf('Enter coefficient matrix A (4x4):\n');
    
    A = zeros(4, 4);
    for i = 1:4
        for j = 1:4
            prompt = sprintf('  A(%d,%d) = ', i, j);
            A(i, j) = input(prompt);
        end
    end
    
    fprintf('\nEnter right-hand side vector b (target concentrations/volumes):\n');
    b = zeros(4, 1);
    for i = 1:4
        prompt = sprintf('  b(%d) = ', i);
        b(i) = input(prompt);
    end
    
    % Solve using Gaussian Elimination
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- Solution ---\n');
        fprintf('Drug amount:   %.4f units\n', solution(1));
        fprintf('Saline amount: %.4f units\n', solution(2));
        fprintf('Buffer amount: %.4f units\n', solution(3));
        fprintf('Sodium amount: %.4f units\n', solution(4));
        
        % Verification
        fprintf('\n--- Verification (A*x = b) ---\n');
        result = A * solution;
        for i = 1:4
            fprintf('Equation %d: %.4f (expected: %.4f)\n', i, result(i), b(i));
        end
    else
        fprintf('\nFailed to solve the system. Please check your inputs.\n');
    end
end

function solve5x5System()
    % Solve 5x5 system for Drug/Saline/Buffer/Sodium/Potassium mixture
    fprintf('\n--- 5x5 System: Drug/Saline/Buffer/Sodium/Potassium Mixture ---\n');
    fprintf('Variables: Drug (x1), Saline (x2), Buffer (x3), Sodium (x4), Potassium (x5)\n\n');
    
    fprintf('Example scenario: Complex TPN with electrolyte balance\n');
    fprintf('Enter coefficient matrix A (5x5):\n');
    
    A = zeros(5, 5);
    for i = 1:5
        for j = 1:5
            prompt = sprintf('  A(%d,%d) = ', i, j);
            A(i, j) = input(prompt);
        end
    end
    
    fprintf('\nEnter right-hand side vector b (target concentrations/volumes):\n');
    b = zeros(5, 1);
    for i = 1:5
        prompt = sprintf('  b(%d) = ', i);
        b(i) = input(prompt);
    end
    
    % Solve using Gaussian Elimination
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- Solution ---\n');
        fprintf('Drug amount:      %.4f units\n', solution(1));
        fprintf('Saline amount:    %.4f units\n', solution(2));
        fprintf('Buffer amount:    %.4f units\n', solution(3));
        fprintf('Sodium amount:    %.4f units\n', solution(4));
        fprintf('Potassium amount: %.4f units\n', solution(5));
        
        % Verification
        fprintf('\n--- Verification (A*x = b) ---\n');
        result = A * solution;
        for i = 1:5
            fprintf('Equation %d: %.4f (expected: %.4f)\n', i, result(i), b(i));
        end
    else
        fprintf('\nFailed to solve the system. Please check your inputs.\n');
    end
end

function solveCustomSystem()
    % Solve custom size system (3x3 to 5x5)
    fprintf('\n--- Custom Matrix Solver ---\n');
    
    n = input('Enter matrix size (3, 4, or 5): ');
    
    if n < 3 || n > 5 || floor(n) ~= n
        fprintf('Invalid size. Please enter 3, 4, or 5.\n');
        return;
    end
    
    fprintf('\nEnter coefficient matrix A (%dx%d):\n', n, n);
    
    A = zeros(n, n);
    for i = 1:n
        for j = 1:n
            prompt = sprintf('  A(%d,%d) = ', i, j);
            A(i, j) = input(prompt);
        end
    end
    
    fprintf('\nEnter right-hand side vector b:\n');
    b = zeros(n, 1);
    for i = 1:n
        prompt = sprintf('  b(%d) = ', i);
        b(i) = input(prompt);
    end
    
    % Solve using Gaussian Elimination
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- Solution ---\n');
        for i = 1:n
            fprintf('x(%d) = %.4f\n', i, solution(i));
        end
        
        % Verification
        fprintf('\n--- Verification (A*x = b) ---\n');
        result = A * solution;
        for i = 1:n
            fprintf('Equation %d: %.4f (expected: %.4f)\n', i, result(i), b(i));
        end
    else
        fprintf('\nFailed to solve the system. Please check your inputs.\n');
    end
end

function displayHelp()
    % Display help and documentation
    fprintf('\n========================================\n');
    fprintf('  HELP & DOCUMENTATION\n');
    fprintf('========================================\n\n');
    
    fprintf('OVERVIEW:\n');
    fprintf('This Medical Dosage Calculator uses Gaussian Elimination to solve\n');
    fprintf('systems of linear equations for optimal drug mixture calculations.\n\n');
    
    fprintf('MEDICAL CONTEXTS:\n');
    fprintf('1. ONCOLOGY (3x3 System):\n');
    fprintf('   - Chemotherapy drug preparation\n');
    fprintf('   - Balancing drug concentration, saline, and buffer solution\n');
    fprintf('   - Ensures proper pH and osmolarity for patient safety\n\n');
    
    fprintf('2. TPN - Total Parenteral Nutrition (4x4 System):\n');
    fprintf('   - IV nutrition for patients who cannot eat normally\n');
    fprintf('   - Includes base nutrients plus sodium for electrolyte balance\n');
    fprintf('   - Critical for maintaining proper body chemistry\n\n');
    
    fprintf('3. COMPLEX TPN (5x5 System):\n');
    fprintf('   - Advanced nutritional support with complete electrolyte management\n');
    fprintf('   - Includes potassium in addition to other components\n');
    fprintf('   - Used for patients with specific metabolic requirements\n\n');
    
    fprintf('HOW TO USE:\n');
    fprintf('1. Select the appropriate system size from the main menu\n');
    fprintf('2. Enter the coefficient matrix A representing the relationships\n');
    fprintf('   between components (how each component contributes to targets)\n');
    fprintf('3. Enter the target vector b (desired concentrations or volumes)\n');
    fprintf('4. The solver will calculate optimal amounts for each component\n\n');
    
    fprintf('EXAMPLE (3x3 Oncology):\n');
    fprintf('If you need:\n');
    fprintf('  - 100 mg total active ingredient from drug and buffer\n');
    fprintf('  - 150 mL total volume from all components\n');
    fprintf('  - 80 mEq total osmolarity contribution\n');
    fprintf('The solver determines exact amounts of drug, saline, and buffer needed.\n\n');
    
    fprintf('IMPORTANT NOTES:\n');
    fprintf('- Always verify calculated dosages with medical protocols\n');
    fprintf('- Negative solutions indicate infeasible constraints\n');
    fprintf('- This tool is for educational and planning purposes\n');
    fprintf('- Consult with qualified medical professionals before administration\n\n');
    
    fprintf('GAUSSIAN ELIMINATION METHOD:\n');
    fprintf('- Uses partial pivoting for numerical stability\n');
    fprintf('- Handles 3x3, 4x4, and 5x5 systems efficiently\n');
    fprintf('- Provides verification of results\n\n');
end
