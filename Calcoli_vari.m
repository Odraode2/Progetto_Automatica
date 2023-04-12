%% Analisi onda quadra
[tmax, posmax, maxva] = maxval(square);
[firstTau, posfirst] = findthefirst(square, 0.99*maxva)
figure
plot(square(1,:),square(4,:))
hold on 
plot(firstTau,0.99*maxva,'ro','MarkerSize',1)


function [x,y] = findthefirst(data, value)
    t = -1;
    position = -1;
    for i = 1:length(data(4,:))
        if data(4,i)>(value)
            t = data(1,i);
            position = i;
            x = t;
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
