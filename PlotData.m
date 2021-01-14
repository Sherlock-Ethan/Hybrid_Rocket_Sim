% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% File Name: PlotData.m 
% File Description: Plots all results
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/09/21  Initial Creation 
% ---------------------------------------------------------------------- %

figure
plot(BurnTime,SA)
title('Fuel Grain Surface Area vs Time')
xlabel('Time (s)')
ylabel('Surface Area (m^2)')
grid on
ylim([0 0.15])

figure
plot(BurnTime,PNOx)
title('Pressure of Oxidizer Tank')
xlabel('Time (s)')
ylabel('Pressure (kPa)')
grid on
ylim([0 5500])

figure
plot(BurnTime,PC)
title('Combustion Chamber Pressure')
xlabel('Time (s)')
ylabel('Pressure (kPa)')
grid on
ylim([2000 2900])

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

figure
plot(BurnTime,OFRatio)
title('O/F Ratio')
xlabel('Time (s)')
ylabel('')
grid on
ylim([0 12])

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
ylim([0 4000])

figure
plot(BurnTime,MassGen)
title('Total Mass Generated')
xlabel('Time (s)')
ylabel('Mass Flow (kg)')
grid on
ylim([0.01 0.03])

figure
plot(BurnTime,FuelMass)
title('Fuel Grain Mass Left')
xlabel('Time (s)')
ylabel('Mass (kg)')
grid on
ylim([0 1.4])

figure
plot(BurnTime,MassFlow)
title('Total Mass Flow')
xlabel('Time (s)')
ylabel('Mass (kg)')
grid on