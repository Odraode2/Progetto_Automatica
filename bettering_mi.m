square = importdata("square.mat");
mi = 7.696367759707887e+03;
hp_t1 = 0.1315;
hp_t2 = 0.0075;
var = 1;
alpha = -mi*hp_t1/(hp_t2-hp_t1);
beta = mi*hp_t2/(hp_t2-hp_t1);
A = [-1/hp_t1,0;0,-1/hp_t2];
B = [alpha/hp_t1; beta/hp_t2];
C = [1 1];
D = 0;
sis = ss(A, B, C, D);
opt = stepDataOptions('stepAmplitude',5);
[y,dt,x] = step(sis,square(1,1:500),opt);
guadagno_statico = 7725;
mi = guadagno_statico;
dt = square(1,2)-square(1,1);
y_data = square(4,1:500).';
quad_diff = (y_data-y).^2;
costo1 = sum(quad_diff);
for i = 1:100000
    display(i)
    mix = mi + var;
    alpha = -mix*hp_t1/(hp_t2-hp_t1);
    beta = mix*hp_t2/(hp_t2-hp_t1);
    A = [-1/hp_t1,0;0,-1/hp_t2];
    B = [alpha/hp_t1; beta/hp_t2];
    C = [1 1];
    D = 0;
    sis = ss(A, B, C, D);
    opt = stepDataOptions('stepAmplitude',5);
    [y,dt,x] = step(sis,square(1,1:500),opt);
    quad_diff = (y_data-y).^2;
    costo2 = sum(quad_diff);
    if costo2 < costo1
        mi = mix;
    else
        var = -(var/10);
    end
    costo1 = costo2;
    plot(dt,y);
    hold on
    plot(dt, square(4,1:500));
    pause(0.01);
    hold off
end
 