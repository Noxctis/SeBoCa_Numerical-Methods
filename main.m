% main.m - Medical Dosage Calculator
% Main console menu for selecting numerical methods tools
%
% This program provides tools for calculating optimal drug mixtures
% in medical contexts such as Oncology and TPN (Total Parenteral Nutrition)

function main()
    clc;
    while true
        % Display main menu
        fprintf('\n======================================================\n');
        fprintf('  MEDICAL DOSAGE CALCULATOR (GAUSSIAN ELIMINATION)\n');
        fprintf('======================================================\n');
        fprintf('  1. 3x3 ONCOLOGY MIX (Drug, Saline, Buffer)\n');
        fprintf('  2. 4x4 TPN NUTRITION (Dextrose, Amino, Lipids, Na)\n');
        fprintf('  3. 5x5 COMPLEX TPN (Dex, Amino, Lipids, Na, K)\n');
        fprintf('  4. Custom Matrix Solver\n');
        fprintf('  5. Help/Documentation\n');
        fprintf('  0. Exit\n');
        fprintf('======================================================\n');
        
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
                break;
            otherwise
                fprintf('\nInvalid choice. Please try again.\n');
        end
        
        if choice >= 1 && choice <= 5
            input('\nPress Enter to continue...');
            clc;
        end
    end
end

function solve3x3System()
    % Solve 3x3 system for Drug/Saline/Buffer mixture
    fprintf('\n--- SCENARIO 1: ONCOLOGY CHEMOTHERAPY (3 Variables) ---\n');
    fprintf('You are mixing a Toxic Drug, Saline, and a pH Buffer.\n');
    fprintf('You must solve for the exact Volume (mL) of each.\n\n');
    
    fprintf('--- EXPLANATION OF THE MATH (THE MATRIX) ---\n');
    fprintf('Row 1 (Volume): [1 1 1]   -> 1mL of Drug + 1mL of Saline + 1mL of Buffer sums to Total Volume.\n');
    fprintf('Row 2 (Dosage): [50 0 0]  -> Only the Drug Vial contains medicine (50mg/mL).\n');
    fprintf('Row 3 (Stabil): [0.1 0.2 2] -> All three vials contribute different chemicals to pH stability.\n');

    fprintf('\n[DEMO CHEAT SHEET - TYPE THESE EXACT NUMBERS]\n');
    fprintf('Matrix A Row 1:  [1 1 1]\n');
    fprintf('Matrix A Row 2:  [50 0 0]\n');
    fprintf('Matrix A Row 3:  [0.1 0.2 2.0]\n');
    fprintf('Target Vector b: [100; 1000; 36]\n');
    fprintf('-----------------------------------------------------\n');
    
    % Input Matrix A
    fprintf('\nEnter coefficient matrix A (3x3):\n');
    A = zeros(3, 3);
    for i = 1:3
        prompt = sprintf('  Row %d: ', i);
        A(i, :) = input(prompt);
    end
    
    % Input Vector b
    fprintf('\nEnter right-hand side vector b (Targets):\n');
    fprintf('Enter as column vector (e.g., [100; 1000; 36]): ');
    b = input('');
    
    % Solve
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- MIXING INSTRUCTIONS ---\n');
        fprintf('Cytotoxic Drug: %.4f mL\n', solution(1));
        fprintf('Saline Diluent: %.4f mL\n', solution(2));
        fprintf('pH Buffer:      %.4f mL\n', solution(3));
        
        verifySolution(A, solution, b);
    else
        fprintf('\nFailed to solve. Check inputs.\n');
    end
end

function solve4x4System()
    % Solve 4x4 system for TPN
    fprintf('\n--- SCENARIO 2: TPN NUTRITION (4 Variables) ---\n');
    fprintf('You are mixing Dextrose, Amino Acids, Lipids, and Sodium.\n');
    
    fprintf('--- EXPLANATION OF THE MATH (THE MATRIX) ---\n');
    fprintf('Row 1 (Volume): [1 1 1 1] -> All ingredients add to the bag volume.\n');
    fprintf('Row 2 (Calor):  [3.4 4 9 0] -> Dextrose(3.4), Amino(4), Lipid(9) provide kcal. Salt(0) does not.\n');
    fprintf('Row 3 (Prot):   [0 0.1 0 0] -> Only Amino Acids provide Protein (0.1g/mL).\n');
    fprintf('Row 4 (Salt):   [0 0 0 4.0] -> We add pure Sodium (4mEq/mL) to balance electrolytes.\n');

    fprintf('\n[DEMO CHEAT SHEET - TYPE THESE EXACT NUMBERS]\n');
    fprintf('Matrix A Row 1:  [1 1 1 1]\n');
    fprintf('Matrix A Row 2:  [3.4 4.0 9.0 0]\n');
    fprintf('Matrix A Row 3:  [0 0.1 0 0]\n');
    fprintf('Matrix A Row 4:  [0 0 0 4.0]\n');
    fprintf('Target Vector b: [1220; 5500; 50; 80]\n');
    fprintf('-----------------------------------------------------\n');
    
    fprintf('\nEnter coefficient matrix A (4x4):\n');
    A = zeros(4, 4);
    for i = 1:4
        prompt = sprintf('  Row %d: ', i);
        A(i, :) = input(prompt);
    end
    
    fprintf('\nEnter right-hand side vector b:\n');
    fprintf('Enter as column vector (e.g., [1220; 5500...]): ');
    b = input('');
    
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- MIXING INSTRUCTIONS ---\n');
        fprintf('Dextrose (Carbs):  %.4f mL\n', solution(1));
        fprintf('Amino Acids:       %.4f mL\n', solution(2));
        fprintf('Lipids (Fats):     %.4f mL\n', solution(3));
        fprintf('Sodium Chloride:   %.4f mL\n', solution(4));
        
        verifySolution(A, solution, b);
    else
        fprintf('\nFailed to solve. Check inputs.\n');
    end
end

function solve5x5System()
    % Solve 5x5 system for Complex TPN
    fprintf('\n--- SCENARIO 3: COMPLEX TPN + POTASSIUM (5 Variables) ---\n');
    fprintf('Same as 4x4, but now balancing Potassium (Heart safety).\n');
    
    fprintf('--- EXPLANATION OF THE MATH (THE MATRIX) ---\n');
    fprintf('Row 1-4: Same as TPN (Vol, Kcal, Prot, Na).\n');
    fprintf('Row 5 (Potass): [0 0 0 0 2.0] -> We add Potassium Acetate (2mEq/mL).\n');
    fprintf('*Real Life Note: Amino Acids often contain hidden K+, making this matrix harder to solve manually!*\n');

    fprintf('\n[DEMO CHEAT SHEET - TYPE THESE EXACT NUMBERS]\n');
    fprintf('Matrix A Row 1:  [1 1 1 1 1]\n');
    fprintf('Matrix A Row 2:  [3.4 4.0 9.0 0 0]\n');
    fprintf('Matrix A Row 3:  [0 0.1 0 0 0]\n');
    fprintf('Matrix A Row 4:  [0 0 0 4.0 0]\n');
    fprintf('Matrix A Row 5:  [0 0 0 0 2.0]\n');
    fprintf('Target Vector b: [1230; 5500; 50; 80; 20]\n');
    fprintf('-----------------------------------------------------\n');
    
    fprintf('\nEnter coefficient matrix A (5x5):\n');
    A = zeros(5, 5);
    for i = 1:5
        prompt = sprintf('  Row %d: ', i);
        A(i, :) = input(prompt);
    end
    
    fprintf('\nEnter right-hand side vector b:\n');
    fprintf('Enter as column vector: ');
    b = input('');
    
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- MIXING INSTRUCTIONS ---\n');
        fprintf('Dextrose:        %.4f mL\n', solution(1));
        fprintf('Amino Acids:     %.4f mL\n', solution(2));
        fprintf('Lipids:          %.4f mL\n', solution(3));
        fprintf('Sodium:          %.4f mL\n', solution(4));
        fprintf('Potassium:       %.4f mL\n', solution(5));
        
        verifySolution(A, solution, b);
    else
        fprintf('\nFailed to solve. Check inputs.\n');
    end
end

function solveCustomSystem()
    fprintf('\n--- Custom Matrix Solver ---\n');
    n = input('Enter matrix size (3, 4, or 5): ');
    
    if n < 3 || n > 5
        fprintf('Invalid size.\n'); return;
    end
    
    A = zeros(n, n);
    fprintf('Enter Matrix A:\n');
    for i = 1:n
        prompt = sprintf('  Row %d: ', i);
        A(i, :) = input(prompt);
    end
    
    fprintf('Enter Vector b: ');
    b = input('');
    
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\nSolution Vector x:\n');
        disp(solution);
        verifySolution(A, solution, b);
    end
end

function verifySolution(A, x, b)
    fprintf('\n[Verification] Calculated (A*x) vs Target (b):\n');
    calculated = A * x;
    disp(table(calculated, b, 'VariableNames', {'Calculated', 'Target'}));
end

function displayHelp()
    fprintf('\n--- HELP & CONTEXT ---\n');
    fprintf('This tool uses Gaussian Elimination to solve "Mass Balance" equations.\n');
    fprintf('In pharmacy, we often have multiple ingredients (Bottles) that each\n');
    fprintf('contribute to multiple goals (Volume, Calories, pH).\n\n');
    fprintf('Since Ingredient A affects Goal 1 AND Goal 2, we cannot calculate\n');
    fprintf('them separately. We must solve them as a simultaneous system.\n');
end