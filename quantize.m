function A = quantize(P,QTAB)
% divide P into 8*8 blocks
% dct2(block)
% quantize dct coefficient
% zig-zag

P = double(P);
[height,width] = size(P);
A = [];

% make height,width of P multiples of 8
P(height+1:8*ceil(height/8),:) = repmat(P(height,:),8*ceil(height/8)-height,1);
P(:,width+1:8*ceil(width/8)) = repmat(P(:,width),1,8*ceil(width/8)-width);

for i = 1:ceil(height/8)
    for j = 1:ceil(width/8)
        A = [A,zigzag2(round(dct2(P((i-1)*8+1:i*8,(j-1)*8+1:j*8))./QTAB)).'];
    end
end

end

