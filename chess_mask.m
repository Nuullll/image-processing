function masked_image = chess_mask(image,Nrow,Ncol)

image = double(image);

[height,width,~] = size(image);
grid_size = [ceil(height/Nrow),ceil(width/Ncol)];
[J,I] = meshgrid(1:width,1:height);
black_mask = (xor(mod(ceil(I/grid_size(1)),2),...
                  mod(ceil(J/grid_size(2)),2))==0);

cell = mat2cell(image,ones(1,height),ones(1,width),3);
cell(black_mask) = {reshape([0,0,0],1,1,3)};
masked_image = cell2mat(cell);

masked_image = uint8(masked_image);
         
end