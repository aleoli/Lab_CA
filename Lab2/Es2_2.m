z_a = [100, 10, 1, 0.5];
z_b = [-0.9, -0.5, -0.1];
z_c = [-100, -10, -2];

for z = z_b
    G4_1 = tf(5, [-z, 0]);
    G4_2 = tf([1, -z], [1, 6, 5]);
    G4 = G4_1 * G4_2;
    
    figure
    step(G4)
end
