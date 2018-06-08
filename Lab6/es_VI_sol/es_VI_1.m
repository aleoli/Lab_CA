% 18AKSOA - Controlli Automatici
% VI esercitazione presso il LAIB

% Esercizio #1

clear all, close all

s=tf('s');
F=(s+10)/(s^3+45*s^2-250*s)

% Punto a): studio di F(s)

% Guadagno stazionario di F(s)
Kf=dcgain(s*F)   % F(s) ha 1 polo nell'origine

% Zeri e poli di F(s)
zero(F)
pole(F)
damp(F)

% Diagrammi di Bode di F(jw) (valutazione fase iniziale e finale)
bode(F)

% Punto b) e c): studio di Ga(s) per Kc = 1
Kc=1
Kr=2
Ga1=Kc*F/Kr

% Diagrammi di Bode di Ga1(jw)
figure, bode(Ga1)

% Diagramma di Nyquist di Ga1(jw), da ingrandire opportunamente
% in corrispondenza degli attraversamenti dell'asse reale
figure, nyquist(Ga1)

% Punto d): calcolo di W(s) e dei suoi poli per Kc=800
Kc=800
Ga=Kc*F/Kr;
W=feedback(Kc*F,1/Kr)
damp(W)

% Punto e): errore di inseguimento in regime permanente
% Nota bene: il sistema di controllo e' di tipo 1

We=Kr*feedback(1,Ga)
Wd1=feedback(F,Kc/Kr)
Wd2=feedback(1,Ga)

% Caso e.1): r(t)=t, d1(t)=0.1, d2(t)=0.5
errore_r=dcgain(s*We*1/s^2)
errore_d1=dcgain(s*Wd1*0.1/s)
errore_d2=dcgain(s*Wd2*0.5/s)
errore_tot=errore_r-(errore_d1+errore_d2)

% Caso e.2): r(t)=2, d1(t)=0, d2(t)=0.01t
errore_r=dcgain(s*We*2/s)
errore_d1=dcgain(s*Wd1*0)
errore_d2=dcgain(s*Wd2*0.01/s^2)
errore_tot=errore_r-(errore_d1+errore_d2)