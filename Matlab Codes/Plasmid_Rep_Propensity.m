%% Plasmid Replication Propensity Functions
function Prop = Plasmid_Rep_Propensity(Plasmid_Population,time)
global Mean_Cell_cycle Rates
% Hyperbolic
Prop = Rates.Ktr./(1+Plasmid_Population./(Rates.K*2.^(time/Mean_Cell_cycle)));

%Exponential
% Prop = Rates.Ktr*exp(-Plasmid_Population./(Rates.K*2.^(time/Mean_Cell_cycle)));%exp(time*log(2)/Mean_Cell_cycle)));
end