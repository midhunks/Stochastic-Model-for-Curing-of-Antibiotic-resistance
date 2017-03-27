%% Vector Assignment for calculation
E = padcat(Cell_Dynamics{:}.E_Plasmid_Population);
T = padcat(Cell_Dynamics{:}.T_Plasmid_Population);
Type = padcat(Cell_Dynamics{:}.Type);

%% Logical matrices creation
E_mat= E ~=0;
E0_mat= E ==0;
T_mat= T ~=0;
T0_mat= T ==0;
D_mat = Type == 1;
R_mat = Type == 2;

clear E T Type 
%% Identifying the number of occurances in each case
% N_D = sum(D_mat,2);
N_DE = Logical_Intersect(cat(3,D_mat,E_mat));
% N_DE0 = Logical_Intersect(cat(3,D_mat,E_mat));

N_R = sum(R_mat,2);
% N_RE = Logical_Intersect(cat(3,R_mat,E_mat));
% N_RE0 = Logical_Intersect(cat(3,R_mat,E0_mat));
% N_RT = Logical_Intersect(cat(3,R_mat,T_mat));
N_RT0 = Logical_Intersect(cat(3,R_mat,T0_mat));
N_RET = Logical_Intersect(cat(3,R_mat,E_mat,T_mat));
% N_RET0 = Logical_Intersect(cat(3,R_mat,E_mat,T0_mat));
N_RE0T = Logical_Intersect(cat(3,R_mat,E0_mat,T_mat));
% N_RE0T0 = Logical_Intersect(cat(3,R_mat,E0_mat,T0_mat));

clear E_mat E0_mat T_mat T0_mat D_mat R_mat

Cell_Dynamics_Matrix = [
%                         N_D';
                        N_DE';
                        N_RE0T';
%                         N_DE0';
%                         N_R';
%                         N_RE';
%                         N_RE0';
%                         N_RT';
                        N_RET';
                        N_RT0';
%                         N_RET0';
%                         N_RE0T0';
                        ]';
clear  N_D N_DE N_RE0T N_DE0 N_RE N_RE0 N_RT N_RET0 N_RE0T0

Cell_legendInfo = { 
%                     'D';
                    'Donors with E';
                    'Recipients with no E';
%                     'DE_0';
%                     'Recipients';
%                     'RE';
%                     'RE_0';
%                     'RT';
                    'Transconjugants';
                    'Cured';
%                     'RET_0';
%                     'RE_0T_0';
                    };

%%

Ratio_Matrix = [N_RET./N_R,N_RT0./N_R];
Ratio_legendInfo = {'Transconjugants','Cured'};

clear N_RET N_RT0 N_R

