A1 = [-0.5, 1; 0, -2]
eig(A1)

A2 = [-0.5, 1; 0, -1]
eig(A2)

A3 = [-0.5, 1; 0, -1]
eig(A3)

A4 = [-0.5, 1; 0, 1]
eig(A4)

tmax = 10;

B = [1; 1];
C = [1, 3];
D = 0;

x0 = [rand(); rand()];

sys = ss(A1, B, C, D);

t = 0:0.01:tmax;
u = 0*t;

[y, tsim, x] = lsim(sys, u, t, x0);

figure(1), plot(tsim,x(:,1)), grid on, zoom on, title('Evoluzione dello stato x_1'), 
xlabel('tempo (in s)'), ylabel('stato x1')
figure(2), plot(tsim,x(:,2)), grid on, zoom on, title('Evoluzione dello stato x_2'), 
xlabel('tempo (in s)'), ylabel('stato x2')
figure(3), plot(tsim,y), grid on, zoom on, title('Evoluzione dell''uscita y'), 
xlabel('tempo (in s)'), ylabel('uscita y')

