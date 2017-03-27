%% Time
Time = [Cell_Dynamics{:}.Time];
%%
h(1)=figure(1);
plot(Time',Cell_Dynamics_Matrix')
Legend = legend(Cell_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup

Folder = ['C:\Users\mkathana\Dropbox\Study\UWaterloo\Brian\MATLAB codes'...
    '\plasmid dynamics\Midhun\Stochastic-Model-for-Curing-of-Antibiotic-resistance'...
    '\Matlab Codes\Outputs\'];
FileName=['Cell_Dynamics ',datestr(now,'dd-mmm-yyyy HH-MM-SS AM')];

saveas(gcf,[Folder,FileName,'.png']);
saveas(gcf,[Folder,FileName,'.eps']);

h(2)=figure(2);
plot(Time',Ratio_Matrix')
Legend = legend(Ratio_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup

FileName=['Cell_Dynamics (Ratio) ',datestr(now,'dd-mmm-yyyy HH-MM-SS AM')];
saveas(gcf,[Folder,FileName,'.png']);
saveas(gcf,[Folder,FileName,'.eps']);

% Saving figure
FileName=['Cell_Dynamics ',datestr(now,'dd-mmm-yyyy HH-MM-SS AM')];
savefig(h,[Folder,FileName,'.fig']);
