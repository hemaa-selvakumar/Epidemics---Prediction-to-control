clear; close all; 

%main data goes here
beta = [0.5 1 0.25 0.75];
gamma = [0.4 0.5 0.5 0.25];
for i =1:4
    pars(i).beta = beta(i); %Transmission rate
    pars(i).gamma = gamma(i); % Recovery rate (days^-1)
    pars(i).basR0 = 1; % Basic reproduction number
    pars(i).N = 10000;
    pars(i).I0 = 1;
    pars(i).S0 = pars(i).N-pars(i).I0;
end

ndays=400;

%run the model
for i=1:4
    [t,y]=ode45(@sir_model,[0:1:ndays],[pars(i).S0 pars(i).I0 0]/pars(i).N,[],pars(i));
    R0(i) = log(y(ndays,1))/(y(ndays,1)-1);
    r(i)=pars(i).gamma*(R0(i)-1);
end