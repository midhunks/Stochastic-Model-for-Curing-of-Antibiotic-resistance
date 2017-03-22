%% Dynamics of the system 
% Use only if we need to keep the dynamics for analysis other than the 
% Following Anlaysis

% Cell_Dynamics(iteration).Clock=[Cell.Clock];
% Cell_Dynamics(iteration).Cycle=[Cell.Cycle];
% Cell_Dynamics(iteration).E_Plasmid_Population=[Cell.E_Plasmid_Population];
% Cell_Dynamics(iteration).T_Plasmid_Population=[Cell.T_Plasmid_Population];
% Cell_Dynamics(iteration).Generation=[Cell.Generation];
% Cell_Dynamics(iteration).Type={Cell.Type};
% b ={Cell_Dynamics}
% [b1] = padcat(b{:}.E_Plasmid_Population)

%% Vector Assignment for calculation
E = [Cell.E_Plasmid_Population];
T = [Cell.T_Plasmid_Population];
Type = {Cell.Type};

%% Donor Cell Dynamics
D_Index = find(strcmp(Type,'Donor Cells'));
DE_index = find(E(D_Index)~=0);
DE0_index = find(E(D_Index)==0);

D_Cell_Dynamics_Matrix(:,iteration)=[length(D_Index);
                                    length(DE_index);
                                    length(DE0_index)];

%% Recipient Cell dynamics
R_Index = find(strcmp(Type,'Recipient Cells'));
RE_index = find(E(R_Index)~=0);
RE0_index = find(E(R_Index)==0);
RT_index = find(T(R_Index)~=0);
RT0_index = find(T(R_Index)==0);

R_Cell_Dynamics_Matrix(:,iteration)=[length(R_Index);
                                    length(RT0_index);
                                    length(intersect(RE0_index,RT0_index));
                                    length(intersect(RE_index,RT0_index));
                                    length(intersect(RE0_index,RT_index));
                                    length(intersect(RE_index,RT_index))];

Ratio_Matrix(:,iteration) = [
    R_Cell_Dynamics_Matrix(6,iteration)./R_Cell_Dynamics_Matrix(1,iteration);
    R_Cell_Dynamics_Matrix(2,iteration)./R_Cell_Dynamics_Matrix(1,iteration)];