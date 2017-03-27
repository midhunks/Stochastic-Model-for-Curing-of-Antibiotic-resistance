%% Saving initial parameter Data
BaseFilename = 'Inital Data ';
Timestamp = datestr(now,'dd-mmm-yyyy HH-MM-SS AM');
if ispc  % checking OS
    Subdirectory = '\Outputs\';
else
    Subdirectory = '/Outputs/';
end
Initial_Data={Initial};
save([pwd, Subdirectory, BaseFilename,Timestamp,'.mat'] , 'Initial_Data');

%% Time
Time = [Cell_Dynamics{:}.Time];
%%
h(1)=figure(1);
plot(Time',Cell_Dynamics_Matrix')
Legend = legend(Cell_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';
Figure_Setup

h(2)=figure(2);
plot(Time',Ratio_Matrix')
Legend = legend(Ratio_legendInfo);
Legend.Orientation = 'horizontal';
Legend.Location = 'NorthOutside';clc
Figure_Setup

%% Saving figures in different formats
BaseFilename = 'Cell_Dynamics ';
saveas(h(1),[pwd,Subdirectory,BaseFilename, Timestamp,'.png'],'png');
saveas(h(1),[pwd, Subdirectory, BaseFilename, '(Ratio)', Timestamp,'.png'],'png');

saveas(h(2),[pwd,Subdirectory,BaseFilename, Timestamp,'.eps'],'epsc');
saveas(h(2),[pwd, Subdirectory, BaseFilename, Timestamp,'(Ratio)','.eps'],'epsc');

savefig(h,[pwd, Subdirectory,BaseFilename, Timestamp,'.fig'],'compact');
