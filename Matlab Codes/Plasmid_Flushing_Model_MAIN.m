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
Cell_Dynamics(n).E_Plasmid_Population = struct;
Cell_Dynamics(n).T_Plasmid_Population = struct;
Cell_Dynamics(n).Type = struct;
Cell_Dynamics(n).Time = struct;

%% System Dynamics
tic;    iteration = 1;   Current_Time = 0;    Cured_Cell_Ratio = 0;

% Storing Initial data of the System
Data_Storing

while Cured_Cell_Ratio < Final_Cured_Cell_Ratio %&& Current_Time < Final_Time
    flag_iteration_completed = 0;
    
    % Propensity Calculation
    Propensity_Matrix = Propensity_file(Cell);
    
    % Identifying next state of the Cell and timestep
    [Time_step,Cell] = Gillespie_SSA(Propensity_Matrix,Cell);
    
    % Updating iteration count
    iteration = iteration+1;
    
    % Simulation time Update
    Previous_time = Current_Time;
    Current_Time = Previous_time + Time_step;
    
    % Saving the data of Cell dynamics
    Data_Storing
    
    % Cured Cells Ratio
    R_Index = find(Type == 2);% Recipients
    RT0_index = find(T(R_Index)==0); % Recipients with no Antibiotic-Resistant Plasmids
    Cured_Cell_Ratio = length(RT0_index)/length(R_Index);
    
    %To check the progress
    if rem(iteration,1e1)==0        
        pause
        fprintf('Computation took %.2f seconds\n', toc);
        fprintf('%.2f percentage of cells are cured in %.2f units of time\n',100*Cured_Cell_Ratio,Current_Time);
    end
    flag_iteration_completed = 1;
end
fprintf('\n\n Gillespie Algorithm finished in %.2f seconds with %d iterations\n\n', toc,iteration);

%% Remove unneccessary area prelocated in variables
if n > iteration
    if flag_iteration_completed == 0
        iteration = iteration-1;
    end    
    Cell_Dynamics(iteration+1:n)=[];
end

%% Data Analysis and plotting
Data_Analysis

%% View Time of functions
profile viewer
