% main.m - Medical Dosage Calculator (Gaussian Elimination)
% Main console menu for selecting Matrix Solvers
% 
% Group Members: Chrys Sean Sevilla, Sid Andre Bordario, Cyril John Christian Calo
%
% This program provides tools for calculating optimal drug mixtures
% for Oncology (3x3), TPN (4x4), and Complex Nutrition (5x5).

function main()
    clc;
    while true
        fprintf('\n======================================================\n');
        fprintf('  MEDICAL DOSAGE CALCULATOR (GAUSSIAN ELIMINATION)\n');
        fprintf('======================================================\n');
        fprintf('  1. 3x3 ONCOLOGY MIX (Drug, Saline, Buffer)\n');
        fprintf('  2. 4x4 TPN NUTRITION (Dextrose, Amino, Lipids, Na)\n');
        fprintf('  3. 5x5 COMPLEX TPN (Dex, Amino, Lipids, Na, K)\n');
        fprintf('  0. Exit\n');
        fprintf('======================================================\n');
        
        choice = input('Enter your choice: ');
        
        switch choice
            case 1
                runScenario3x3();
            case 2
                runScenario4x4();
            case 3
                runScenario5x5();
            case 0
                fprintf('\nExiting application.\n');
                break;
            otherwise
                fprintf('\nInvalid choice. Please try again.\n');
        end
        
        if choice ~= 0
            input('\nPress Enter to return to menu...');
            clc;
        end
    end
end

function runScenario3x3()
    fprintf('\n--- SCENARIO: ONCOLOGY CHEMOTHERAPY (3 Ingredients) ---\n');
    fprintf('Ingredients: 1.Cytotoxin  2.Saline  3.Buffer\n');
    fprintf('Constraints: Total Volume, Total Dosage(mg), Total Stabilizer(units)\n');
    
    fprintf('\n[CHEAT SHEET - TYPE THESE NUMBERS FOR DEMO]\n');
    fprintf('Matrix A Row 1 (Volume):  [1 1 1]\n');
    fprintf('Matrix A Row 2 (Conc):    [50 0 0]\n');
    fprintf('Matrix A Row 3 (Stab):    [0.1 0.2 2.0]\n');
    fprintf('Target Vector b:          [100; 1000; 36]\n');
    fprintf('-----------------------------------------------------\n');
    
    solveSystem(3, {'Cytotoxin', 'Saline', 'Buffer'});
end

function runScenario4x4()
    fprintf('\n--- SCENARIO: TPN NUTRITION (4 Ingredients) ---\n');
    fprintf('Ingredients: 1.Dextrose  2.AminoAcids  3.Lipids  4.Sodium\n');
    fprintf('Constraints: Volume, Calories, Protein, Sodium Level\n');
    
    fprintf('\n[CHEAT SHEET - TYPE THESE NUMBERS FOR DEMO]\n');
    fprintf('Matrix A Row 1 (Volume):  [1 1 1 1]\n');
    fprintf('Matrix A Row 2 (Kcal):    [3.4 4.0 9.0 0]\n');
    fprintf('Matrix A Row 3 (Prot):    [0 0.1 0 0]\n');
    fprintf('Matrix A Row 4 (Salt):    [0 0 0 4.0]\n');
    fprintf('Target Vector b:          [1220; 5500; 50; 80]\n');
    fprintf('-----------------------------------------------------\n');
    
    solveSystem(4, {'Dextrose', 'Amino Acids', 'Lipids', 'Sodium'});
end

function runScenario5x5()
    fprintf('\n--- SCENARIO: COMPLEX TPN + ELECTROLYTES (5 Ingredients) ---\n');
    fprintf('Ingredients: 1.Dex 2.Amino 3.Lipids 4.Sodium 5.Potassium\n');
    fprintf('Constraints: Vol, Kcal, Prot, Na, K\n');
    
    fprintf('\n[CHEAT SHEET - TYPE THESE NUMBERS FOR DEMO]\n');
    fprintf('Matrix A Row 1 (Volume):  [1 1 1 1 1]\n');
    fprintf('Matrix A Row 2 (Kcal):    [3.4 4.0 9.0 0 0]\n');
    fprintf('Matrix A Row 3 (Prot):    [0 0.1 0 0 0]\n');
    fprintf('Matrix A Row 4 (Salt):    [0 0 0 4.0 0]\n');
    fprintf('Matrix A Row 5 (Potass):  [0 0 0 0 2.0]\n');
    fprintf('Target Vector b:          [1230; 5500; 50; 80; 20]\n');
    fprintf('-----------------------------------------------------\n');
    
    solveSystem(5, {'Dextrose', 'Amino Acids', 'Lipids', 'Sodium', 'Potassium'});
end

function solveSystem(n, names)
    A = zeros(n, n);
    fprintf('\nENTER MATRIX A (Row by Row):\n');
    for i = 1:n
        fprintf('Row %d: ', i);
        row = input('');
        if length(row) ~= n
            error('Row length must match matrix size.');
        end
        A(i, :) = row;
    end
    
    fprintf('\nENTER TARGET VECTOR b:\n');
    b = zeros(n, 1);
    for i = 1:n
        fprintf('Target %d: ', i);
        b(i) = input('');
    end
    
    % Call the GaussianSolver function
    [solution, success] = GaussianSolver(A, b);
    
    if success
        fprintf('\n--- RX MIXING INSTRUCTIONS ---\n');
        for i = 1:n
            fprintf('Volume of %-12s: %8.4f mL\n', names{i}, solution(i));
        end
        
        % Verification Step
        fprintf('\n[Verification] A * x (Calculated) vs b (Target):\n');
        calculated_b = A * solution;
        disp(table(calculated_b, b, 'VariableNames', {'Calculated', 'Target'}));
    else
        fprintf('\nCalculation Failed (Singular Matrix or Error).\n');
    end
end