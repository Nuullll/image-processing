function A = hide1(C,hideinfo)

% convert str to bin stream
hideinfo = reshape(dec2bin(double(hideinfo),8).',[],1);
hideinfo = [hideinfo;'00000000'.'];   % add ending flag

A = reshape(C,[],1);
A(1:length(hideinfo)) = 2*floor(A(1:length(hideinfo))/2) + hideinfo - '0';

A = reshape(A,size(C,1),[]);

end