G1 = tf(20, [1, 11, 10]);
G2 = tf(2, [1, 2, 1]);
G3 = tf(0.2, [1, 1.1, 0.1]);

step(G1)
figure
step(G2)
figure
step(G3)

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

