% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: Oxidizer.m 
% File Description: Calculates N2O tank pressure, combustion chamber 
% pressure, and describes oxidizer properties
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
f(n) = MFuelGen(n) / HRMdt;

if n > 1
    PNOx(n) = PNOx(1) - PNOx(n-1)*BurnTime(n)*PresDcln; 
    
end 

PC(n) = (3/(121*(NzlAT^2))) * ((20*sqrt(5))*sqrt(121*(NzlAT^2)*(InjDischrg^2)*(InjAreaT^2)*NOxRho(1)*PNOx(n)...
      - 33*NzlAT*(InjDischrg^2)*f(n)*(InjAreaT^2)*NOxRho(1) + 4500*(InjDischrg^4)*(InjAreaT^4)*NOxRho(1)^2) ...
      + 11*NzlAT*f(n) - 3000*(InjDischrg^2)*(InjAreaT^2)*NOxRho(1));

HeadLoss(n) = (PNOx(n) - PC(n))*1000 / (NOxRho(1) * gravity);

OxdzrVel(n) = NEFF * InjAreaT * InjDischrg * sqrt(2*gravity*HeadLoss(n));

MOxdzrGen(1) = OxdzrVel(1) * NOxRho(1) * HRMdt; % Need to initialize here
if n > 1
    MOxdzrGen(n) = OxdzrVel(n) * NOxRho(1) * HRMdt;
    OxdzrMass(n) = OxdzrMass(n - 1) - MOxdzrGen(n);
    if OxdzrMass(n) < 0.0
        StopBurn = true;
    end
end
