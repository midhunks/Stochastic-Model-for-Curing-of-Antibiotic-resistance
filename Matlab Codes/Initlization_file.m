function Cell = Initlization_file(Initial)
global Mean_Cell_cycle Cell_cycle_Variability

%% Initial Age of each cell and Cell Cycle of each cell
Age_flag = 1; %0 if all cells starts at zero age or 1 for a random age
% Initial_Cell_Cycle = Mean_Cell_cycle + random('uniform',-1,1,Initial.Total_Cell_Population,1)*Cell_cycle_Variability;
Initial_Cell_Cycle = random('normal',Mean_Cell_cycle,Cell_cycle_Variability,Initial.Total_Cell_Population,1);
Initial_Cell_Clock = Age_flag*rand(Initial.Total_Cell_Population,1).*Initial_Cell_Cycle;

%% Initial Plasmid population in Donor and Recipient cells
%setting up the initial plasmid population in each type of cells
E_Plasmid_population = poissrnd(Initial.Mean_E_Plasmid_Population,Initial.Total_Cell_Population,1);
T_Plasmid_population = poissrnd(Initial.Mean_E_Plasmid_Population,Initial.Total_Cell_Population,1);

%% Creating Initial Cell Structure
%Assigning type, number of plasmids, type of plasmids, age, cycle, and
%generation to each cells

Cell = struct;
for i = 1:Initial.Total_Cell_Population
    if i <= Initial.D_Cell_Population
        Cell(i).Type = 'Donor Cells';
        Cell(i).E_Plasmid_Population = E_Plasmid_population(i);
        Cell(i).T_Plasmid_Population = 0; 
        % Cell(i).T_Plasmid_Population = Initial_T_Plasmid_population(i); % If Initially Donor Cells have some Target Plasmids
    else
        Cell(i).Type = 'Recipient Cells';
        Cell(i).E_Plasmid_Population = 0;
        % Cell(i).E_Plasmid_Population =Initial_E_Plasmid_population(i); % If Initially Target Cells have some Enginneered Plasmids
        Cell(i).T_Plasmid_Population = T_Plasmid_population(i);
    end
    
    Cell(i).Clock = Initial_Cell_Clock(i);
    Cell(i).Cycle = Initial_Cell_Cycle(i);
    Cell(i).Generation = 1;
end
end
