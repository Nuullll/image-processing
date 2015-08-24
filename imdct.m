function C = imdct(A,varargin)
% 2-dimension DCT for image A

A = double(A);
[height,width] = size(A);

% make height,width of A multiples of 8
A(height+1:8*ceil(height/8),:) = repmat(A(height,:),8*ceil(height/8)-height,1);
A(:,width+1:8*ceil(width/8)) = repmat(A(:,width),1,8*ceil(width/8)-width);

if nargin == 2
    procfun = varargin{1};
else
    procfun = @(x)(x);  % doing nothing
end

for i = 1:ceil(height/8)
    for j = 1:ceil(width/8)
        C((i-1)*8+1:i*8,(j-1)*8+1:j*8) = procfun(dct2(A((i-1)*8+1:i*8,(j-1)*8+1:j*8)));
    end
end

end