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
T_Cells_Index = find(E ~= 0 & strcmp(Type,'Recipient Cells'));

%% Identifying recepients
R_Cells_Index = find(E == 0 & strcmp(Type,'Recipient Cells'));

%% Propensity of Immigration (or Birth) of Cells
Propensity_Immigration_D = Rates.Id*ones(1,Total_Cell_Population);
Propensity_Immigration_R = Rates.Ir*ones(1,Total_Cell_Population);

%% Propensity of Plsamid Replication
Propensity_E_Plasmid_Replication = E.*Plasmid_Rep_Propensity(E,Clock);
Propensity_T_Plasmid_Replication = T.*Plasmid_Rep_Propensity((Rates.alpha*E+T),Clock);

%% Propensity of Conjugation
Propensity_Conjugation = zeros(1,Total_Cell_Population);
Propensity_Conjugation(R_Cells_Index) = (Rates.Conjugation_Donors*length(D_Cells_Index)...
                                      + Rates.Conjugation_Transconjugants*length(T_Cells_Index))*length(R_Cells_Index);
                                    
%% Propensity of Flushing
L = [length(D_Cells_Index); length(R_Cells_Index); length(T_Cells_Index)];

Propensity_Cell_Flushing = zeros(1,Total_Cell_Population);
Propensity_Cell_Flushing(D_Cells_Index) = Rates.G(1)*L(1)+Rates.r(1)*L(1)*(Rates.D_Flushing*L);
Propensity_Cell_Flushing(R_Cells_Index) = Rates.G(2)*L(2)+Rates.r(2)*L(2)*(Rates.R_Flushing*L);
Propensity_Cell_Flushing(T_Cells_Index) = Rates.G(3)*L(3)+Rates.r(3)*L(3)*(Rates.T_Flushing*L);

%% Propensity matrix Generation
Propensity_Matrix = [Propensity_Immigration_D;
                    Propensity_Immigration_R;
                    Propensity_E_Plasmid_Replication;
                    Propensity_T_Plasmid_Replication;
                    Propensity_Conjugation;
                    Propensity_Cell_Flushing]';
end