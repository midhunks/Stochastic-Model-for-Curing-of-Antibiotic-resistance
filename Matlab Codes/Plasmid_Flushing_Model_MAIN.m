%% Plasmid Model
Start_UP % clearing variables and setting defaults

%% Parameters
Parameters_Data % File that handle parameters of the model

%% Preallocation
n=1e6; n_update= n;
PreAllocation_File

%% Initialization
Cell = Initlization_file(Initial); % Setting up the initial system
Initial.Cell = Cell; % Saving Initial Setup
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
    
    % updation of Preallocation size
    if rem(iteration,n_update/10)==0
        prellocation_flag = prellocation_flag + 1;
        
        if prellocation_flag == 10
            n = n + n_update;
            PreAllocation_File            
        end
        fprintf('%.2f%% of cells are cured in %.3f hours (Computational time - %.1f seconds)\n',...
            100*Cured_Cell_Ratio,Current_Time,toc);        
    end
    
    flag_iteration_completed = 1;
end
fprintf('\nSSA finished in %.1f seconds with %d iterations\n', toc, iteration);
fprintf('\nCured: %.2f%% of cells\n Time: %.3f hours\n\n',...
        100*Cured_Cell_Ratio, Current_Time);

%% Remove unneccessary area preallocated in variables
if n > iteration
    if flag_iteration_completed == 0
        iteration = iteration-1;
    end    
    Cell_Dynamics(iteration+1:n)=[];
end

%% Converting the data to cell from struct
Cell_Dynamics ={Cell_Dynamics};

%% Data Analysis and plotting
tic
Data_Analysis

fprintf('Data analysis finished in %.2f seconds\n', toc)

%% Plotting Data
Plotting_File
