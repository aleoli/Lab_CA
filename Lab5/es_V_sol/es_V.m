% 18AKSOA - Controlli Automatici
% V esercitazione presso il LAIB

clear all, close all

s=tf('s');
F=(s^2+11*s+10)/(s^4+4*s^3+8*s^2)

% Punto a): studio di F(s)

% Guadagno stazionario di F(s)
Kf=dcgain(s^2*F)   % F(s) ha 2 poli nell'origine

% Zeri e poli di F(s)
zero(F)
pole(F)
damp(F)

% Diagrammi di Bode di F(jw)
bode(F)

% Punto b) e c): studio di Ga(s)
Kc=1
Kr=1
Ga=Kc*F/Kr

% Diagrammi di Bode di Ga(jw)
figure, bode(Ga)

% Diagramma di Nyquist di Ga(jw), con ingrandimento
% in corrispondenza degli attraversamenti dell'asse reale
figure, nyquist(Ga)

w=logspace(0,3,1000);
figure, nyquist(Ga,w)

% Punto d): calcolo di W(s) e dei suoi poli
W=feedback(Kc*F,1/Kr)
damp(W)

% Punto e): errore di inseguimento in regime permanente
% Nota bene: il sistema di controllo e' di tipo 2

We=Kr*feedback(1,Ga)
Wd1=feedback(F,Kc/Kr)
Wd2=feedback(1,Ga)

% Caso e.1): r(t)=t, d1(t)=0.1, d2(t)=0.5
errore_r=dcgain(s*We*1/s^2)
errore_d1=dcgain(s*Wd1*0.1/s)
errore_d2=dcgain(s*Wd2*0.5/s)
errore_tot=errore_r-(errore_d1+errore_d2)

% Caso e.2): r(t)=2t, d1(t)=0, d2(t)=0.01t
errore_r=dcgain(s*We*2/s^2)
errore_d1=dcgain(s*Wd1*0)
errore_d2=dcgain(s*Wd2*0.01/s^2)
errore_tot=errore_r-(errore_d1+errore_d2)

% Caso e.3):  r(t)=t^2/2, d1(t)=0, d2(t)=0
errore_r=dcgain(s*We*1/s^3)
errore_d1=dcgain(s*Wd1*0)
errore_d2=dcgain(s*Wd2*0)
errore_tot=errore_r-(errore_d1+errore_d2)

% Caso e.4):  r(t)=t^2/2, d1(t)=0.1, d2(t)=0.2
errore_r=dcgain(s*We*1/s^3)
errore_d1=dcgain(s*Wd1*0.1/s)
errore_d2=dcgain(s*Wd2*0.2/s)
errore_tot=errore_r-(errore_d1+errore_d2)