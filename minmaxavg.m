function [ minmaxavg ] = minmaxavg( DESC )
min = DESC(1);
max = DESC(1);
sum = 0;
for i=1:length(DESC)
    if min >= DESC(i)
        min = DESC(i);
        minmaxavg(1) = i;
    end
    
    if max <= DESC(i)
        max = DESC(i);
        minmaxavg(2) = i;
    end
    
    sum = sum + DESC(i);
end

avg = sum / length(DESC);

for i=1:length(DESC)
    if DESC(i) ~= avg;
        minmaxavg(3) = i;
    end
end

end

