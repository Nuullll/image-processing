function [image,info] = dejpeg_extract(DC_stream,AC_stream,height,width,QTAB,DCTAB,ACTAB,extractfun)
% jpeg decoder

% decode DC_stream
C(1,:) = decode_dc(DC_stream,DCTAB);

% decode AC_stream
C(2:64,:) = decode_ac(AC_stream,ACTAB);

% extract hiden information
info = extractfun(C);

% inverse Zig-Zag, inverse quantive, IDCT
image = [];
W = ceil(width/8);
for j = 1:size(C,2)
    col = C(:,j);
    mat = idct2(izigzag(col).*QTAB) + 128;
    I = ceil(j/W);
    J = mod(j-1,W)+1;
    image((I-1)*8+1:I*8,(J-1)*8+1:J*8) = mat;
end

image = image(1:height,1:width);
image = uint8(image);

end



function c = decode_dc(DC_stream,DCTAB)

c = [];
category = 0;

% sort rows of DCTAB
DCTAB = sortrows(DCTAB,2:size(DCTAB,2));

while ~isempty(DC_stream)
    % decode Huffman
    for i = 1:size(DCTAB,1)
        row = DCTAB(i,:);
        L = row(1);
        code = num2str(row(2:L+1),'%d');

        if strcmp(DC_stream(1:L),code)
            category = i - 1;
            DC_stream = DC_stream(L+1:end);
            break
        end
    end
    
    magnitude = DC_stream(1:category);
    DC_stream = DC_stream(category+1:end);
    if isempty(magnitude)
        error = 0;
    elseif magnitude(1) == '0'
        % negative
        magnitude = char('1'-magnitude+'0');
        error = -bin2dec(magnitude);
    else
        % positive
        error = bin2dec(magnitude);
    end
    
    if isempty(c)
        c = error;
    else
        c = [c,c(end)-error];
    end
    
end

end



function C = decode_ac(AC_stream,ACTAB)

% sort rows of ACTAB
ACTAB = sortrows(ACTAB,4:size(ACTAB,2));

c = [];
C = [];

while ~isempty(AC_stream)
    % decode Huffman
    for i = 1:size(ACTAB,1)
        row = ACTAB(i,:);
        L = row(3);
        code = num2str(row(4:L+3),'%d');
        
        if L == 4 && strcmp(AC_stream(1:L),'1010')   % EOB
            c = [c;zeros(63-length(c),1)];  % add trailing zeros
            C = [C,c];
            c = [];
            AC_stream = AC_stream(L+1:end);
            break
        elseif L == 11 && strcmp(AC_stream(1:L),'11111111001')   % ZRL
            c = [c;zeros(16,1)];    % add 16 zeros
            AC_stream = AC_stream(L+1:end);
            break
        elseif strcmp(AC_stream(1:L),code)
            Run = row(1);
            Size = row(2);
            AC_stream = AC_stream(L+1:end);
            amplitude = AC_stream(1:Size);
            AC_stream = AC_stream(Size+1:end);
            
            if amplitude(1) == '0'
                % negative
                amplitude = char('1'-amplitude+'0');
                coeff = -bin2dec(amplitude);
            else
                % positive
                coeff = bin2dec(amplitude);
            end
            
            c = [c;zeros(Run,1);coeff];
            break
        end
    end
end

end



function mat = izigzag(vector)

index = [1,2,6,7,15,16,28,29,...
3,5,8,14,17,27,30,43,...
4,9,13,18,26,31,42,44,...
10,12,19,25,32,41,45,54,...
11,20,24,33,40,46,53,55,...
21,23,34,39,47,52,56,61,...
22,35,38,48,51,57,60,62,...
36,37,49,50,58,59,63,64];

mat = reshape(vector(index),8,8).';

end
            
