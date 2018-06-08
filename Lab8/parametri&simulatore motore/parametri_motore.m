clear all
close all

% Parametri del motore elettrico

close all

s=tf('s');

Ra=6;
La=3.24e-3;
Km=0.0535;
J=19.74e-6;
Beta=17.7e-6;
Kf=14e-3;
Kpwm=2.925;
Rs=7.525;
Kt=0.02;                % guadagno della dinamo tachimetrica
tau_a=0.001;


F=402.5/(s*(1+s/0.8967)); % f.d.t. motore fra  u e velocita' angolare
Fd=-56500/(1+s/0.8967);   % f.d.t. motore fra Td e velocita' angolare

Td=0 %da cambiare a seconda dei casi



