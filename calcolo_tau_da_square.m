%% Analisi onda quadra
[tmax, posmax, maxva] = maxval(square);
[firstTau, posfirst] = findthefirstfrom(square, 0.99*maxva, 1);
figure
plot(square(1,:),square(4,:))
hold on 
plot(firstTau,0.99*maxva,'ro','MarkerSize',3)
primaryTau = firstTau/5;



%% transitorio di discesa %valori di inizio transitorio
xin = [];
FineTransDis=[]; %valori di fine transitorio [tau,indice]
% trovare il valore i valori di inizio transitorio
for i = 2:length(square)
    if square(2,i-1) == 5 && square(2,i) == 0
        xin(1, size(xin,2)+1) = square(4,i-1);
        xin(2, size(xin,2)) = i-1;
    end
end
FineTransDis = zeros(2,4);
for j = size(xin,2)
    from = xin(2,j);
    for i = from:size(square,2)
        if square(4,i) < 0.01*xin(1,j)
            FineTransDis(1,j) = square(1,i)-square(1,xin(2,j));
            FineTransDis(2,j) = i;
            break;
        end
    end
end
disp(FineTransDis)
% for i = 1:length(xin(1,:))
%     [FineTransDis(1,length(FineTransDis)+1),y]=findthefirstfrom(square,0.01*xin(1,i),xin(2,i));
% end
%FineTransDis
function [x,y] = findthefirstfrom(data, value, a)
    t = -1;
    position = -1;
    for i = a:length(data(4,:))
        if data(4,i)>value
            t = data(1,i);
            position = i;
            x = t-data(1,a);% t-t_0
            y = position;
            return 
        end
    end
    x = t;
    y = position;
end

function [x,y,z] = maxval(data)
    t = -1;
    position = -1;
    maxv = data(4,1);
    for i = 1:length(data(4,:))
        if data(4,i)>maxv
            maxv = data(4,i);
            position = i;
            t = data(1,i);
        end
    end
    x = t;
    y = position;
    z =  maxv;
    return
end
