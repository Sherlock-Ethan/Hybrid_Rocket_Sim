% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: Thrust.m 
% File Description: Calculates instantaneous CStar, thrust, specific impulse
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/09/21  Initial Creation 
% ---------------------------------------------------------------------- %

if (OFRatio(n) < 5 && OFRatio(n) > 3)
    CStar(n) = - 16.25 * (OFRatio(n) - 5)^2 + 1585 + abs((7500 - PNOx(n))/7500)*55;
elseif (OFRatio(n) <= 3)
     CStar(n) = 125 * (OFRatio(n) - 1) + 1250;
else
     CStar(n) = (-115/7) * (OFRatio(n) - 5) + 1585;
end        


Thrustdlvd(n) = MassGen(n)*CStar(n)/HRMdt;

Impulse(n) = Thrustdlvd(n)*HRMdt;

TotallImp(n) = sum(Impulse(:));

if Thrustdlvd(n) < 0.0
    StopBurn = true;
end