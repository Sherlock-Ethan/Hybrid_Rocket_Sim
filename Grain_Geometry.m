% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: Grain_Geometry.m 
% File Description: Calculates instantaneous fuel grain geometry per regression rate step
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/08/21  Initial Creation 
% ---------------------------------------------------------------------- %

%% Initialize Geometry
% Angles
theta1(1) = asind(SlotW(1)/GrainID(1));                         % Degrees
theta2(1) = atand((SlotW(1)/2)/(StaticL(1) + (GrainID(1)/2)));  % Degrees
theta3 = 360 / (nSlots*2);                                      % Degrees

% Perimeter
SlotR(1) = (SlotW(1)/2) / (sind(theta2(1)));            % Radius of the slot
SlotR2(1) = (SlotW(1)/2) / (sind(theta2(1)));           % Radius of slot (to calculate theta2 after radius exceeds GrainOD/2)
SlotEnd(1) = SlotR(1)*2*pi*(theta2(1)/360)*2;           % length of one slot end
PTip(1) = GrainID(1)*pi*((theta3 - theta1(1))/360)*2;   % length of one tip
SlotD(1) = cosd(theta2(1))*SlotR(1) - cosd(theta1(1))*(GrainID(1)/2); % Full length of the slot (includes remainder)
Perimeter(1) = SlotEnd(1)*8 + SlotD(1)*16 + PTip(1)*8;

% Surface Area
SA(1) = Perimeter(1) * GrainL;

% Crossectional Area
alpha(1) = theta2(1)*2;
alpha2(2) = theta1(1)*2;
CirSegTop(1) = (1/2)*(SlotR(1)^2)*(alpha(1)*(pi/180) - sind(alpha(1)));
TriCrv(1) = SlotW(1)*(SlotD(1)-SlotL(1)) - (1/2)*((GrainID(1)/2)^2)*(alpha2(1)*(pi/180) - sind(alpha2(1)));
CS(1) = (pi*GrainOD^2)/4 - (pi*GrainID(1)^2)/4 - (SlotL(1)*SlotW(1))*8 - CirSegTop(1)*8 - TriCrv(1)*8;

%% Geometry Calculation
if n > 1
   % Driving Variables
   SlotW(n) = SlotW(n-1) + 2*RgrsPerStp; % Correct
   GrainID(n) = GrainID(n-1) + 2*RgrsPerStp; 
   SlotR(n) = SlotR(n-1) + RgrsPerStp;          % Radius of slot 
   %SlotR2(n) = SlotR2(n-1) + RgrsPerStp;        % Radius of slot (to calculate theta2 after radius exceeds GrainOD/2)
   theta1(n) = asind(SlotW(n)/GrainID(n));      % Angle of slot tip corner
   theta2(n) = asind((SlotW(n)/2)/SlotR(n));    % Angle of slot end corner   
   
   % Check if the tip is still present
    if (theta3 - theta1(n)) < 0.0 | PTipFlag(n-1) == true
        PTipFlag(n) = true;     
        theta1(n) = theta3; % Correct
        GrainID(n) = GrainID(n-1) + (RgrsPerStp)/sind(theta3)*2;
        if GrainID(n) >= GrainOD
           GrainID(n) = GrainOD; 
        end
    else
        theta1(n) = asind(SlotW(n)/GrainID(n));
        PTipFlag(n) = false;
    end
    
    % Check if the slot end burned through
    if (SlotR(n) >= GrainOD/2) 
        SlotR(n) = GrainOD/2;
        SlotEnd(n) = 0.0;
        if MaxWFlag == false
            SnapSlotW =  SlotW(n);  % Correct
            SnapTheta2 = theta2(n); % Correct 
            MaxWFlag = true;
        end
    else
        SlotEnd(n) = SlotR(n)*2*pi*(theta2(n)/360)*2;
    end
    SlotHW(n) = SlotW(n)/2; % Half of Slot Width
    theta2(n) = asind(SlotHW(n)/SlotR(n)); % Correct CONFIRMED
    
    alpha(n) = theta2(n)*2;
    SlotL(n) = cosd(theta2(n))*SlotR(n) - GrainID(n)/2;
    CirSegTop(n) = (1/2)*(SlotR(n)^2)*(alpha(n)*(pi/180) - sind(alpha(n)));
    
    if SlotL(n) < 0.0
        SlotL(n) = 0.0;
    end
    
    SlotA(n) = SlotL(n)*SlotW(n);
   
   % Perimeter
   PTip(n) = GrainID(n)*pi*((theta3-theta1(n))/360)*2; % length of one tip, correct
   FullLength(n) = cosd(theta2(n))*SlotR(n);
   CutAwayLength(n) = cosd(theta1(n))*(GrainID(n)/2);
   SlotD(n) = (cosd(theta2(n))*SlotR(n)) - cosd(theta1(n))*(GrainID(n)/2); % Full length of the slot (includes remainder)
   if SlotD(n) < 0.0
       SlotD(n) = 0.0;
   end
   Perimeter(n) = SlotEnd(n)*8 + SlotD(n)*16 + PTip(n)*8;
   
    
   if PTipFlag == true
       alpha2(n) = theta1(n)*2; 
       TriCrv(n) = SlotW(n)*SlotD(n) - (1/2)*((GrainID(n)/2)^2)*(alpha2(n)*(pi/180) - sind(alpha2(n)));
   else
       alpha2(n) = theta1(n)*2;
       TriCrv(n) = SlotW(n)*(SlotD(n)-SlotL(n)) - (1/2)*((GrainID(n)/2)^2)*(alpha2(n)*(pi/180) - sind(alpha2(n)));
   end
 
   % Surface Area
   SA(n) = Perimeter(n) * GrainL;
   
   % Crossectional Area
   CS(n) = (pi*GrainOD^2)/4 - (pi*GrainID(n)^2)/4 - SlotA(n)*8 - CirSegTop(n)*8 - TriCrv(n)*8;
  
   
   if(SA(n) < 0.0 || CS(n) < 0.0)
      StopBurn = true; 
   end
 
   if SlotW(n) >= 0.0327932796
       Snaptheta2 = theta2(n);
   end
   
end



