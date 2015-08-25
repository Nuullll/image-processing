function [DC_stream,AC_stream,height,width] = jpeg(image)

C = quantize(image);

% DC coefficient
c = C(1,:);
% differential coding
c = [c(1),c(1:length(c)-1)-c(2:length(c))];
% Huffman coding
category = ceil(log2(abs(c)+1));
DC_stream = '';
for i = 1:length(category)
    magnitude = dec2bin(abs(c(i)));
    if c(i) < 0
        magnitude = char('1'-magnitude+'0');
    end
    DC_stream = [DC_stream,dc_huffman(category(i)),magnitude];
end



end

function str = dc_huffman(category)

if category == 0
    str = '00';
elseif category <= 5
    str = dec2bin(category+1);
    if category <= 2
        str = ['0',str];
    end
else
    str = ['1',dc_huffman(category-1)];
end

end

function str = ac_huffman(run,size)

switch run
    case 0
        switch size
            case 0
                str = '1010';
            case 1
                str = '00';
            case 2
                str = '01';
            case 3
                str = '100';
            case 4
                str = '1011';
            case 5
                str = '11010';
            case 6
                str = '111000';
            case 7
                str = '1111000';
            case 8
                str = '1111110110';
            case 9
                str = '1111111110000010';
            case 10
                str = '1111111110000011';
        end
    case 1
        switch size
            case 1
                str = '1100';
            case 2
                str = '111001';
            case 3
                str = '1111001';
            case 4
                str = '111110110';
            case 5
                str = '11111110110';
            case 6
                str = '1111111110000100';
            case 7
                str = '1111111110000101';
            case 8
                str = '1111111110000110';
            case 9
                str = '1111111110000111';
            case 10
                str = '1111111110001000';
        end
    case 2
        switch size
            case 1
                str = '11011';
            case 2
                str = '11111000';
            case 3
                str = '1111110111';
            case 4
                str = '1111111110001001';
            case 5
                str = '1111111110001010';
            case 6
                str = '1111111110001011';
            case 7
                str = '1111111110001100';
            case 8
                str = '1111111110001101';
            case 9
                str = '1111111110001110';
            case A
                str = '1111111110001111';
        end
    case 4
        switch size
            case 1
                str = '111011';
            case 2
                str = '1111111000';
            case 3
                str = '1111111110010111';
            case 4
                str = '1111111110011000';
            case 5
                str = '1111111110011001';
            case 6
                str = '1111111110011010';
            case 7
                str = '1111111110011011';
            case 8
                str = '1111111110011100';
            case 9
                str = '1111111110011101';
            case 10
                str = '1111111110011110';
        end
    case 8
        switch size
            case 1
                str = '11111010';
            case 2
                str = '111111111000000';
            case 3
                str = '1111111110110111';
            case 4
                str = '1111111110111000';
            case 5
                str = '1111111110111001';
            case 6
                str = '1111111110111010';
            case 7
                str = '1111111110111011';
            case 8
                str = '1111111110111100';
            case 9
                str = '1111111110111101';
            case 10
                str = '1111111110111110';
        end
    case 15
        switch size
            case 0
                str = '11111111001';
            case 1
                str = '1111111111110101';
            case 2
                str = '1111111111110110';
            case 3
                str = '1111111111110111';
            case 4
                str = '1111111111111000';
            case 5
                str = '1111111111111001';
            case 6
                str = '1111111111111010';
            case 7
                str = '1111111111111011';
            case 8
                str = '1111111111111100';
            case 9
                str = '1111111111111101';
        end
end

end