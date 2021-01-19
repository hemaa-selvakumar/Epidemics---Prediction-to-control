clear; close all; clc;

%main data goes here
pars.c = 20; % Contacts per unit time (e.g., days)
pars.p = 0.025; % Probability of infectious contact
pars.beta = pars.c*pars.p; %Transmission rate
pars.gamma = 1/4; % Recovery rate (days^-1)
pars.basR0 = 1; % Basic reproduction number
pars.N = 10000;
pars.I0 = 1;
pars.S0 = pars.N-pars.I0;

%run the model
[t,y]=ode45(@sir_model,[0 100],[pars.S0 pars.I0 0]/pars.N,[],pars);

%plot the results
tmph=plot(t,y);
set(tmph,'linewidth',3);
xlabel('Time (days)');
ylabel('Population fraction');
tmplh = legend('Susceptible', 'Infectious', 'Recovered');
legend('boxoff');


