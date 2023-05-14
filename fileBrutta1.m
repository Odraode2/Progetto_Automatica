clear
square = importdata("square.mat");
mi=7722.2;
t1 = 0.1315;
t2 = 0.0075;
T = square(1,500);
dt = square(1,2)-square(1,1);
t = 0:dt:T;
u = 5*ones(1,length(t));
sys = zpk([],[-1/t1 -1/t2], mi/(t1*t2));%tf(mi, [1 2 1]);
opt = stepDataOptions('StepAmplitude',5);
y = step(sys,t,opt);
figure
plot(t,y)
hold on 
plot(t,square(4,1:500))
hold off
% z=[1 0];
% p=0.3+0.5j;
% zplane(z,p)
y_data = square(4,1:500);
y_data = y_data'