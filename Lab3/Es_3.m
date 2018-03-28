A = [0, 1; 900, 0];
B = [0; -9];
C = [600, 0];
D = [0];

eig(A)

rank(A)
rank(B)

A
B

l1=-40;
l2=-60;
K = place(A, B, [l1, l2])
eig(A-B*K)