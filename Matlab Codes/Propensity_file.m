function Propensity_Matrix = Propensity_file(Cell)
global Rates Total_Cell_Population
%% Vector Assignment for calculation
E = [Cell.E_Plasmid_Population];
T = [Cell.T_Plasmid_Population];
Clock = [Cell.Clock];
Type = {Cell.Type};

%% Identifying donors 
% Both Donor and Transconjugant cells are capable for Engineered Plasmid conjuation
D_Cells_Index = find(E ~= 0 & strcmp(Type,'Donor Cells'));
T_Cells_Index = find(E ~= 0 & strcmp(Type,'Recipient Cells')); % Includes cured cells

%% Identifying recepients
R_Cells_Index = find(E == 0 & strcmp(Type,'Recipient Cells'));

%% Length vector for calculation (Keep the order in D R T)
L = [length(D_Cells_Index); length(R_Cells_Index); length(T_Cells_Index)];

%% Propensity of Immigration (or Birth) of Cells
Propensity_Immigration_D = zeros(1,Total_Cell_Population);
Propensity_Immigration_R = zeros(1,Total_Cell_Population);
Propensity_Immigration_D(end) = Rates.Id; %Not for each cells but for the entire system
Propensity_Immigration_R(end) = Rates.Ir; %Not for each cells but for the entire system

%% Propensity of Plsamid Replication
Propensity_E_Plasmid_Replication = E.*Plasmid_Rep_Propensity(E,Clock);
Propensity_T_Plasmid_Replication = T.*Plasmid_Rep_Propensity((Rates.alpha*E+T),Clock);

%% Propensity of Plasmid Conjugation
Propensity_Conjugation = zeros(1,Total_Cell_Population);
Propensity_Conjugation(R_Cells_Index) = (Rates.Conjugation_Donors*L(1)...
                                      + Rates.Conjugation_Transconjugants*L(3));
                                    
%% Propensity of Cell Death
Propensity_Cell_Death = zeros(1,Total_Cell_Population);
Propensity_Cell_Death(D_Cells_Index) = Rates.F(1)*(Rates.D_Flushing*L);
Propensity_Cell_Death(R_Cells_Index) = Rates.F(2)*(Rates.R_Flushing*L);
Propensity_Cell_Death(T_Cells_Index) = Rates.F(3)*(Rates.T_Flushing*L);

%% Propensity matrix Generation
Propensity_Matrix = [Propensity_Immigration_D;
                    Propensity_Immigration_R;
                    Propensity_E_Plasmid_Replication;
                    Propensity_T_Plasmid_Replication;
                    Propensity_Conjugation;
                    Propensity_Cell_Death]';
end