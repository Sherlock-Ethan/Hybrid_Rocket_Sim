% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: Logic.m 
% File Description: Main executive model. controls logic of the program
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/08/21  Initial Creation 
% ---------------------------------------------------------------------- %

while StopBurn == 0
    BurnTime(n) = time; % Simulation Time
    
    RegressionRate  % Call Regression Rate Model
    Grain_Geometry  % Call Instantaneous Grain Geometry Model
    
    % Calculate Fuel Mass Properties
    FuelVol(n) = CS(n) * GrainL;
    MFuelGen(n) = RgrsPerStp*FuelRho*SA(n);
    FuelMass(n) = FuelRho*FuelVol(n);
    
    Pressure        % Call Pressure Model

    % Fuel Mass Prop continued & O/F Ratio calculation
    OFRatio(n) = MOxdzrGen(n)/MFuelGen(n);
    MassGen(n) = MOxdzrGen(n) + MFuelGen(n);
    MassFlow(n) = MassGen(n)/HRMdt;
    
    Thrust          % Call Thrust Model
    
    time = time + HRMdt;
    n = n + 1;
end
PlotData