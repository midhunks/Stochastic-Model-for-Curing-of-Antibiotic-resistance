function Cell = Cell_division(Cell,Index,Time_step)
global Mean_Cell_cycle Cell_cycle_Variability Total_Cell_Population

%% Parent Cell
Cell_temp=Cell(Index);
%% Removal of parent cell and adding two daughter cells
Cell(Index)=[]; % Removal of Parent Cell
Daughter_index = (Total_Cell_Population-1) +[1 2];%Index of Daughter Cells
Total_Cell_Population = Total_Cell_Population + 1; 

%% Plasmid selection in Daughter cells
E_pop=Cell_temp.E_Plasmid_Population;
T_pop=Cell_temp.T_Plasmid_Population;

E_Plasmid_1=binornd(E_pop,0.5);
E_Plasmid_2=E_pop - E_Plasmid_1;

T_Plasmid_1=binornd(T_pop,0.5);
T_Plasmid_2=T_pop - T_Plasmid_1;

% Seperating Engineered and Target Plasmids in daugher Cells
Cell(Daughter_index(1)).E_Plasmid_Population = E_Plasmid_1;
Cell(Daughter_index(1)).T_Plasmid_Population = T_Plasmid_1;
Cell(Daughter_index(2)).E_Plasmid_Population = E_Plasmid_2;
Cell(Daughter_index(2)).T_Plasmid_Population = T_Plasmid_2;

%% Updating Daughter Cell's Generation
Cell(Daughter_index(1)).Generation = Cell_temp.Generation+1;
Cell(Daughter_index(2)).Generation = Cell_temp.Generation+1;

%% Cell Type of Daughter cells
Cell(Daughter_index(1)).Type = Cell_temp.Type;
Cell(Daughter_index(2)).Type = Cell_temp.Type;

%% Setting Cell Cycle and age of Daughter cells
Cell(Daughter_index(1)).Cycle = random('normal',Mean_Cell_cycle,Cell_cycle_Variability);%Mean_Cell_cycle + random('uniform',-1,1)*Cell_cycle_Variability;
Cell(Daughter_index(2)).Cycle = random('normal',Mean_Cell_cycle,Cell_cycle_Variability);%Mean_Cell_cycle + random('uniform',-1,1)*Cell_cycle_Variability;

%% Reseting Clock of Daughter Cells
Cell(Daughter_index(1)).Clock=0;
Cell(Daughter_index(2)).Clock=0;

end