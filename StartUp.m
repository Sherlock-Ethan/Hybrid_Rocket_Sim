% --------- AIAA Internal Ballistic Simulator code for UCF HPR --------- %
% Program Name:  Hybrid Rocket Motor Internal Ballistic Simulator
% 
% Program Description: 
% First order approximation of the performance 
% capabilities of a hybrid rocket motor. This model assumes ABS/N2O 
% hybrid motor using a finocyl grain design.
% 
% File Name: StartUp.m 
% 
% File Description: 
% Defines user parameters and initializes key variables
% 
% Name            Date      Description
% --------------  --------  ------------------------------
% Ethan Sherlock  01/08/21  Initial Creation 
% ---------------------------------------------------------------------- %
close all
clear
clc
% ------------------------- Import Tables ------------------------- %
tic
load ('N2OProperties.mat')

% --------------------- Initialize Variables ---------------------- %

HRMdt = 1/1200;                     % Simulation rate (s)
n = 1;                              % Initialize counter
time = 0;                           % Initialize time (s)
BurnTime = 0;                       % Initialize BurnTime variable (s)
In2Mtr = 39.3701;                   % Inch to meter converstion 
kPa2Psi = 6.89476;                  % kPa to Psi
kg2lbs = 2.20462;                   % kg to lbs
PTipFlag(1) = false;                % Tip perimeter flag (boolean)
StopBurn = false;                   % Burn status flag (boolean)
MaxWFlag = false;                   % Flag - Indicates maximum slot width 
gravity = 9.81;                     % gravitation acceleration constant
%% User Defined Parameters 
% --------------- Fuel Grain User Defined Parameters --------------- %

GrainOD     = 3.374 /In2Mtr;        % Grain OD (m)
GrainID(1)  = 0.75 /In2Mtr;         % Grain ID (m)
GrainL      = 13.50 /In2Mtr;        % Grain Length (m)
SlotL(1)    = 0.77 /In2Mtr;         % Slot Length (m) - used for CS calc
StaticL(1)  = SlotL(1);             % Static Slot Length (m) - used for SA calc
SlotW(1)    = 0.25 /In2Mtr;         % Slot Width (m)
nSlots      = 8.0;                  % No. of Slots
FuelRho     = 1020.0;               % Fuel Density ABS (kg/m^3)

% ------------------ N2O User Defined Parameters ------------------- %

N2OTemp    = 20.0;                  % NOx Temperature (C)
NOxTankL   = 50.593 /In2Mtr;        % Tank Length (m)
NOxTankID  = 3.624 /In2Mtr;         % Tank ID (m)
NOxTankCSA = pi*(NOxTankID/2)^2;    % Tank CS Area (m^2)
NOxTankVol = NOxTankCSA*NOxTankL;   % Tank Volume (m^3)
PresDcln   = 1/100;                 % Peressure Decline (%) 

% ---------------- Injector User Defined Parameters ---------------- %

InjDia = 0.0625 /In2Mtr;            % Orifice Diameter
nOrif = 16.0;                       % No. of Orifices
InjDischrg = 0.3735;                % Discharge Coefficient  *********************
InjArea = pi*(InjDia/2)^2;          % Single Orifice Area
InjAreaT = InjArea*nOrif;           % Total Orifice Area

% ----------------------------- Nozzle ----------------------------- %

NzlThrtDia = 0.640 /In2Mtr;         % Throat Diameter
NzlAT = pi*(NzlThrtDia/2)^2;        % Throat area

%% Main Code
Main