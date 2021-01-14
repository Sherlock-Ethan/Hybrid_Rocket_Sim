# Hybrid-Internal-Ballistic-Simulator

% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% Program Name: Hybrid Internal Ballistic Simulator  
% File Description: 
% First order approximation of the performance capabilities of a hybrid rocket motor.
% This model assumes ABS/N2O hybrid motor using a finocyl grain design. 
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/08/21  Initial Creation 
% --------------------------------------------------------------------- %

List of Files:
1. Startup.m
2. Main.m
3. Grain_Geometry.m
4. RegressionRate.m
5. Pressure.m
6. Thrust.m
7. PlotData.m

Description of Files:
StartUp.m
Defines user prameters and initializes key variables.

Main.m
Main executive model.  controls logic of the program.

Grain_Geometry.m
Calculates instantaneous fuel grain geometry per regression rate step.

RegressionRate.m
Calculates the fuel regression.  Initially assuming linear regression.

Pressure.m
Calculates N2O tank pressure, combustion chamber pressure, and describes oxidizer properties.

Thrust.m
Calculates instantaneous CStar, thrust, specific impulse.

PlotData.m
Plots all results
