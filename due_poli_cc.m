mi = 7722.2;
t2 = 0.0075;
t1 = 0.1315;
var1 = 1;
var2 = 10;
%ipotizzo ci siano due pulsazioni differenti se una delle due risultasse
%uguale al polo associato deduco che non 
wn1 = 10;
wn2 = 300; 
xi1=1/(t1*wn1);
xi2=1/(wn2*t2);
T = square(1,500);
dt = square(1,2)-square(1,1);
t = 0:dt:T;
u = 5*ones(1,length(t));
H = zpk([],[-1/t1+1i*wn1*sqrt(1-xi1^2) -1/t1-1i*wn1*sqrt(1-xi1^2) -1/t2+1i*wn2*sqrt(1-xi2^2) -1/t2-1i*wn2*sqrt(1-xi2^2)], mi*10^4);
y = lsim(H,u,t);
figure
plot(t,y)
figure
zplane([],[-1/t1+1i*wn1*sqrt(1-xi1^2) -1/t1-1i*wn1*sqrt(1-xi1^2) -1/t2+1i*wn2*sqrt(1-xi2^2) -1/t2-1i*wn2*sqrt(1-xi2^2)])
y_data = square(4,1:500);
quad_diff=(y_data-y).^2;
costo1 = sum(quad_diff);
figure
for i = 1:100000
    wn1x = wn1 + var1;
    xi1x=1/(t1*wn1x);
    H = zpk([],[-1/t1+1i*wn1x*sqrt(1-xi1x^2) -1/t1-1i*wn1x*sqrt(1-xi1x^2) -1/t2+1i*wn2*sqrt(1-xi2^2) -1/t2-1i*wn2*sqrt(1-xi2^2)], mi);
    y = lsim(H,u,t);
    y_data = square(4,1:500);
    quad_diff=(y_data-y).^2;
    costo2 = sum(quad_diff);
    if costo2<costo1
        wn1 = wn1x;
    else
        var1 = -var1/10;
    end
    costo1 = costo2;
    wn2x = wn2 + var2;
    xi2x=1/(wn2x*t2);
    H = zpk([],[-1/t1+1i*wn1*sqrt(1-xi1^2) -1/t1-1i*wn1*sqrt(1-xi1^2) -1/t2+1i*wn2x*sqrt(1-xi2x^2) -1/t2-1i*wn2x*sqrt(1-xi2x^2)], mi);
    y = lsim(H,u,t);
    y_data = square(4,1:500);
    quad_diff=(y_data-y).^2;
    costo2 = sum(quad_diff);
    if costo2<costo1
        wn2 = wn2x;
    else
        var2 = -var2/10;
    end
    costo1 = costo2;
    plot(t,y)
    hold on
    plot(t, square(4,1:500));
    pause(0.01);
    hold off
end
