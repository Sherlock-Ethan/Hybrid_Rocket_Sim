% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: Main.m 
%
% File Description: 
% Main executive model. controls logic of the program
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/08/21  Initial Creation 
% ---------------------------------------------------------------------- %

while StopBurn == 0
    BurnTime(n) = time;                     % Simulation Time
    
    RegressionRate                          % Call Regression Rate Model
    GrainGeometry                           % Call Instantaneous Grain Geometry Model
    
    % Calculate Fuel Mass Properties
    FuelVol(n) = CS(n) * GrainL;            % Volume of fuel (kg)
    MFuelGen(n) = RgrsPerStp*FuelRho*SA(n); % Mass of fuel generated (kg) [m * kg/m^3 * m^2]
    FuelMass(n) = FuelRho*FuelVol(n);       % Instantaneous mass of fuel (kg)
    
    Gas                                     % Call Gas Model

    % Fuel Mass Prop continued & O/F Ratio calculation
    OFRatio(n) = MOxdzrGen(n)/MFuelGen(n);  % O/F ratio 
    MassGen(n) = MOxdzrGen(n) + MFuelGen(n);% Total mass generated (kg)
    MassFlow(n) = MassGen(n)/HRMdt;         % Total mass flow rate (kg/s)
    
    Thrust                                  % Call Thrust Model
    
    fprintf('Running...\n')
    
    if(theta2(n) >= theta1(n))
      break 
    end
    
    time = time + HRMdt;                    % Simulation Time
    n = n + 1;
end
PlotData