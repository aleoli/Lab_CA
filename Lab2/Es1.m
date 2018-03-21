G1 = tf(10, [1, -5]);
G2 = tf(10, [1, 0]);
G3 = tf(10, [1, 5]);
G4 = tf(10, [1, 20]);


% calcolo antitrasformata

% syms s
% F = 10/(s-5);
% ilaplace(F)

fprintf('Risposte all''impulso\n');

impulse(G1)
figure
impulse(G2)
figure
impulse(G3)
figure
impulse(G4)

% tau G1
[numG1, denG1] = tfdata(G1, 'v');
[residui, poli, resto] = residue(numG1, denG1);
tauG1 = -1/poli

% tau G2
[numG2, denG2] = tfdata(G2, 'v');
[residui, poli, resto] = residue(numG2, denG2);
tauG2 = -1/poli

% tau G3
[numG3, denG3] = tfdata(G3, 'v');
[residui, poli, resto] = residue(numG3, denG3);
tauG3 = -1/poli

% tau G4
[numG4, denG4] = tfdata(G4, 'v');
[residui, poli, resto] = residue(numG4, denG4);
tauG4 = -1/poli



fprintf('Risposte al gradino unitario\n');

figure
step(G1)
figure
step(G2)
figure
step(G3)
figure
step(G4)


