function info = extract(image)

A = dec2bin(reshape(image,[],1),8);

info = A(1:8*floor(end/8),8);
info = reshape(info,8,[]).';
info = char(bin2dec(info)).';
% find ending flag
index = find(info==0,1);
if isempty(index)
    info = '';
else
    info = info(1:index);
end

end