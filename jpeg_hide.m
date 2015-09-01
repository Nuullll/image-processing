function [DC_stream,AC_stream,height,width] = jpeg_hide(image,QTAB,DCTAB,ACTAB,hidefun,hideinfo)

C = quantize(double(image)-128,QTAB);
[height,width] = size(image);

% hide info
C = hidefun(C,hideinfo);

% DC coefficient
c = C(1,:);
% differential coding
c = [c(1),-diff(c)];
% Huffman coding
category = ceil(log2(abs(c)+1));
DC_stream = '';
for i = 1:length(category)
    magnitude = dec2bin(abs(c(i)));
    if c(i) < 0
        % 1's complement
        magnitude = char('1'-magnitude+'0');
    elseif c(i) == 0
        magnitude = '';
    end
    DC_stream = [DC_stream,dc_huffman(category(i),DCTAB),magnitude];
end

AC_stream = '';
% AC coefficient
for j = 1:size(C,2)
    col = C(2:end,j);
    runs = diff([0;find(col~=0)]) - 1;
    
    nonzeros = col(col~=0);
    
    for i = 1:length(nonzeros)
        amplitude = dec2bin(abs(nonzeros(i)));
        if nonzeros(i) < 0
            % 1's complement
            amplitude = char('1'-amplitude+'0');
        end

        Size = length(amplitude);
        Run = runs(i);
        
        if Run >= 16    %ZRL
            AC_stream = [AC_stream,repmat(ac_huffman(15,0,ACTAB),1,floor(Run/16))];
            Run = mod(Run,16);
        end
        
        AC_stream = [AC_stream,ac_huffman(Run,Size,ACTAB),amplitude];
    end
    
    AC_stream = [AC_stream,ac_huffman(0,0,ACTAB)];    % EOB
    
end

% save('result\jpegcodes.mat','DC_stream','AC_stream','height','width');

end



function str = dc_huffman(category,DCTAB)

L = DCTAB(category+1,1);

str = num2str(DCTAB(category+1,2:L+1),'%d');

end



function str = ac_huffman(run,size,ACTAB)

if run == 0 && size == 0    % EOB
    str = '1010';
elseif run == 15 && size == 0   % ZRL
    str = '11111111001';
else
    L = ACTAB(run*10+size,3);
    str = num2str(ACTAB(run*10+size,4:L+3),'%d');
end

end