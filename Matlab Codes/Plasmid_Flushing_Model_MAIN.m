%% Plasmid Model
Start_UP % clearing variables and setting defaults

%% Parameters
Parameters_Data % File that handle parameters of the model

%% Initialization
global Total_Cell_Population
Total_Cell_Population = Initial.Total_Cell_Population;

Cell = Initlization_file(Initial); % Setting up the initial system
Initial.Cell = Cell; % Saving Initial Setup

% Preallocation of variables
n=1e6; % Reduce this number if your system's memory is low
Simulation_time = zeros(1,n);
D_Cell_Dynamics_Matrix = zeros(3,n);
R_Cell_Dynamics_Matrix = zeros(6,n);
Ratio_Matrix = zeros(2,n);

%% System Dynamics
tic;    iteration = 1;   Current_Time = 0;    Cured_Cell_Ratio = 0;

% Analysis of the Initial System
Data_Analysis

while Current_Time < Final_Time && Cured_Cell_Ratio < Final_Cured_Cell_Ratio

    % Cheking for empty system    
    Total_Cell_Population = size(Cell,2);
    if Total_Cell_Population == 0
        disp('All Cells in the system are flushed away. Exiting.....');
        break
    end
    
    % Propensities
    Propensity_Matrix = Propensity_file(Cell);
    
    % Identifying next state of the Cell and timestep
    [Time_step,Cell] = Gillespie_SSA(Propensity_Matrix,Cell);
    
    % Updating iteration count
    iteration = iteration+1;
    
    % Simulation time Update
    Current_Time = Simulation_time(iteration-1) + Time_step;
    Simulation_time(1,iteration) = Current_Time;

    % Analysis of the Cell dynamics
    Data_Analysis
    
    % Cured Cells Ratio
    Cured_Cell_Ratio = Ratio_Matrix(2,iteration);
    
    %To check the progress
    if rem(iteration,1e4)==0
        fprintf('Simulation passed %.2f units of time\n', Current_Time);
        fprintf('Computation took %.2f seconds\n', toc);
    end
end
fprintf('Gillespie Algorithm finished in %.2f seconds\n', toc);

%% Remove unneccessary area prelocated in variables
if n > iteration
    Simulation_time(:,iteration+1:n) = [];
    D_Cell_Dynamics_Matrix(:,iteration+1:n) = [];
    R_Cell_Dynamics_Matrix(:,iteration+1:n) = [];
    Ratio_Matrix(:,iteration+1:n) = [];
end
% 
% %%
% figure(1)
% plot(Simulation_time',D_Cell_Dynamics_Matrix')
% D_Cell_legendInfo = {'D', 'DE', 'DE_0'};
% legend(D_Cell_legendInfo)
% Figure_Setup

% %%
figure(2)
plot(Simulation_time',R_Cell_Dynamics_Matrix')
R_Cell_legendInfo = {'R', 'RT_0', 'RE_0T_0','RET_0','RE_0T','RET'};
legend(R_Cell_legendInfo)
Figure_Setup

%%
figure(3)
plot(Simulation_time',Ratio_Matrix')
Ratio_legendInfo = {'Transconjugants','Cured'};
legend(Ratio_legendInfo)
Figure_Setup
