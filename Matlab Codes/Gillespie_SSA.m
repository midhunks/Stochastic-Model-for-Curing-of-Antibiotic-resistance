function [Time_step,Cell] = Gillespie_SSA(Propensity_Matrix,Cell)
global Total_Cell_Population

%% Vector Assignment for calculation
E = [Cell.E_Plasmid_Population];
T = [Cell.T_Plasmid_Population];
Clock = [Cell.Clock];
Cycle = [Cell.Cycle];

%% Timestep of the next event
Time_step = log(1/rand)/sum(Propensity_Matrix(:));

%% Choosing event
Clock_Temp = Clock + Time_step; % Temperory updated clock of Cells
Cell_Cycle_Difference = Clock_Temp - Cycle;
Parents_Index = find(Cell_Cycle_Difference >= 0);

if ~isempty(Parents_Index) % Checking if the Clock passed Cell Cycle
    % Finding the timestep for the Cell Division
    [Extra_time,Index]=max(Cell_Cycle_Difference(Parents_Index));
    Time_step = Time_step - Extra_time; % Removing extra time passed
    
    % Cell division event
    Cell = Cell_division(Cell,Parents_Index(Index));
    
    % Updating cell clock (excluding daughter cells) after cell division
    for i=1:Total_Cell_Population-2 %  minus 2 is for the daughter cells
        Cell(i).Clock = Cell(i).Clock + Time_step;
    end
    
else % Choosing event from Immigration, replication, Conjugation and Flushing
    % normalized Cumulative distribution generation
    Propensity_CDF = reshape(cumsum(Propensity_Matrix(:)/sum(Propensity_Matrix(:))),[], size(Propensity_Matrix,2));
    % Identifying event and the cell in which the event occurs
    [Cell_Index,Event_Index] = find(Propensity_CDF >= rand,1);
    
    switch Event_Index % Cell State updation according to event
        case 1 % A new (Type 1)Donor Cell is added to the system
            Type = 1; % Donor Cell 
            New_Cell = Initlization_file(Type,1);
            Total_Cell_Population = Total_Cell_Population + 1;
            Cell(Total_Cell_Population) = New_Cell;
        case 2 % A new (Type 2) Recepient Cell is added to the system
            Type = 2; % Recepient Cell
            New_Cell = Initlization_file(Type,1);
            Total_Cell_Population = Total_Cell_Population + 1;
            Cell(Total_Cell_Population) = New_Cell;
        case 3 % Engineered Plasmid Replication occurs
            Cell(Cell_Index).E_Plasmid_Population = E(Cell_Index)+1;
        case 4 % Target Plasmid Repllication occurs
            Cell(Cell_Index).T_Plasmid_Population = T(Cell_Index)+1;
        case 5 % Plasmid Conjugation occurs
            Cell(Cell_Index).E_Plasmid_Population = 1;
        otherwise % Cell flushes out
            Cell(Cell_Index) = [];
            Total_Cell_Population = Total_Cell_Population - 1;
    end
    
    % Updating cell clock after an event occurs
    for i=1:Total_Cell_Population
        Cell(i).Clock = Cell(i).Clock + Time_step;
    end
end