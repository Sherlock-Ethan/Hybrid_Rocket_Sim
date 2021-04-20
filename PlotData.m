% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: PlotData.m 
%
% File Description: Plots all results
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/09/21  Initial Creation 
% ---------------------------------------------------------------------- %
Thrustdlvd(n-1) = 0.0;
PC(n-1)         = 0.0;
OFRatio(n-1)    = 0.0;
PNOx(n-1)       = 0.0;
MFuelGen(n-1)   = 0.0;

figure
plot(BurnTime,SA)
title('Fuel Grain Surface Area vs Time')
xlabel('Time (s)')
ylabel('Surface Area (m^2)')
grid on
ylim([0 0.2])

figure
plot(BurnTime,Perimeter)
title('Fuel Grain Perimeter vs Time')
xlabel('Time (s)')
ylabel('Perimeter (m)')
grid on

figure
plot(BurnTime,PNOx,BurnTime,PC)
title('Pressure vs Time')
xlabel('Time (s)')
ylabel('Pressure (kPa)')
legend('N20 Tank','Combustion Chamber')
grid on

figure
plot(BurnTime,MFuelGen)
title('Fuel Mass Generated')
xlabel('Time (s)')
ylabel('Mass (kg)')
grid on

figure
plot(BurnTime,OxdzrMass)
title('N2O Mass Left')
xlabel('Time (s)')
ylabel('Mass (kg)')
grid on
ylim([0 8])

% figure
% plot(BurnTime,OFRatio)
% title('O/F Ratio')
% xlabel('Time (s)')
% ylabel('')
% grid on
% ylim([0 12])

figure
plot(BurnTime,TotallImp)
title('Total Impulse')
xlabel('Time (s)')
ylabel('N*s')
grid on


figure
plot(BurnTime,Thrustdlvd)
title('Thrust Curve')
xlabel('Time (s)')
ylabel('Thrust (N)')
grid on
%ylim([0 3500])

% figure
% plot(BurnTime,MassGen)
% title('Total Mass Generated')
% xlabel('Time (s)')
% ylabel('Mass (kg)')
% grid on
% ylim([0.01 0.02])

figure
plot(BurnTime,FuelMass)
title('Fuel Grain Mass Left')
xlabel('Time (s)')
ylabel('Mass (kg)')
grid on
%ylim([0 1.4])

figure
plot(BurnTime,MassFlow)
title('Total Mass Flow')
xlabel('Time (s)')
ylabel('Mass (kg)')
grid on

figure
plot(BurnTime,CS)
title('Cross Sectional Area vs Time')
xlabel('Time (s)')
ylabel('Area (m^2)')
grid on

figure 
plot(BurnTime,theta1,BurnTime,theta2)
title('Theta 1 and Theta 2 vs Time')
xlabel('Time (s)')
ylabel('Angle (deg)')
legend('Theta 1','Theta 2')
grid on

figure
plot(BurnTime,OFRatio)
title('O/F Ratio')
xlabel('Time (s)')
ylabel('')
grid on

fprintf('\n------------ Simulation Results ------------\n')
fprintf('Burn Time:             %.2f     (s)\n', BurnTime(n-1))
fprintf('Average Thrust:        %.2f  (N)\n', mean(Thrustdlvd))
fprintf('Total Impulse:         %.2f (Ns)\n', TotallImp(n-1))
fprintf('Max PN2O:              %.2f   (Psi)\n', max(PNOx)/kPa2Psi)
fprintf('Max PC:                %.2f   (Psi)\n', max(PC)/kPa2Psi)
fprintf('Mass N2O:              %.2f    (lbs)\n', max(OxdzrMass)*kg2lbs)
toc