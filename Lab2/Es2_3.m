w_v = [2, 2, 1];
c_v = [0.5, 0.25, 0.5];

for i = 1:3
    G5 = tf(w_v(i)*w_v(i), [1, 2*c_v(i)*w_v(i), w_v(i)*w_v(i)]);
    
    i
    s = exp(-pi*c_v(i)/sqrt(1-c_v(i)*c_v(i)))
    ts = 1/(w_v(i)*sqrt(1-c_v(i)*c_v(i)))*(pi-acos(c_v(i)))
    
    figure
    step(G5)
end