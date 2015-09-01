function A = hide3(C,hideinfo)

% convert str to bin stream
hideinfo = reshape(dec2bin(double(hideinfo),8).',[],1);
hideinfo = [hideinfo;'00000000'.'];   % add ending flag

% convert to 1,-1 sequence
hideinfo = 2*(hideinfo-'0')-1;

for j = 1:length(hideinfo)
    col = C(:,j);
    last = find(col~=0,1,'last');
    if last == length(col)
        C(last,j) = hideinfo(j);
    else
        C(last+1,j) = hideinfo(j);
    end
end
    
A = C;

end