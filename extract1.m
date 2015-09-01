function info = extract1(C)

A = reshape(C,[],1);
info = num2str(mod(A(1:8*floor(length(A)/8)),2),'%d');
info = reshape(info,8,[]).';
info = char(bin2dec(info)).';

index = find(info==0);
if isempty(index)
    info = '';
else
    info = info(1:index);
end

end