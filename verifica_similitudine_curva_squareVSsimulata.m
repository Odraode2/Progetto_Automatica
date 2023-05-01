hp = 0.13
A = - 1/hp;
B = 1/hp;
C = 7725;
D = 0;

square = importdata("square.mat");
%vec_t = 0:square(1,2)-square(1,1):square(1,size(square,2));
sis = ss(A,B,C,D);
opt = stepDataOptions('stepAmplitude', 5);
[y,vec_t,x] = step(sis,square(1,:),opt);
figure
plot(vec_t,y)
hold on
plot(vec_t,square(4,:))

fineInteresse = 0;  %cerco l'ultimo istante in cui l'input (in square) è a 5
for i = 2:size(square,2)
    if square(2,i-1)==5 && square(2,i)==0
        fineInteresse = i-1;
        break;
    end
end

% errore medio di mia idea:
%errore assoluto E = sum (|y_stimata - y_data|)
%errore percentuale e = 100 * E/(sum(y_data))
y_data = square(4,1:fineInteresse).';
%% Errore relativo a valore assunto da y_data punto per punto
for p=1:length(y_data)
    if y_data(p)~=0
        vec2(p) = abs((y(p)-y_data(p))./y_data(p));
    else
        vec2(p)=abs(y(p));
    end
end

% %% Errore massimo relativo al valore di fondoscala
% vec = abs((y(1:fineInteresse)-y_data)./maxva);
% E = max(vec);
% e = 100*(E);
% figure (18)
% plot(vec, '-b')

%% errore bellino
errori=abs(y(1:fineInteresse)-y_data);
%lo normalizziamo perché edo rompe i coglioni
err_norm=((errori-min(errori))/(max(errori)-min(errori)));
figure('error')
plot(err_norm, 'b')
hold on
plot(vec2, 'r')


%% errore con minimo di funzione costo
