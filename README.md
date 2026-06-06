# Beam Deflection Analysis

## Project Overview

A custom simulation tool engineered in MATLAB to visualize structural beam displacement under single and multiple loading configurations.

## Key Features

- **Principle of Superposition:** Programmed nested loop structures to calculate and overlay total structural deflection under complex multi-load scenarios.
- **Automated Error Handling:** Built a robust data validation function with warning systems to ensure physical boundary constraints are met before calculation.
- **Dynamic Graphics Generation:** Generated material-specific plots featuring automated unit conversions, customized gridlines, and strict technical formatting.

## File Structure

- `MA5.m` : **The main driver script** that handles user inputs, executes deflection mathematics, and renders the material-specific plots.
- `MaterialElasticity.mat` : **The data file** containing the structural properties and material constants required for the deflection simulations.
