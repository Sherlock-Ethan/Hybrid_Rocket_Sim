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
% --------------------------------------------------------------------- %
close all
clear
clc
%% Import Tables
load ('N2OProperties.mat')
load ('AltitudeData.mat')
%% Simulation Dt
HRMdt = 1/100;          % Simulation rate (Hz)
%% Initialized Variables
n = 1;                  % Initialize counter
time = 0;               % Initialize time (s)
BurnTime = 0;           % Initialize BurnTime variable (s)
In2Mtr = 39.3701;       % Inch to meter converstion 
PTipFlag(1) = false;    % Tip perimeter flag (boolean)
StopBurn = false;       % Burn status flag (boolean)
MaxWFlag = false;       % Flag - Indicates maximum slot width 
flag = false;
gravity = 9.81;         % gravitation acceleration constant
%% User Defined Parameters 
% ----- Fuel Grain User Defined Parameters (convered to metric) ----- %
GrainOD     = 3.374 /In2Mtr;    % Grain OD (m)
GrainID(1)  = 0.750 /In2Mtr;    % Grain ID (m)
GrainL      = 13.50 /In2Mtr;    % Grain Length (m)
SlotL(1)    = 1.0 /In2Mtr;      % Slot Length (m) - used for CS calc
StaticL(1)  = SlotL(1);         % Static Slot Length (m) - used for SA calc
SlotW(1)    = 0.250 /In2Mtr;    % Slot Width (m)
nSlots      = 8.0;              % No. of Slots
FuelRho     = 1020.0;           % Fuel Density (kg/s)

% ----- N2O User Defined Parameters ----- %

N2OTemp    = 20.0;                  % NOx Temperature (C)
NOxTankL   = 50.593 /In2Mtr;        % Tank Length (m)
NOxTankID  = 3.624 /In2Mtr;         % Tank ID (m)
NOxTankCSA = pi*(NOxTankID/2)^2;    % Tank CS Area (m^2)
NOxTankVol = NOxTankCSA*NOxTankL;   % Tank Volume (M^3)
PresDcln   = 1/100;                 % Peressure Decline (%) 
NEFF       = 0.6;                   % Oxidizer velocity efficiency,
                                    % 1.0 to turn of NEFF affect
                                    % 0.6 for more realistic results
% ----- Injector Parameters ----- %

InjDia = 0.0625 /In2Mtr;             % Orifice Diameter
nOrif = 16.0;                       % No. of Orifices
InjDischrg = 0.975;                 % Discharge Coefficient
InjArea = pi*(InjDia/2)^2;          % Single Orifice Area
InjAreaT = InjArea*nOrif;           % Total Orifice Area

% ----- Nozzle ----- %

NzlThrtDia = 0.640 /39.37;          % Throat Diameter
NzlAT = pi*(NzlThrtDia/2)^2;        % Throat area
%% Main Code
Main