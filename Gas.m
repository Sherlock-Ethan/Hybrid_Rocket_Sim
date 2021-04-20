% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: Gas.m 
%
% File Description: 
% Calculates N2O tank pressure, combustion chamber pressure, and describes
% oxidizer properties 
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/09/21  Initial Creation 
% ---------------------------------------------------------------------- %

% Initialize Oxidizer Properties
N2OPropTbl = table2array(N2OProperties);
PNOx(1) = interp1(N2OPropTbl(:,1),N2OPropTbl(:,2),N2OTemp,'spline');
NOxRho(1) = interp1(N2OPropTbl(:,1),N2OPropTbl(:,3),N2OTemp,'spline');
OxdzrMass(1) = NOxTankVol * NOxRho(1);
f(n) = MFuelGen(n) / HRMdt;                                         % Fuel flow rate (kg/s) mdot

if n > 1
    PNOx(n) = PNOx(1) - PNOx(n-1)*BurnTime(n)*PresDcln;             % s * 1/s
    
end 

% Pressure of combustion chamber
PC(n) = (3/(121*(NzlAT^2))) * ((20*sqrt(5))*sqrt(121*(NzlAT^2)*(InjDischrg^2)*(InjAreaT^2)*NOxRho(1)*PNOx(n)...
      - 33*NzlAT*(InjDischrg^2)*f(n)*(InjAreaT^2)*NOxRho(1) + 4500*(InjDischrg^4)*(InjAreaT^4)*NOxRho(1)^2) ...
      + 11*NzlAT*f(n) - 3000*(InjDischrg^2)*(InjAreaT^2)*NOxRho(1));

HeadLoss(n) = (PNOx(n) - PC(n))*1000 / (NOxRho(1) * gravity);       % Headloss (m) [kg/m*s^2 / (kg/m^3 * m/s^2 )]

OxdzrVol(n) = InjAreaT * InjDischrg * sqrt(2*gravity*HeadLoss(n));  % Volumetric Flow Rate [m^2 * sqrt(m/s^2 * m)]

MOxdzrGen(1) = OxdzrVol(1) * NOxRho(1) * HRMdt;                     % Mass of oxygen (kg) - initialize here
if n > 1
    MOxdzrGen(n) = OxdzrVol(n) * NOxRho(1) * HRMdt;
    OxdzrMass(n) = OxdzrMass(n - 1) - MOxdzrGen(n);
    if OxdzrMass(n) < 0.0
        StopBurn = true;
    end
end
