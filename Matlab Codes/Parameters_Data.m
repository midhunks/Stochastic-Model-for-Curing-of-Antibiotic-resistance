global Initial Mean_Cell_cycle Rates Cell_cycle_Variability Total_Cell_Population
%% Initial number of cells
Initial.D_Cell_Population = 0e2; % Number of Donor cells with Engineered of plasmids
Initial.R_Cell_Population = 1e2; % Number of Target cells with Target plasmids
Initial.Total_Cell_Population = Initial.D_Cell_Population + Initial.R_Cell_Population;
Total_Cell_Population = Initial.Total_Cell_Population;

%% Mean Plasmid population in each type of cell
Initial.Mean_E_Plasmid_Population = 1e2; % Mean Plasmid_population in Donor cells
Initial.Mean_T_Plasmid_Population = 1e2; % Mean Plasmid_population in Reciepient cells

%% Event Rates

% Plasmid Replication Rates
Stationary_Plasmid_Copynumber = 1e2;% Steady state population of Plasmids
Rates.Ktr = 1.2e2; % Minimum rate should be 1/Mean_Cell_cycle for growth
% Rates.K = (Stationary_Plasmid_Copynumber/2)/(Mean_Cell_cycle*Rates.Ktr);
Rates.K = 1e-3*Rates.Ktr;
Rates.alpha = 1e-2*Rates.Ktr; % Inhibition affinity on E Plasmid

% Cell cycle
Mean_Cell_cycle = 4.3;%Stationary_Plasmid_Copynumber/(2*Rates.K*Rates.Ktr)%4.3; % Average cell devision time in hours
Cell_cycle_Variability = 0.1*Mean_Cell_cycle; % 10 percentage of variability in cell cycle
Initial.Mean_CellCycle = Mean_Cell_cycle;

Expected_Num_Gen_for_Curing = 40
Expected_Time_for_Curing = Expected_Num_Gen_for_Curing * Mean_Cell_cycle

% Conjugation Rates
Rates.Conjugation_Donors = 4e-2;%Initial.Total_Cell_Population; % Plasmid Conjugation Rate 1.2*10e-10
Rates.Conjugation_Transconjugants = 5e-1*Rates.Conjugation_Donors;%Initial.Total_Cell_Population; % Plasmid Conjugation Rate 1.2*10e-10

% Immigration (Birth) of cells rates
Rates.Immigation = [4e-1; 0];

% Flushing rates
% Rates.Cell_flushing = 1/(2*Mean_Cell_cycle*Initial.Total_Cell_Population); % Cell Death Rate
Rates.F = 1e-2*[16 12 16]; % In ODE model, these elements represents rd/Kd rr/Kr rt/Kt respectively (subindex d for donors, r for Recipient, and t for transconjugants)
Rates.D_Flushing = 1/(1+Initial.Total_Cell_Population)*[ 1 1]; % In ODE model, these elements represents Bdd,Bdr Bdt
Rates.R_Flushing = 1/(1+Initial.Total_Cell_Population)*[.5 1]; % In ODE model, these elements represents Brd,Brr Brt

Initial.Rate = Rates;

%% Boundary Conditions
Final_Time = 1000;%20*Mean_Cell_cycle; % Final Time
Final_Cured_Cell_Ratio = 0.99; % Final Ratio of Cured Cell's population in the system

%% Saving Data

FileName = ['C:\Users\mkathana\Dropbox\Study\UWaterloo\Brian\MATLAB codes'...
    '\plasmid dynamics\Midhun\0.Plasmid_conjugation\Flushing Model'...
    '\Stochastic-Model-for-Curing-of-Antibiotic-resistance\Matlab Codes'...
    '\Outputs\Inital Data ',datestr(now,'dd-mmm-yyyy HH-MM-SS AM'),'.mat'];

latency={Initial};
save(FileName, 'latency');

