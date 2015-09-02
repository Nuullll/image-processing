function d = distance(u,v)
% Assuming sum(u)==1 and sum(v)==1

d = 1 - sum((u.*v).^0.5);

end