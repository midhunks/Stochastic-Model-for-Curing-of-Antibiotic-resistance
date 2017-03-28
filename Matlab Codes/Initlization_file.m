function Cell = Initlization_file(Type, Num_Cells)
% Type = (1) for Donor cells and (2) for Recipient Cells'        
% Num_Cells = How many cells needs to be created

global Initial Mean_Cell_cycle Cell_cycle_Variability
%% Null check
if Num_Cells == 0
    Cell = [];
    return
end
%% Initial Age of each cell and Cell Cycle of each cell
Age_flag = 1; %0 if all cells starts at zero age or 1 for a random age

%% Initilizing New Cells
%Assigning type, number of plasmids, type of plasmids, age, cycle, and
%generation to each cells
Cell = struct;
for i = 1:Num_Cells
    if Type == 1 % Donors       
        Cell(i).E_Plasmid_Population = poissrnd(Initial.Mean_E_Plasmid_Population,1);
        Cell(i).T_Plasmid_Population = 0;
    elseif Type == 2 % Recipients      
        Cell(i).E_Plasmid_Population = 0;
%         Cell(i).E_Plasmid_Population = poissrnd(Initial.Mean_E_Plasmid_Population,1); % If Initially Target cells have engineered Plasmids
        Cell(i).T_Plasmid_Population = poissrnd(Initial.Mean_E_Plasmid_Population,1);
    else
        error('Check the type of cells needs to be created ')
    end
    
    Cell(i).Type = Type; 
    Cell(i).Cycle = random('normal',Mean_Cell_cycle,Cell_cycle_Variability);
    Cell(i).Clock = Age_flag*rand*Cell(i).Cycle;
    Cell(i).Generation = 1;
end
end
