global Initial Mean_Cell_cycle Rates Cell_cycle_Variability

%% Initial number of cells
Initial.D_Cell_Population = 0e2; % Number of Donor cells with Engineered of plasmids
Initial.R_Cell_Population = 1e1; % Number of Target cells with Target plasmids
Initial.Total_Cell_Population = Initial.D_Cell_Population + Initial.R_Cell_Population;

%% Cell cycle
Mean_Cell_cycle = 3.5; % Average cell devision time in hours
Cell_cycle_Variability = 0.1*Mean_Cell_cycle; % 10 percentage of variability in cell cycle

%% Mean Plasmid population in each type of cell
Initial.Mean_E_Plasmid_Population = 1e2; % Mean Plasmid_population in Donor cells
Initial.Mean_T_Plasmid_Population = 1e2; % Mean Plasmid_population in Reciepient cells

%% Event Rates
% Plasmid Replication Rates
Rates.Ktr = 0e2; % Minimum rate should be 1/Mean_Cell_cycle for growth
Stationary_Plasmid_Copynumber = 3e1;% Steady state population of Plasmids
Rates.K = (Stationary_Plasmid_Copynumber/2)/(Mean_Cell_cycle*Rates.Ktr);
Rates.alpha = 1e2; % Inhibition affinity on E Plasmid

% Conjugation Rates
Rates.Conjugation_Donors = 2e-2;%Initial.Total_Cell_Population; % Plasmid Conjugation Rate 1.2*10e-10
Rates.Conjugation_Transconjugants = 2e-3;%Initial.Total_Cell_Population; % Plasmid Conjugation Rate 1.2*10e-10

% Immigration (Birth) of cells rates
Rates.Id = 0;   Rates.Ir = 0;

% Flushing rates
% Rates.Cell_flushing = 1/(2*Mean_Cell_cycle*Initial.Total_Cell_Population); % Cell Death Rate
Rates.G=[1 1e-3 1];
Rates.r = [16e-2 1e-5 7e-1]; % In ODE model, these elements represents rd/Kd rr/Kr rt/Kt respectively
Rates.D_Flushing = [17/16 170/16 170/16]; % In ODE model, these elements represents Bdd,Bdr Bdt
Rates.R_Flushing = [17/16 17/16 17/16]; % In ODE model, these elements represents Brd,Brr Brt
Rates.T_Flushing = [17/16 17/16 17/16]; % In ODE model, these elements represents Btd,Btr Btt

%% Boundary Conditions
Final_Time = 100;%20*Mean_Cell_cycle; % Final Time
Final_Cured_Cell_Ratio = 0.99; % Final Ratio of Cured Cell's population in the system