function [Time_step,Cell] = Gillespie_SSA(Propensity_Matrix,Cell)
global Total_Cell_Population

%% Vector Assignment for calculation
E = [Cell.E_Plasmid_Population];
T = [Cell.T_Plasmid_Population];
Clock = [Cell.Clock];
Cycle = [Cell.Cycle];

%% Timestep of the next event
Time_step = log(1/rand)/sum(Propensity_Matrix(:));

%% (Flushing) Checking if the Clock passed Cell Cycle
Clock_Temp = Clock + Time_step; % Updated clock of Cells
Cell_Cycle_Difference = Clock_Temp - Cycle;
Parents_Index = find(Cell_Cycle_Difference >= 0);

if ~isempty(Parents_Index) % Choosing Cell division event
    % Finding the timestep for the Cell Division
    [Extra_time,Index]=max(Cell_Cycle_Difference(Parents_Index));
    Time_step = Time_step - Extra_time; % Removing extra time passed
    
    Cell = Cell_division(Cell,Parents_Index(Index),Time_step);
    
     %% Updating cell clock after cell division (excluding daughter cells)
    for i=1:Total_Cell_Population-2 %  minus 2 is for the daughter cells
        Cell(i).Clock = Cell(i).Clock + Time_step;
    end
    
    %     return % Exiting from the function after cell division event
    % end
    
else    
    %% Updating cell clock assuming one from following event occurs
    for i=1:Total_Cell_Population
        Cell(i).Clock = Cell(i).Clock + Time_step;
    end
    
    %% Choosing event from Immigration, replication, Conjugation and Flushing
    % normalized Cumulative distribution generation
    Propensity_CDF = reshape(cumsum(Propensity_Matrix(:)/sum(Propensity_Matrix(:))),[], size(Propensity_Matrix,2));
    % Identifying event and the cell in which the event occurs
    [Cell_Index,Event_Index] = find(Propensity_CDF >= rand,1);
    
    switch Event_Index % Cell State updation according to event
        case 1 % A new Donor Cell is added to the system
            New_Cell = Immigration_Process('Donor Cells');
            Total_Cell_Population = Total_Cell_Population + 1;
            Cell(Total_Cell_Population) = New_Cell;
        case 2 % A new Recepient Cell is added to the system
            New_Cell = Immigration_Process('Recipient Cells');
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
end