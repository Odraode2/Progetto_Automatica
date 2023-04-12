data = square;
t = -1;
position = -1;
maxv = data(4,1);
% for i = 1:length(data(4,:))
%     if data(4,i)>(3.87*(10^4))
%         t = data(1,i)
%         position = i
%         return
%     end
% end

for i = 1:length(data(4,:))
    if data(4,i)>maxv
        maxv = data(4,i);
        position = i;
        t = data(1,i);
    end
end