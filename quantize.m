function A = quantize(P)
% divide P into 8*8 blocks
% dct2(block)
% quantize dct coefficient
% zig-zag

Q = [16 11 10 16 24 40 51 61;
12 12 14 19 26 58 60 55;
14 13 16 24 40 57 69 56;
14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77;
24 35 55 64 81 104 113 92;
49 64 78 87 103 121 120 101;
72 92 95 98 112 100 103 99];

P = double(P);
[height,width] = size(P);
A = [];

% make height,width of P multiples of 8
P(height+1:8*ceil(height/8),:) = repmat(P(height,:),8*ceil(height/8)-height,1);
P(:,width+1:8*ceil(width/8)) = repmat(P(:,width),1,8*ceil(width/8)-width);

for i = 1:ceil(height/8)
    for j = 1:ceil(width/8)
        A = [A,zigzag2(round(dct2(P((i-1)*8+1:i*8,(j-1)*8+1:j*8))./Q)).'];
    end
end

end

