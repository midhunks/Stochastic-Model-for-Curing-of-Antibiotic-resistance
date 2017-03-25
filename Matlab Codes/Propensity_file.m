function Propensity_Matrix = Propensity_file(Cell)
global Rates Total_Cell_Population
%% Vector Assignment for calculation
E = [Cell.E_Plasmid_Population];
T = [Cell.T_Plasmid_Population];
Clock = [Cell.Clock];
Type = [Cell.Type];%{Cell.Type}

%% Identifying donors 
% Both Donor and Transconjugant cells are capable for Engineered Plasmid conjuation
D_Cells_Index = find(E ~= 0 & Type == 1);% strcmp(Type,'Donor Cells'));
T_Cells_Index = find(E ~= 0 & Type == 2);%strcmp(Type,'Recipient Cells')); % Includes cured cells

N_D = length(D_Cells_Index);
N_T = length(T_Cells_Index);

%% Identifying recepients
R_Cells_Index = find(E == 0 & Type == 2);%strcmp(Type,'Recipient Cells'));
N_R = length(R_Cells_Index);

%% Propensity of Immigration (or Birth) of Cells
Propensity_Immigration_D = zeros(1,Total_Cell_Population);
Propensity_Immigration_R = zeros(1,Total_Cell_Population);
Propensity_Immigration_D(end) = Rates.Immigation(1);%/(1+L(1)); %Not for each cells but for the entire system
Propensity_Immigration_R(end) = Rates.Immigation(2); %Not for each cells but for the entire system

%% Propensity of Plsamid Replication
Propensity_E_Plasmid_Replication = E.*Plasmid_Rep_Propensity(E,Clock);
Propensity_T_Plasmid_Replication = T.*Plasmid_Rep_Propensity((Rates.alpha*E+T),Clock);

%% Propensity of Plasmid Conjugation
Propensity_Conjugation = zeros(1,Total_Cell_Population);
Propensity_Conjugation(R_Cells_Index) = (Rates.Conjugation_Donors*N_D...
                                      + Rates.Conjugation_Transconjugants*N_T);

%% Propensity of Cell Death
N = [N_D;N_R+N_T];
Propensity_Cell_Death = zeros(1,Total_Cell_Population);
Propensity_Cell_Death(D_Cells_Index) = Rates.F(1)*(Rates.D_Flushing*N);
Propensity_Cell_Death(R_Cells_Index) = Rates.F(2)*(Rates.R_Flushing*N);
Propensity_Cell_Death(T_Cells_Index) = Rates.F(3)*(Rates.R_Flushing*N);

%% Propensity matrix Generation
Propensity_Matrix = [Propensity_Immigration_D;
                    Propensity_Immigration_R;
                    Propensity_E_Plasmid_Replication;
                    Propensity_T_Plasmid_Replication;
                    Propensity_Conjugation;
                    Propensity_Cell_Death]';
end