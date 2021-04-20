% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: RegressionRate.m 
% File Description: Calculates the fuel regression rate
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/08/21  Initial Creation 
% ---------------------------------------------------------------------- %

% Simplified linear regression rate assumption
BurnRt      = 0.002;        % Burn Rate (m/s)

if n > 1
    if SlotD(n-1) < SlotD(1)*.25
       BurnRt = 0.0015;
    end
end

RgrsPerStp = BurnRt*HRMdt;  % Regression Per Step (m)