%% Vector Assignment for calculation
Dynamics ={Cell_Dynamics};
E = padcat(Dynamics{:}.E_Plasmid_Population);
T = padcat(Dynamics{:}.T_Plasmid_Population);
Type = padcat(Dynamics{:}.Type);

%% Identify position of different type of plasmids
E_Index = find(E~=0);
E0_Index = find(E==0);
T_Index = find(T~=0);
T0_Index = find(T==0);

%% Donor Cell Dynamics
[m,n]=size(Type);

D = (Type == 1);
D_Index = find(D)';
N_D = sum(D,2);

DE=sparse(m,n);
DE_Index = intersect(D_Index,E_Index);
DE(DE_Index)=1;
N_DE = sum(DE,2);

DE0=sparse(m,n);
DE0_Index = intersect(D_Index,E0_Index);
DE0(DE0_Index)=1;
N_DE0 = sum(DE0,2);

D_Cell_Dynamics_Matrix=[N_D N_DE N_DE0];
D_Cell_legendInfo = {'D', 'DE', 'DE_0'};

%% Recipient Cell dynamics
R = (Type == 2);
R_Index = find(R)';
N_R = sum(D,2);

RE=sparse(m,n);
RE_Index = intersect(R_Index,E_Index);
RE(RE_Index)=1;
N_RE = sum(RE,2);

RE0=sparse(m,n);
RE0_Index = intersect(R_Index,E0_Index);
RE0(RE0_Index)=1;
N_RE0 = sum(RE0,2);

RT=sparse(m,n);
RT_Index = intersect(R_Index,T_Index);
RT(RT_Index)=1;
N_RT = sum(RT,2);

RT0=sparse(m,n);
RT0_Index = intersect(R_Index,T0_Index);
RT0(RT0_Index)=1;
N_RT0 = sum(RT0,2);

RET=sparse(m,n);
RET_Index = intersect(RE_Index,T_Index);
RET(RET_Index)=1;
N_RET = sum(RET,2);

RET0=sparse(m,n);
RET0_Index = intersect(RE_Index,T0_Index);
RET0(RET0_Index)=1;
N_RET0 = sum(RET0,2);

RE0T=sparse(m,n);
RE0T_Index = intersect(RE0_Index,T_Index);
RE0T(RE0T_Index )=1;
N_RE0T = sum(RE0T,2);

RE0T0=sparse(m,n);
RE0T0_Index = intersect(RE0_Index,T0_Index);
RE0T0(RE0T0_Index)=1;
N_RE0T0 = sum(RE0T0,2);


R_Cell_Dynamics_Matrix=[N_R, N_RT0, N_RT, N_RET, N_RE0T, N_RE0, N_RE, N_RET0,N_RE0T0];
R_Cell_legendInfo = {'R','RT_0','RT','RET','RE_0T','RE_0','RE','RET_0','RE_0T_0'};

%%
Ratio_Matrix = [R_Cell_Dynamics_Matrix(:,2)./R_Cell_Dynamics_Matrix(:,1),...
                R_Cell_Dynamics_Matrix(:,4)./R_Cell_Dynamics_Matrix(:,1),...
                R_Cell_Dynamics_Matrix(:,3)./R_Cell_Dynamics_Matrix(:,1)];
Ratio_legendInfo = {'Cured','Transconjugants','Recipients'};

%%
figure(1)
plot([Cell_Dynamics.Time]',D_Cell_Dynamics_Matrix')
Legend = legend(D_Cell_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup

%%
figure(2)
plot([Cell_Dynamics.Time]',R_Cell_Dynamics_Matrix')
Legend = legend(R_Cell_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup

%%
figure(3)
plot([Cell_Dynamics.Time]',Ratio_Matrix')
Legend = legend(Ratio_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup
