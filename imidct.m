function I = imidct(C)
% 2-dimension IDCT for coefficent C

for i = 1:size(C,1)/8
    for j = 1:size(C,2)/8
        I((i-1)*8+1:i*8,(j-1)*8+1:j*8) = idct2(C((i-1)*8+1:i*8,(j-1)*8+1:j*8));
    end
end

I = uint8(I);

end

