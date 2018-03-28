% 18AKSOA - CONTROLLI AUTOMATICI (INF)
%
% Soluzione della III esercitazione di laboratorio:
% - progetto di un controllo mediante retroazione statica degli stati
% - progetto di un osservatore asintotico degli stati
% - progetto di un controllo mediante regolatore dinamico

clear all, close all, pack

A=[0, 1; 900, 0]
B=[0; -9]
C=[600, 0]
D=0

eig(A)

% Esercizio #1: posizionamento dei poli mediante retroazione degli stati

rank(ctrb(A,B))

l1=-40
l2=-60
K=place(A,B,[l1,l2])
eig(A-B*K)

alfa=-1
Ars=A-B*K
Brs=alfa*B
Crs=C-D*K
Drs=alfa*D
sistema_retroazionato=ss(Ars,Brs,Crs,Drs);
t_r=0:.001:4;
r=sign(sin(2*pi*0.5*t_r));
dx0_1=[ 0.00;0];
dx0_2=[+0.01;0];
dx0_3=[-0.01;0];
[dy_1,t_dy_1]=lsim(sistema_retroazionato,r,t_r,dx0_1);
[dy_2,t_dy_2]=lsim(sistema_retroazionato,r,t_r,dx0_2);
[dy_3,t_dy_3]=lsim(sistema_retroazionato,r,t_r,dx0_3);

figure, plot(t_r,r,'k',t_dy_1,dy_1,'r',t_dy_2,dy_2,'g',t_dy_3,dy_3,'b'), grid on,
title(['Risposta \deltay(t) del sistema controllato mediante retroazione degli stati', ...
       ' al variare dello stato iniziale \deltax_0']),
legend('r(t)',' \deltay(t) per \deltax_0^{(1)}', ...
              '  \deltay(t) per \deltax_0^{(2)}','   \deltay(t) per \deltax_0^{(3)}')
pause

% Esercizio #2: osservatore asintotico degli stati
% Si noti che le matrici del sistema controllato mediante retroazione degli stati valgono:
% Ars=[0, 1; -2400, -100], Brs=[0; 9], Crs=[600, 0], Drs=[0]

rank(obsv(Ars,Crs))

l_oss1=-120
l_oss2=-180
L=place(Ars',Crs',[l_oss1,l_oss2])'
eig(Ars-L*Crs)

Atot=[Ars,zeros(size(Ars)); L*Crs, Ars-L*Crs]
Btot=[Brs; Brs]
Ctot=[Crs, zeros(size(Crs)); zeros(size(Crs)), Crs]
Dtot=[Drs; Drs]
sistema_con_osservatore=ss(Atot,Btot,Ctot,Dtot);
x0_1=[ 0.00;0];
x0_2=[+0.01;0];
x0_3=[-0.01;0];
x0oss=[0;0];
x0tot_1=[x0_1; x0oss];
x0tot_2=[x0_2; x0oss];
x0tot_3=[x0_3; x0oss];
[ytot_1,t_ytot_1,xtot_1]=lsim(sistema_con_osservatore,r,t_r,x0tot_1);
[ytot_2,t_ytot_2,xtot_2]=lsim(sistema_con_osservatore,r,t_r,x0tot_2);
[ytot_3,t_ytot_3,xtot_3]=lsim(sistema_con_osservatore,r,t_r,x0tot_3);

figure, plot(t_r,r,'k',t_ytot_1,ytot_1(:,1),'r',t_ytot_1,ytot_1(:,2),'c--', ...
                       t_ytot_2,ytot_2(:,1),'g',t_ytot_2,ytot_2(:,2),'y--', ...
                       t_ytot_3,ytot_3(:,1),'b',t_ytot_3,ytot_3(:,2),'m--'), grid on,
title(['Risposta y(t) del sistema controllato mediante retroazione degli stati', ...
       ' e sua stima y_{oss}(t) al variare dello stato iniziale x_0']),
legend('r(t)','y(t) per x_0^{(1)}', 'y_{oss}(t) per x_0^{(1)}',...
              'y(t) per x_0^{(2)}', 'y_{oss}(t) per x_0^{(2)}',...
              'y(t) per x_0^{(3)}', 'y_{oss}(t) per x_0^{(3)}')
pause
axis_orig=axis;
axis([0,0.2,axis_orig(3:4)]);
pause
axis(axis_orig);

figure, plot(t_ytot_1,xtot_1(:,1),'r',t_ytot_1,xtot_1(:,3),'c--', ...
             t_ytot_2,xtot_2(:,1),'g',t_ytot_2,xtot_2(:,3),'y--', ...
             t_ytot_3,xtot_3(:,1),'b',t_ytot_3,xtot_3(:,3),'m--'), grid on,
title(['Stato x_1(t) del sistema controllato mediante retroazione degli stati', ...
       ' e sua stima x_{oss,1}(t) al variare dello stato iniziale x_0']),
legend('x_1(t) per x_0^{(1)}', 'x_{oss,1}(t) per x_0^{(1)}',...
       'x_1(t) per x_0^{(2)}', 'x_{oss,1}(t) per x_0^{(2)}',...
       'x_1(t) per x_0^{(3)}', 'x_{oss,1}(t) per x_0^{(3)}')
pause
axis_orig=axis;
axis([0,0.2,axis_orig(3:4)]);
pause
axis(axis_orig);

figure, plot(t_ytot_1,xtot_1(:,2),'r',t_ytot_1,xtot_1(:,4),'c--', ...
             t_ytot_2,xtot_2(:,2),'g',t_ytot_2,xtot_2(:,4),'y--', ...
             t_ytot_3,xtot_3(:,2),'b',t_ytot_3,xtot_3(:,4),'m--'), grid on,
title(['Stato x_2(t) del sistema controllato mediante retroazione degli stati', ...
       ' e sua stima x_{oss,2}(t) al variare dello stato iniziale x_0']),
legend('x_2(t) per x_0^{(1)}', 'x_{oss,2}(t) per x_0^{(1)}',...
       'x_2(t) per x_0^{(2)}', 'x_{oss,2}(t) per x_0^{(2)}',...
       'x_2(t) per x_0^{(3)}', 'x_{oss,2}(t) per x_0^{(3)}')
pause
axis_orig=axis;
axis([0,0.2,axis_orig(3:4)]);
pause
axis(axis_orig);

% Esercizio #3: posizionamento dei poli mediante regolatore dinamico

rank(ctrb(A,B))
rank(obsv(A,C))

L=place(A',C',[l_oss1,l_oss2])'
eig(A-L*C)

Areg=[A,-B*K; L*C, A-B*K-L*C]
Breg=[alfa*B; alfa*B]
Creg=[C,-D*K; zeros(size(C)),C-D*K]
Dreg=[alfa*D; alfa*D]
sistema_con_regolatore=ss(Areg,Breg,Creg,Dreg);
dx0oss=[0;0];
dx0tot_1=[dx0_1; dx0oss];
dx0tot_2=[dx0_2; dx0oss];
dx0tot_3=[dx0_3; dx0oss];
[yreg_1,t_yreg_1,xreg_1]=lsim(sistema_con_regolatore,r,t_r,dx0tot_1);
[yreg_2,t_yreg_2,xreg_2]=lsim(sistema_con_regolatore,r,t_r,dx0tot_2);
[yreg_3,t_yreg_3,xreg_3]=lsim(sistema_con_regolatore,r,t_r,dx0tot_3);

figure, plot(t_r,r,'k',t_yreg_1,yreg_1(:,1),'r',t_yreg_1,yreg_1(:,2),'c--', ...
                       t_yreg_2,yreg_2(:,1),'g',t_yreg_2,yreg_2(:,2),'y--', ...
                       t_yreg_3,yreg_3(:,1),'b',t_yreg_3,yreg_3(:,2),'m--'), grid on,
title(['Risposta \deltay(t) del sistema controllato mediante regolatore', ...
       ' e sua stima \deltay_{oss}(t) al variare dello stato iniziale \deltax_0']),
legend('r(t)','\deltay(t) per \deltax_0^{(1)}', '\deltay_{oss}(t) per \deltax_0^{(1)}',...
              '\deltay(t) per \deltax_0^{(2)}', '\deltay_{oss}(t) per \deltax_0^{(2)}',...
              '\deltay(t) per \deltax_0^{(3)}', '\deltay_{oss}(t) per \deltax_0^{(3)}')
pause
axis_orig=axis;
axis([0,0.2,axis_orig(3:4)]);
pause
axis(axis_orig);

figure, plot(t_yreg_1,xreg_1(:,1),'r',t_yreg_1,xreg_1(:,3),'c--', ...
             t_yreg_2,xreg_2(:,1),'g',t_yreg_2,xreg_2(:,3),'y--', ...
             t_yreg_3,xreg_3(:,1),'b',t_yreg_3,xreg_3(:,3),'m--'), grid on,
title(['Stato \deltax_1(t) del sistema controllato mediante regolatore', ...
       ' e sua stima \deltax_{oss,1}(t) al variare dello stato iniziale \deltax_0']),
legend('\deltax_1(t) per \deltax_0^{(1)}', '\deltax_{oss,1}(t) per \deltax_0^{(1)}',...
       '\deltax_1(t) per \deltax_0^{(2)}', '\deltax_{oss,1}(t) per \deltax_0^{(2)}',...
       '\deltax_1(t) per \deltax_0^{(3)}', '\deltax_{oss,1}(t) per \deltax_0^{(3)}')
pause
axis_orig=axis;
axis([0,0.2,axis_orig(3:4)]);
pause
axis(axis_orig);

figure, plot(t_yreg_1,xreg_1(:,2),'r',t_yreg_1,xreg_1(:,4),'c--', ...
             t_yreg_2,xreg_2(:,2),'g',t_yreg_2,xreg_2(:,4),'y--', ...
             t_yreg_3,xreg_3(:,2),'b',t_yreg_3,xreg_3(:,4),'m--'), grid on,
title(['Stato \deltax_2(t) del sistema controllato mediante regolatore', ...
       ' e sua stima \deltax_{oss,2}(t) al variare dello stato iniziale \deltax_0']),
legend('\deltax_2(t) per \deltax_0^{(1)}', '\deltax_{oss,2}(t) per \deltax_0^{(1)}',...
       '\deltax_2(t) per \deltax_0^{(2)}', '\deltax_{oss,2}(t) per \deltax_0^{(2)}',...
       '\deltax_2(t) per \deltax_0^{(3)}', '\deltax_{oss,2}(t) per \deltax_0^{(3)}')
pause
axis_orig=axis;
axis([0,0.2,axis_orig(3:4)]);
pause
axis(axis_orig);