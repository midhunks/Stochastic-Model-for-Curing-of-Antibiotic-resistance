function New_Cell = Immigration_Process(Type)
global Initial Mean_Cell_cycle Cell_cycle_Variability
New_Cell.Type = Type;
if strcmp(Type,'Donor Cells')
    New_Cell.E_Plasmid_Population = poissrnd(Initial.Mean_E_Plasmid_Population,1);
    New_Cell.T_Plasmid_Population = 0;    
else
    New_Cell.E_Plasmid_Population = 0; % If Initially Target Cells have no enginneered Plasmids
    New_Cell.T_Plasmid_Population = poissrnd(Initial.Mean_E_Plasmid_Population,1);
end

Initial_Cell_Cycle = random('normal',Mean_Cell_cycle,Cell_cycle_Variability);
New_Cell.Cycle = Initial_Cell_Cycle;

Age_flag = 1;
Initial_Cell_Clock = Age_flag*rand*Initial_Cell_Cycle;
New_Cell.Clock = Initial_Cell_Clock;

New_Cell.Generation = 1;
end