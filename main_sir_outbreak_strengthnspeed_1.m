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

%run the model over 10 days
[t,y]=ode45(@sir_model,[0:1:10],[pars.S0 pars.I0 0]/pars.N,[],pars);

%find the slope
[p,s]=polyfit(t,log(y(:,2)),1);

%plot the data and overlay the best-fit exponential
tmph=semilogy(t,y(:,2),'ko');
set(tmph,'linewidth',3);
hold on
tmph=semilogy(t,exp(p(1)*t+p(2)),'r-');
set(tmph,'linewidth',3);

%use solid points for the future k
[t,y]=ode45(@sir_model,[0:1:30],[pars.S0 pars.I0 0]/pars.N,[],pars);
tmpi=find(t>10);
tmph=semilogy(t(tmpi),y(tmpi,2),'ko');
set(tmph,'linewidth',3,'markerfacecolor','k');