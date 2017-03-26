%% Clearing Variables
tic; clc; clear variables; close all; more off; %profile off; %warning off;
format shortG; format compact % format longg %rat

%% Setting defaults for plots
set(0,'DefaultFigureWindowStyle','docked')
set(0,'DefaultLineLineWidth',3);% set(0,'defaultAxesLineStyleOrder','remove')
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;0 0 0;1 0 1]);% set(0,'defaultAxesColorOrder','remove')
set(0,'DefaultAxesLineStyleOrder',':|-.|--');% set(0,'DefaultLineLineWidth','remove')
set(0,'DefaultAxesXGrid','on','DefaultAxesYGrid','on')

fprintf('Initialized (clearing data and closing figures) in %.2f seconds\n',toc)
