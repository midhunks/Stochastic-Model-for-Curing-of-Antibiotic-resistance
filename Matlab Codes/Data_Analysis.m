%% Vector Assignment for calculation
tic
Dynamics ={Cell_Dynamics};
E = padcat(Dynamics{:}.E_Plasmid_Population);
T = padcat(Dynamics{:}.T_Plasmid_Population);
Type = padcat(Dynamics{:}.Type);
Time = [Dynamics{:}.Time];
[m,n]=size(Type);

clear Dynamics Cell_Dynamics
toc
%%
tic
E0_Index = (find(E==0));
E_Index = (find(E~=0));
T0_Index = (find(T==0));
T_Index = (find(T~=0));

D = (Type == 1);
R = (Type == 2);
D_Index = find(D);
R_Index = find(R);

clear Type E T
toc
%%
Legend_Count = 0;
Cell_Dynamics_Matrix = [];

%% Donor Cell Dynamics
tic
N_D = sum(D,2);
Cell_Dynamics_Matrix = [Cell_Dynamics_Matrix N_D];
Legend_Count = Legend_Count + 1;
Cell_legendInfo{Legend_Count} = 'D';
clear D N_D
toc
%%
tic
DE=zeros(m,n);
DE_Index = intersect(D_Index,E_Index);
DE(DE_Index)=1;
N_DE = sum(DE,2);

Cell_Dynamics_Matrix = [Cell_Dynamics_Matrix N_DE];

Legend_Count = Legend_Count + 1;
Cell_legendInfo{Legend_Count} = 'DE';
clear DE N_DE
toc
%%
tic
DE0=zeros(m,n);
DE0_Index = intersect(D_Index,E0_Index);
DE0(DE0_Index)=1;
N_DE0 = sum(DE0,2);

Cell_Dynamics_Matrix = [Cell_Dynamics_Matrix N_DE0];
Legend_Count = Legend_Count + 1;
Cell_legendInfo{Legend_Count} = 'DE_0';
clear DE0 N_DE0
toc

%% Recipient Cell dynamics
tic
N_R = sum(R,2);

Cell_Dynamics_Matrix = [Cell_Dynamics_Matrix N_R];
Legend_Count = Legend_Count + 1;
Cell_legendInfo{Legend_Count} = 'R';

Total_R_index = Legend_Count;
clear R N_R
toc
%%
% tic
% RE=zeros(m,n);
% RE_Index = intersect(R_Index,E_Index);
% RE(RE_Index)=1;
% N_RE = sum(RE,2);
% 
% R_Cell_Dynamics_Matrix = [R_Cell_Dynamics_Matrix N_RE];
% 
% Legend_Count = Legend_Count + 1;
% R_Cell_legendInfo{Legend_Count} = 'RE';
% 
% clear RE N_RE
% toc
%%
% tic
% RE0=zeros(m,n);
% RE0_Index = intersect(R_Index,E0_Index);
% RE0(RE0_Index)=1;
% N_RE0 = sum(RE0,2);
% 
% R_Cell_Dynamics_Matrix = [R_Cell_Dynamics_Matrix N_RE0];
% 
% Legend_Count = Legend_Count + 1;
% R_Cell_legendInfo{Legend_Count} = 'RE_0';
% 
% clear RE0 N_RE0
% toc
%%
tic
RT=zeros(m,n);
RT_Index = intersect(R_Index,T_Index);
RT(RT_Index)=1;
N_RT = sum(RT,2);

Cell_Dynamics_Matrix = [Cell_Dynamics_Matrix N_RT];
Legend_Count = Legend_Count + 1;
Cell_legendInfo{Legend_Count} = 'RT';

clear RT N_RT
toc
%%
tic
RT0=zeros(m,n);
RT0_Index = intersect(R_Index,T0_Index);
RT0(RT0_Index)=1;
N_RT0 = sum(RT0,2);

Cell_Dynamics_Matrix = [Cell_Dynamics_Matrix N_RT0];

Legend_Count = Legend_Count + 1;
Cell_legendInfo{Legend_Count} = 'RT_0';

Cured_index = Legend_Count;

clear RT0 N_RT0

toc
%%
tic
RET=zeros(m,n);
RET_Index = intersect(RT_Index,E_Index);
RET(RET_Index)=1;
N_RET = sum(RET,2);

Cell_Dynamics_Matrix = [Cell_Dynamics_Matrix N_RET];

Legend_Count = Legend_Count + 1;
Cell_legendInfo{Legend_Count} = 'RET';

Transconjugant_index = Legend_Count;

clear RET N_RET
toc
%%
% tic
% RET0=zeros(m,n);
% RET0_Index = intersect(RE_Index,T0_Index);
% RET0(RET0_Index)=1;
% N_RET0 = sum(RET0,2);
% 
% R_Cell_Dynamics_Matrix = [R_Cell_Dynamics_Matrix N_RET0];
% 
% Legend_Count = Legend_Count + 1;
% R_Cell_legendInfo{Legend_Count} = 'RET_0';
% 
% clear RET0 N_RET0
% toc
%%
% tic
% RE0T=zeros(m,n);
% RE0T_Index = intersect(RE0_Index,T_Index);
% RE0T(RE0T_Index )=1;
% N_RE0T = sum(RE0T,2);
% 
% R_Cell_Dynamics_Matrix = [R_Cell_Dynamics_Matrix N_RE0T];
% 
% Legend_Count = Legend_Count + 1;
% R_Cell_legendInfo{Legend_Count} = 'RE_0T';
% 
% clear RE0T N_RE0T
% toc
%%
% tic
% RE0T0=zeros(m,n);
% RE0T0_Index = intersect(RE0_Index,T0_Index);
% RE0T0(RE0T0_Index)=1;
% N_RE0T0 = sum(RE0T0,2);
% 
% R_Cell_Dynamics_Matrix = [R_Cell_Dynamics_Matrix N_RE0T0];
% 
% Legend_Count = Legend_Count + 1;
% R_Cell_legendInfo{Legend_Count} = 'RE_0T_0';
% 
% clear RE0T0 N_RE0T0
% toc

%%
tic
Ratio_Matrix = [Cell_Dynamics_Matrix(:,Cured_index)./Cell_Dynamics_Matrix(:,Total_R_index),...
                Cell_Dynamics_Matrix(:,Transconjugant_index)./Cell_Dynamics_Matrix(:,Total_R_index)];                
Ratio_legendInfo = {'Cured','Transconjugants'};
toc

%%
h(1)=figure(1);
plot(Time',Cell_Dynamics_Matrix')
Legend = legend(Cell_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup

%%
h(2)=figure(2);
plot(Time',Ratio_Matrix')
Legend = legend(Ratio_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup

FileName=['Cell_Dynamics ',datestr(now,'dd-mmm-yyyy HH-MM-SS AM'),'.fig']
% FileName=['Cell Dynamics ',datestr(now, 0),'.fig']
savefig(h,FileName)

