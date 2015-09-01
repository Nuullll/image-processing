function info = extract2(C)

A = reshape(C.',[],1);
info = num2str(mod(A,2),'%d');

I = cumsum(repmat(reshape(magic(10),1,[]),1,100));
if I(end) > length(info)
    I = I(1:find(I>length(info))-1);
end
I = I(1:8*floor(length(I)/8));
info = info(I);

info = reshape(info,8,[]).';
info = char(bin2dec(info)).';

index = find(info==0);
if isempty(index)
    info = '';
else
    info = info(1:index);
end

end