mi = 7722.2;
t2 = 0.0075;
t1 = 0.1315;
var1 = 100;
var2 = 10000;
%ipotizzo ci siano due pulsazioni differenti se una delle due risultasse
%uguale al polo associato deduco che non 
wn1 = 10;
wn2 = 300; 
xi1=1/sqrt(t1*wn1^2);
xi2=1/sqrt(wn2^2*t2);
polo1a = 1/(wn1*xi1-1i*wn1*sqrt(1-xi1^2));
polo1b = 1/(wn1*xi1+1i*wn1*sqrt(1-xi1^2));
polo2a = 1/(wn2*xi2-1i*wn2*sqrt(1-xi2^2));
polo2b = 1/(wn2*xi2+1i*wn2*sqrt(1-xi2^2));
T = square(1,500);
dt = square(1,2)-square(1,1);
t = 0:dt:T;
u = 5*ones(1,length(t));
H = zpk([],[-1/polo1a -1/polo1b -1/polo2a -1/polo2b], mi/(polo1a*polo1b*polo2a*polo2b));
y = lsim(H,u,t);
% figure
% plot(t,y)
% figure
% zplane([],[-1/t1+1i*wn1*sqrt(1-xi1^2) -1/t1-1i*wn1*sqrt(1-xi1^2) -1/t2+1i*wn2*sqrt(1-xi2^2) -1/t2-1i*wn2*sqrt(1-xi2^2)])
y_data = square(4,1:500);
y_data = y_data';
quad_diff=(y_data-y).^2;
costo1 = sum(quad_diff);
figure
for i = 1:100000
    wn1x = wn1 + var1;
    xi1x=1/sqrt(t1*wn1x^2);
    polo1a = 1/(-wn1x*xi1x-1i*wn1x*sqrt(1-xi1x^2));
    polo1b = 1/(-wn1x*xi1x+1i*wn1x*sqrt(1-xi1x^2));
    H = zpk([],[-1/polo1a -1/polo1b -1/polo2a -1/polo2b], mi/(polo1a*polo1b*polo2a*polo2b));
    y = lsim(H,u,t);
    quad_diff=(y_data-y).^2;
    costo2 = sum(quad_diff);
    if costo2<costo1
        costo1 = costo2;
    else
        var1 = -var1/10;
    end
    wn1 = wn1x;
    wn2x = wn2 + var2;
    xi2x=1/sqrt(t1*wn2x^2);
    polo2a = 1/(-wn2x*xi2x-1i*wn2x*sqrt(1-xi2x^2));
    polo2b = 1/(-wn2x*xi2x+1i*wn2x*sqrt(1-xi2x^2));
    H = zpk([],[-1/polo1a -1/polo1b -1/polo2a -1/polo2b], mi/(polo1a*polo1b*polo2a*polo2b));
    y = lsim(H,u,t);
    quad_diff=(y_data-y).^2;
    costo2 = sum(quad_diff);
    if costo2<costo1
        costo1 = costo2;
    else
        var2 = -var2/10;
    end
    wn2 = wn2x;
    plot(t,y)
    hold on
    plot(t, square(4,1:500));
    pause(0.0001);
    hold off
end
