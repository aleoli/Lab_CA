% 18AKSOA - Controlli Automatici
% VII esercitazione presso il LAIB

% Esercizio 1

clear all, close all

s=tf('s');
F=13.5*(s+4)*(s+10)/(s+3)^3;
KF=dcgain(F)

Kr=1;

% specifica a) => 
% 1) C(s) con 1 polo nell'origine, 
% 2) |Kr/KGa| <= 0.01 => |Kc| >= 100*Kr^2/|KF|   => |Kc| >= 5

% specifica b) e' soddisfatta se C(s) ha 1 polo nell'origine

% specifica c) => wc < B3 < 2*wc => wc ~= 0.63 * B3

wc_des=3.8

% specifica d) => (su Nichols) margine_di_fase >= 45deg => meglio ~50deg

Kc=5 % minimo valore ammissibile
Ga1=(Kc/s)*F/Kr

% Il sistema retroazionato con il solo Kc risulta instabile 
 
figure, bode(Ga1)

[m_wc_des,f_wc_des]=bode(Ga1,wc_des)

% uso una derivativa doppia per recuperare 60deg ad w=wc_des,
% avente m_a=4, wc_des*tau_a=1 (limitando così l'aumento di modulo)

m_a=4
tau_a=1/wc_des
C1=((1+s*tau_a)/(1+s*tau_a/m_a))^2

[m1_wc_des,f1_wc_des]=bode(C1*Ga1,wc_des)
figure, bode(C1*Ga1)

% uso una integrativa con m_i=m1_wc_des ~= 17.4 per avere wc_finale=wc_des
% e con wc_des*tau_i~=150 per perdere meno di 10 gradi di fase in w=wc_des

m_i=17.4
figure,bode((1+s/m_i)/(1+s))
tau_i=150/wc_des
C2=(1+s*tau_i/m_i)/(1+s*tau_i)

figure, margin(C1*C2*Ga1)

C=Kc/s*C1*C2
Ga=C*F/Kr;

% Verifiche in catena chiusa

% Verifica della banda passante e del picco di risonanza 
% (si ottiene B3 = 5.7 rad/s, Mr = 1.7 dB <2 dB)
W=feedback(C*F,1/Kr);
figure, bode(W)

% Verifica dell'errore di inseguimento alla rampa 
% (si ottiene errore = 0.01 in regime permanente)
t=0:0.01:20;
r=t';
y_rampa=lsim(W,r,t);
figure, plot(t,r,t,y_rampa), title('Inseguimento alla rampa'), grid on
figure, plot(t,Kr*r-y_rampa), title('Errore di inseguimento alla rampa'), grid on

% Verifica dell'effetto del disturbo (astaticità)
Wd=feedback(F,1/Kr*C);
figure, step(Wd,20)

% Calcolo dell'errore di inseguimento in regime permanente
% a riferimento sinusoidale sin(0.1*t)
w_r=0.1;
Sens=feedback(1,Ga);
errore_sin=bode(Sens,w_r)*Kr

% Verifica dell'errore di inseguimento in regime permanente
% a riferimento sinusoidale sin(0.1*t)
t=0:0.01:200;
r=sin(w_r*t)';
y=lsim(W,r,t);
figure, plot(t,r,t,y,'--'), title('Inseguimento ad un riferimento sinusoidale'), grid on
figure, plot(t,Kr*r-y), title('Errore di inseguimento ad un riferimento sinusoidale'), grid on

% Attenuazione di disturbi sinusoidali entranti sul riferimento,
% aventi pulsazione=100rad/s
w_disturbi_r=100;
attenuazione_disturbi_r=bode(W,w_disturbi_r)

% Verifica dell'attenuazione di disturbi sinusoidali entranti insieme
% al riferimento a gradino unitario, nel caso che tali disturbi abbiano
% ampiezza=0.1, pulsazione=100rad/s
t=0:0.001:20;
r_disturbato=ones(size(t))+0.1*sin(w_disturbi_r*t);
y_r_disturbato=lsim(W,r_disturbato,t);
figure, plot(t,r_disturbato,'g',t,y_r_disturbato,'r'), grid on, 
title('Inseguimento di un riferimento a gradino con disturbo sinusoidale sovrapposto')
