function v = train(set,L)

for i = 1:length(set)
    v(i,:) = imchar(set{i},L);
end

v = mean(v).';

end