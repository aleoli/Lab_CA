% Esercizio sul motore elettrico in corrente continua,
% con comando di armatura ed uscita in velocita' o in posizione
clear all, close all

s=tf('s');

% Parametri del motore elettrico
Ra=1; La=6e-3; Km=0.5; J=0.1; b=0.02; Ka=10;

F1=Ka*Km/((s*La+Ra)*(s*J+b)+Km^2)
F2=-(s*La+Ra)/((s*La+Ra)*(s*J+b)+Km^2)

Kc=0.1

% Motore controllato in velocita'
W=feedback(Kc*F1,1)
z_W=zero(W)
p_W=pole(W)
damp(W)
bode (W)

% Motore controllato in posizione
Kc_max=(b*La+Ra*J)*(Ra*b+Km^2)/(J*La*Km*Ka)

W=feedback(Kc*F1/s,1)
z_W=zero(W)
p_W=pole(W)
damp(W)
bode (W)