function A = hide2(C,hideinfo)

% convert str to bin stream
hideinfo = reshape(dec2bin(double(hideinfo),8).',[],1);
hideinfo = [hideinfo;'00000000'.'];   % add ending flag

% use magic(10) to select the blocks hiding information
I = cumsum(repmat(reshape(magic(10),1,[]),1,1000));
I = I(1:length(hideinfo));

A = reshape(C.',[],1);
A(I) = 2*floor(A(I)/2) + hideinfo - '0';

A = reshape(A,[],size(C,1)).';

end