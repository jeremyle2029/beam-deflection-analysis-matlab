clc
clear
clear all

%%T1
load("MaterialElasticity.mat");
matChoice = 0;
while matChoice == 0
    matChoice = menu("Select a Material", Material);
end
selectedMaterial = Material(matChoice);
E = Elasticity(matChoice);

%T2
L = ValidInput("Enter the length of the beam [m]: ");
w = ValidInput("Enter the width of the beam [m]: ");
h = ValidInput("Enter the height of the beam [m]: ");
I = (w * h^3) / 12;
%T3
F = ValidInput("Enter the magnitude of a concentrated force acting on the beam [N]: ");
Low = ValidInput(['Enter the location of the force (0  - ',num2str(L), ' meters): ']);
R = (F / L) * (L - Low);
theta = (F * Low) / (6 * E * I * L) * (2 * L - Low) * (L - Low);
x = linspace(0, L, 1000); 
y = zeros(size(x));
for i = 1:length(x)
    if x(i) <= Low
        y(i) = -theta * x(i) + (R * x(i)^3) / (6 * E * I);
    else
        y(i) = -theta * x(i) + (R * x(i)^3) / (6 * E * I) - (F * (x(i) - Low)^3) / (6 * E * I);
    end
end
yUnit = y * 1000;
%plot
figure(1);
plot(x, yUnit, 'b-');
xlabel("Beam Location (x) [m]");
ylabel("Deflection of Beam (y) [mm]");
title(['Deflection of ', char(selectedMaterial),'Beam under a Concentrated Load']);
xlim([0 L]);
grid on
%T4 & T5
repeatTask = "Yes";
while strcmpi(repeatTask, "Yes")
    multi = input("Enter the magnitudes of multiple loads on the beam [N]: ");
    multiLoc = input(['Enter the locations of the forces, in order (0 - ', num2str(L),  ' meters): ']);
    yTotal = zeros(size(x));
    for j = 1:length(multi)
        f = multi(j);
        loc = multiLoc(j);
        R = (f / L) * (L - loc);
        theta = (f * loc) / (6 * E * I * L) * (2 * L - loc) * (L - loc);
        yTemp = zeros(size(x));
        for i = 1:length(x)
            if x(i) <= loc
                yTemp(i) = -theta * x(i) + (R * x(i)^3) / (6 * E * I);
            else
                yTemp(i) = -theta * x(i) + (R * x(i)^3) / (6 * E * I) -(f * (x(i) - loc)^3) / (6 * E * I);
            end
        end
        yTotal = yTotal + yTemp;
    end
    yTotalUnit = yTotal * 1000;
    figure(2);
    plot(x, yTotalUnit, 'b-');
    xlabel("Beam Location (x) [m]");
    ylabel("Deflection of Beam (y) [mm]");
    title(['Deflection of ', char(selectedMaterial),'Beam under a Concentrated Load']);
    xlim([0 L]);
    grid on
    maxDef = max(abs(yTotalUnit));
    fprintf("The maximum deflection of the beam is %.3f [mm].\n", maxDef);
    %T5
    repeatTask = menu("Would you like to repeat the calculation for a differet set of loads?", "Yes", "No");
    if repeatTask == 1
        repeatTask = "Yes";
    else
        repeatTask = "No";
    end
end

%T2 Fuction
function value = ValidInput(prompt)
    value = input(prompt);
    attempts = 1;
    while value <= 0 && attempts < 3
        value = input(prompt);
        attempts = attempts + 1;
    end
    if value <= 0
        if value == 0
            error("Entered value is zero. Cannot solve problem, exiting program.");
        else
            warning("Invalid value entered 3 times. Taking the absulute value of the entered value.");
            value = abs(value);
        end
    end
end
