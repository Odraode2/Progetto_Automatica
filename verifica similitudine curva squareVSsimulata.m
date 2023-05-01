A = - 1/primaryTau;
B = 1/primaryTau;
C = 7725;
D = 0;

square = importdata("square.mat");
%vec_t = 0:square(1,2)-square(1,1):square(1,size(square,2));
sis = ss(A,B,C,D);
opt = stepDataOptions('stepAmplitude', 5);
[y,vec_t,x] = step(sis,square(1,:),opt);
figure
plot(y,vec_t)
