%% Plasmid Model
if ispc, b='\'; else, b='/'; end % defining forward/bckward slashes
addpath([pwd,b,'Generalized_Functions',b]);

Start_UP % clearing variables and setting defaults

%% Parameters
Parameters_Data % File that handle parameters of the model

%% Preallocation
n=1e6; n_update= n;
PreAllocation_File

%% Initialization of donor cells and recipient cells
Donor_Cell = Initlization_file(1,Initial.D_Cell_Population); 
Recipient_Cell = Initlization_file(2,Initial.R_Cell_Population);

Cell = [Donor_Cell , Recipient_Cell];
clear Donor_Cell Recipient_Cell

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
        fprintf('Cured             : %.2f%% of cells\n',100*Cured_Cell_Ratio);
        fprintf('Current Time      : %.3f hours\n',Current_Time);
        fprintf('Computation time  : %.1f seconds\n',toc);  
        fprintf('Iterations        : %.d\n\n\n',iteration);
    end
    
    flag_iteration_completed = flag_iteration_completed + 1;
end

fprintf('\nSSA finished\n')
fprintf('Cured             : %.2f%% of cells\n',100*Cured_Cell_Ratio);
fprintf('Final Time        : %.3f hours\n',Current_Time);
fprintf('Computation time  : %.1f seconds\n',toc);
fprintf('Iterations        : %.d\n',iteration);

%% Remove unneccessary area preallocated in variables
if n > iteration
    if flag_iteration_completed == 0
        iteration = iteration-1;
    end    
    Cell_Dynamics(iteration+1:n)=[];
end

%% Converting the data to cell from struct for data anaysis
Cell_Dynamics ={Cell_Dynamics};

%% Data Analysis and plotting
tic
Data_Analysis

fprintf('Data analysis finished in %.2f seconds\n', toc)

%% Plotting Data
Plotting_File
