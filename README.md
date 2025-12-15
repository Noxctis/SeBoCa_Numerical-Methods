# SeBoCa_Numerical-Methods
A MATLAB-based biomedical tool for optimizing IV drug mixtures (3x3 to 5x5 matrices) and tracking patient vitals using Numerical Methods (Gaussian Elimination, Interpolation, Integration).

## Overview
This project provides numerical methods tools specifically designed for medical dosage calculations. The primary focus is on solving systems of linear equations to determine optimal drug mixture compositions for various medical contexts, including Oncology and Total Parenteral Nutrition (TPN).

## Features
### Gaussian Elimination Solver
The `GaussianSolver.m` function implements Gaussian Elimination with partial pivoting to solve systems of linear equations. It supports:
- **3x3 Systems**: Drug/Saline/Buffer mixtures for Oncology applications
- **4x4 Systems**: Addition of Sodium for basic TPN formulations
- **5x5 Systems**: Addition of Potassium for complex TPN with complete electrolyte management

### Osmolarity Safety Engine
For Oncology mixtures (3x3), the system automatically calculates the final osmolarity of the mix and flags unsafe solutions:
- **Hypotonic (<150 mOsm/L):** Flags as dangerous (risk of cell lysis).
- **Isotonic (280-300 mOsm/L):** Safe for standard peripheral IVs.
- **Hypertonic (>600 mOsm/L):** Recommends Central Line infusion to prevent phlebitis.

### Interactive Console Menu
The `main.m` script provides a user-friendly console interface for:
- Selecting different system sizes (3x3, 4x4, 5x5)
- Inputting coefficient matrices and target vectors
- Viewing calculated solutions with verification
- Accessing comprehensive help documentation

## Medical Context
### Oncology Applications (3x3 Systems)
In chemotherapy drug preparation, precise mixing of components is critical for:
- **Drug Concentration**: Active pharmaceutical ingredient dosing
- **Saline Solution**: Isotonic carrier medium for safe administration
- **Buffer Solution**: pH stabilization to prevent tissue damage
The solver calculates exact amounts needed to meet multiple constraints simultaneously, such as:
- Target drug concentration for therapeutic efficacy
- Total volume requirements for administration route
- Osmolarity targets for patient comfort and safety

**Why Osmolarity Matters:**
Intravenous fluids must match the tonicity of blood plasma.
- **Isotonic:** Water flows equally in and out of the cell.
- **Hypotonic:** Water rushes into the cell, causing it to burst (lysis).
- **Hypertonic:** Water rushes out of the cell, causing it to shrivel (crenation).

### Total Parenteral Nutrition - TPN (4x4 Systems)
TPN provides complete nutrition intravenously for patients who cannot consume food orally. Components include:
- **Base Nutrients**: Glucose, amino acids, lipids (simplified as "Drug" in model)
- **Saline**: Fluid carrier and basic electrolyte source
- **Buffer**: pH management for vein protection
- **Sodium**: Critical electrolyte for fluid balance and cellular function
The 4x4 system ensures proper balance of nutritional and electrolyte requirements.

### Complex TPN (5x5 Systems)
Advanced TPN formulations include:
- **Potassium**: Essential electrolyte for cardiac function and cellular metabolism
- All components from 4x4 system
- More precise control over electrolyte ratios
This is used for patients with specific metabolic conditions requiring careful electrolyte management.

## Usage
### Running the Program
1. Open MATLAB
2. Navigate to the project directory
3. Run the main program:
   ```matlab
   main
   ```

### Example: 3x3 Oncology Drug Mixture
```matlab
% Simple example that can be run directly
A = [2 1 1; 1 3 2; 1 1 2];
b = [100; 150; 80];
[solution, success] = GaussianSolver(A, b);
if success
    fprintf('Drug amount:   %.4f units\n', solution(1));
    fprintf('Saline amount: %.4f units\n', solution(2));
    fprintf('Buffer amount: %.4f units\n', solution(3));
    
    % The system will also output a safety check:
    % [Safety Check] Final Osmolarity: 290.00 mOsm/L
    % STATUS: Safe for Peripheral IV.
end
```

### Example: 4x4 TPN with Sodium
```matlab
A = [2 1 1 0.5; 1 3 2 1; 1 1 2 0.5; 0.5 1 0.5 2];
b = [100; 150; 80; 60];
[solution, success] = GaussianSolver(A, b);
if success
    fprintf('Drug amount:   %.4f units\n', solution(1));
    fprintf('Saline amount: %.4f units\n', solution(2));
    fprintf('Buffer amount: %.4f units\n', solution(3));
    fprintf('Sodium amount: %.4f units\n', solution(4));
end
```

## File Structure
```
SeBoCa_Numerical-Methods/
├── GaussianSolver.m    # Gaussian Elimination implementation
├── main.m              # Interactive console menu
├── README.md           # This file
└── LICENSE             # License information
```

## Mathematical Method
### Gaussian Elimination with Partial Pivoting
The solver uses a robust implementation of Gaussian Elimination:
1. **Forward Elimination**: Transforms the system to upper triangular form
   - Partial pivoting: Selects the largest pivot element to minimize numerical errors
   - Row operations: Eliminates variables systematically
2. **Back Substitution**: Solves for unknowns from bottom to top
   - Starts with the last equation (single variable)
   - Substitutes known values upward
3. **Error Checking**:
   - Detects singular or nearly singular matrices
   - Warns about negative solutions (invalid for dosage calculations)
   - Validates input dimensions and types

### Osmolarity Calculation
Once the component volumes ($x$) are solved, the system calculates the final concentration using the weighted average formula:

$$Osmolarity = \frac{\sum (Volume_i \times Osmolarity_i)}{\sum Volume_i}$$

This result is compared against medical safety thresholds (150 mOsm/L lower limit, 600 mOsm/L upper limit for peripheral lines).

## Safety Notes
⚠️ **IMPORTANT MEDICAL DISCLAIMER** ⚠️
- This software is designed for **educational and planning purposes only**
- All calculated dosages must be verified by qualified medical professionals
- Never use this tool as the sole basis for drug administration decisions
- Always follow established medical protocols and institutional guidelines
- Consult with pharmacists and physicians before preparing any medication
- This tool does not replace clinical judgment or regulatory compliance requirements

## Requirements
- MATLAB R2016b or later (may work with earlier versions)
- No additional toolboxes required

## Contributing
Contributions are welcome! Please ensure that any modifications maintain:
- Numerical stability and accuracy
- Clear documentation of medical context
- Appropriate safety warnings
- Compatibility with standard MATLAB installations

## License
See LICENSE file for details.

## Authors
**Chrys Sean Sevilla, Sid Andre Bordario, Cyril John Christian Calo** University of San Carlos, Department of Computer Engineering  
Course: Numerical Methods

## Acknowledgments
This project applies classical numerical methods to modern biomedical challenges, demonstrating the practical value of computational mathematics in healthcare.