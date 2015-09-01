function A = hide(image,str)

% convert str to bin stream
info = reshape(dec2bin(double(str),8).',[],1);
info = [info;'00000000'.'];   % add ending flag

A = reshape(image,[],1);
A = dec2bin(A,8);

% substitute lowest bit
A(1:length(info),end) = info;
A = uint8(bin2dec(A));
A = reshape(A,size(image,1),size(image,2),[]);

end