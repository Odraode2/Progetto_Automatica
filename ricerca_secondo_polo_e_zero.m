square = importdata("square.mat");
hp_t1 = 0.13;
hp_z1 = 0.05;
guadagno_statico = 7725;
mi = guadagno_statico;
figure
for i = (hp_t1+0.01):0.01:10*hp_t1
    hp_t2 = i;
    hp_z1 = 0.1;
    alpha = mi*(1-(hp_z1)/(hp_t1-hp_t2));
    beta = mi*(hp_z1)/(hp_t1-hp_t2);
    A = [-1/hp_t1,0;0,-1/hp_t2];
    B = [alpha/hp_t1; beta/hp_t2];
    C = [1 1];
    D = 0;
    sis = ss(A, B, C, D);
    opt = stepDataOptions('stepAmplitude',5);
    [y,dt,x] = step(sis,square(1,1:500),opt);
    plot(dt,y);
    hold on
    plot(dt, square(4,1:500));
    pause(0.1);
    hold off
end