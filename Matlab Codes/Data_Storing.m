%% Dynamics of the system
E = [Cell.E_Plasmid_Population];
T = [Cell.T_Plasmid_Population];
Type = [Cell.Type];%{Cell.Type};

% Cell_Dynamics(iteration).Clock=[Cell.Clock];
% Cell_Dynamics(iteration).Cycle=[Cell.Cycle];
Cell_Dynamics(iteration).E_Plasmid_Population=E;
Cell_Dynamics(iteration).T_Plasmid_Population=T;
% Cell_Dynamics(iteration).Generation=[Cell.Generation];
Cell_Dynamics(iteration).Type=Type;
Cell_Dynamics(iteration).Time = Current_Time;