clear; close all; clc;

pars.c = 20; % Contacts per unit time (e.g., days)
pars.p = 0.025; % Probability of infectious contact
pars.beta = pars.c*pars.p; %Transmission rate
pars.gamma = 1/4; % Recovery rate (days^-1)
pars.basR0 = 1; % Basic reproduction number
%modify the initial values
pars.N = 10000;
pars.S0_range = [0.6 0.7 0.8 0.9 0.999];
pars.I0_range = 1/pars.N*ones(1,5);
pars.R0_range = 1-pars.S0_range-pars.I0_range;

%run the model
for i = 1:length(pars.S0_range)
    [t,y] = ode45(@sir_model,[0:1:200],[pars.S0_range(i) pars.I0_range(i) pars.R0_range(i)],[],pars);
    tmph = plot(y(:,1),y(:,2),'k-');
    set(tmph,'linewidth',3);
    hold on;
    tmph = plot(y(end,1),y(end,2),'ro');
    set(tmph,'markerfacecolor','r');
    tmph = plot(y(1,1),y(1,2),'ko');
    set(tmph,'markerfacecolor','k');    
end
ylim([0 0.25]);
xlim([0 1]);
ylabel('Infectious fraction, I');
xlabel('Susceptible fraction, S');

%show the excluded regions
patch([1 1 0.75],[0 0.25,0.25],[0.8 0.8 0.8]);
    
