es=menu('Simulazione della risposta del sistema meccanico',...
        'caso 1.a: beta=0.1,  K=2,  x0=[0;0],   F(t)=1;',...
        'caso 1.b: beta=0.01, K=2,  x0=[0;0],   F(t)=1;',...
        'caso 1.c: beta=10,   K=20, x0=[0;0],   F(t)=1;',...
        'caso 1.d: beta=0.1,  K=2,  x0=[0;0.2], F(t)=1;',...
        'caso 2.a: beta=0.1,  K=2,  x0=[0;0],   F(t)=cos(4t);',...
        'caso 2.b: beta=0.01, K=2,  x0=[0;0],   F(t)=cos(4t);',...
        'caso 2.c: beta=10,   K=20, x0=[0;0],   F(t)=cos(4t);',...
        'caso 2.d: beta=0.1,  K=2,  x0=[0;0.2], F(t)=cos(4t)');
switch es,
case 1, beta=0.1;  k=2;  x0=[0;0];   w0=0; tmax=20;
case 2, beta=0.01; k=2;  x0=[0;0];   w0=0; tmax=200;
case 3, beta=10;   k=20; x0=[0;0];   w0=0; tmax=10;
case 4, beta=0.1;  k=2;  x0=[0;0.2]; w0=0; tmax=20;
case 5, beta=0.1;  k=2;  x0=[0;0];   w0=4; tmax=10;
case 6, beta=0.01; k=2;  x0=[0;0];   w0=4; tmax=10;
case 7, beta=10;   k=20; x0=[0;0];   w0=4; tmax=10;
case 8, beta=0.1;  k=2;  x0=[0;0.2]; w0=4; tmax=10;
end

m = 0.2;
f0 = 1;

A = [0, -k/m; 1, -k/beta];
B = [1/m; 0];
C = [1, 0];
D = 0;

sistema = ss(A, B, C, D);


% risposta sistema dinamico

t = 0:0.01:tmax;
u = f0*cos(w0*t);

[y, tsim, x] = lsim(sistema, u, t, x0);

figure(1), plot(tsim,x(:,1)), grid on, zoom on, title('Evoluzione dello stato x_1'), 
xlabel('tempo (in s)'), ylabel('velocit? v (in m/s)')
figure(2), plot(tsim,x(:,2)), grid on, zoom on, title('Evoluzione dello stato x_2'), 
xlabel('tempo (in s)'), ylabel('posizione p_A (in m)')
figure(3), plot(tsim,y), grid on, zoom on, title('Evoluzione dell''uscita y'), 
xlabel('tempo (in s)'), ylabel('velocit? v (in m/s)')


% funzione di trasferimento

fprintf('System G(s)');
G=tf(sistema)

[numG, denG] = ss2tf(A, B, C, D);

fprintf('Zeri di G(s)');
damp(numG); % Calcolo degli zeri di G(s)

fprintf('Poli di G(s)');
damp(denG); % Calcolo dei poli di G(s)


% calcolo analitico della risposta del sistema dinamico

fprintf('Input U(s)');
ingresso = menu('Tipo d''ingresso del sistema', 'u(t)=u0;', 'u(t)=t;', 'u(t)=u0*cos(4t)');
switch ingresso,
case 1, U = tf(1, [1,0])
case 2, U = tf(1, [1,0,0])
case 3, U = tf([1,0], [1,0,4^2])
end

fprintf('Output Y(s)');
Y = G*U

[numY, denY] = tfdata(Y, 'v');
[residui, poli, resto] = residue(numY, denY) % Scomposizione in fratti semplici



