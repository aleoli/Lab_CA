% 18AKSOA - Controlli Automatici
% VII esercitazione presso il LAIB

% Esercizio 2

clear all, close all

s=tf('s');
F=5*(s+20)/(s*(s^2+2.5*s+2)*(s^2+15*s+100));
KF=dcgain(s*F)

Kr=2;

% specifica a) => 
% 1) C(s) senza poli nell'origine (ce n'e' gia' uno in F(s))
% 2) |Kr/KGa| <= 0.05 => |Kc| >= 20*Kr^2/|KF|   => |Kc| >= 160

% specifica b) e' soddisfatta, tenendo conto del polo nell'origine di F(s),
% se |d/(Kc/Kr)|<= 0.02 => |Kr/Kc|<=0.02 => |Kc|>=100 

% specifica c) => ts = 1s => B3 ~=3/ts =3 =>
% wc < B3 < 2*wc => wc ~= 0.63*B3

wc_des=1.9

% specifica d) => s_hat=0.3 => Mr <= 1.44, Mr_dB=3.2dB
% (su Nichols) margine_di_fase >= 40deg => meglio 45deg

Kc=160 % minimo valore ammissibile
Ga1=Kc*F/Kr

% Il sistema retroazionato con il solo Kc risulta instabile 

figure, bode(Ga1)

[m_wc_des,f_wc_des]=bode(Ga1,wc_des)

% uso una derivativa doppia per recuperare 80deg ad w=wc_des,
% avente m_a=6, wc_des*tau_a=1.3 (limitando così l'aumento di modulo)

m_a=6
tau_a=1.3/wc_des
C1=((1+s*tau_a)/(1+s*tau_a/m_a))^2

[m1_wc_des,f1_wc_des]=bode(C1*Ga1,wc_des)
figure, bode(C1*Ga1)

% uso una integrativa con m_i=m1_wc_des ~= 21.5 per avere wc_finale=wc_des
% e con wc_des*tau_i~=230 per perdere circa 5deg di fase per w=wc_des

m_i=21.5
figure,bode((1+s/m_i)/(1+s))
tau_i=230/wc_des
C2=(1+s*tau_i/m_i)/(1+s*tau_i)

figure, margin(C1*C2*Ga1)

C=Kc*C1*C2
Ga=C*F/Kr;

% Verifiche in catena chiusa

W=feedback(C*F,1/Kr);
Sens=feedback(1,Ga); % verrà utilizzata per confrontare una successiva soluzione alternativa 

% Verifica delle specifiche di inseguimento al gradino t_s e s_hat
% La divisione per Kr permette di valutare direttamente s_hat=0.263 (confrontare il risultato dai due grafici!)

figure, step(W), grid on
figure, step(W/Kr), grid on 

% Verifica dell'effetto del disturbo in regime permanente
Wd=feedback(F,1/Kr*C);
figure, step(Wd,30)

% Valutazione banda passante e picco di risonanza
% La divisione per Kr permette di valutare direttamente B3 e Mr
% Confrontare i risultati dai due grafici: Mr=2.3 dB, B3=3.65 rad/s

figure,bode(W)
figure, bode(W/Kr)

% Attività sul comando: 
% confrontare il valore iniziale del grafico con quanto ricavabile dal
% teorema del valore iniziale; si ottiene u(o)=Kc*m_a^2/m_i = 267.9...

Wu=feedback(C,F/Kr);
figure,step(Wu)

%soluzione alternativa (C1 invariata, C2 data da 2 attenuatrici da 4.6 con wc_des*tau_i~=150)

m_i_alt=4.6
tau_i_alt=70/wc_des
C2_alt=((1+s*tau_i_alt/m_i_alt)/(1+s*tau_i_alt))^2

C_alt=Kc*C1*C2_alt;
Ga_alt=C_alt*F/Kr;
figure,margin(Ga_alt)

% Confronti ad anello chiuso delle due soluzioni: 
% la prima soluzione è complessivamente migliore perché 
% (1) corrisponde ad un controllore di ordine minore (ho usato una rete in meno) 
% (2) presenta un effetto coda leggermente ridotto (grafico blu)
% la seconda soluzione ha come unico vantaggio una sensibilità ridotta
% per w comprese fra 0.007 e 0.1

W_alt=feedback(C_alt*F,1/Kr);
figure,step(W)
hold
step(W_alt)
hold off
Sens_alt=feedback(1,Ga_alt);
figure,bode(Sens)
hold
bode(Sens_alt)
hold off

