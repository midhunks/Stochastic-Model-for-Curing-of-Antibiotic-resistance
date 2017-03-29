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
%% Plotting cell dynamics
h(1)=figure(1);
plot(Time',Cell_Dynamics_Matrix')
Legend = legend(Cell_legendInfo);

ax = gca; % current axes
% ax.Title.String = 'Cell Dynamics';
ax.XLabel.String = 'Time';
ax.YLabel.String = 'Number of cells';
ax.XLim = [Time(1), Time(end)];
ax.YLim = [min(Cell_Dynamics_Matrix(:)), max(Cell_Dynamics_Matrix(:))];
Figure_Setup % Common settings

%% Plotting curing ratios
h(2)=figure(2);
plot(Time',Ratio_Matrix')
Legend = legend(Ratio_legendInfo);

ax = gca; % current axes
% ax.Title.String = 'Ratio of Conjugation and Curing';
ax.XLabel.String = 'Time';
ax.YLabel.String = 'Ratio of Conjugation and Curing';
ax.XLim = [Time(1), Time(end)];
ax.YLim = [min(Ratio_Matrix(:)), max(Ratio_Matrix(:))];
Figure_Setup % Common settings

%% Saving figures in different formats
BaseFilename = 'Cell_Dynamics ';
saveas(h(1),[pwd,Subdirectory,BaseFilename, Timestamp,'.png'],'png');
saveas(h(2),[pwd, Subdirectory, BaseFilename, '(Ratio)', Timestamp,'.png'],'png');

saveas(h(1),[pwd,Subdirectory,BaseFilename, Timestamp,'.eps'],'epsc');
saveas(h(2),[pwd, Subdirectory, BaseFilename, Timestamp,'(Ratio)','.eps'],'epsc');

savefig(h,[pwd, Subdirectory,BaseFilename, Timestamp,'.fig'],'compact');
