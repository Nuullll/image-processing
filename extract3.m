function info = extract3(C)

info = [];

for j = 1:size(C,2)
    col = C(:,j);
    info = [info,col(find(col~=0,1,'last'))];
end

info = info(abs(info)==1);
% convert 1,-1 sequence to bin str
info = char((info+1)/2 + '0');
info = info(1:8*floor(length(info)/8));
info = reshape(info,8,[]).';
info = char(bin2dec(info)).';

index = find(info==0);
if isempty(index)
    info = '';
else
    info = info(1:index);
end

end