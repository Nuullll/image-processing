function u = imchar(image,L)
% return the LENGTH 2^(3*L) characteristic vector of image (rgb image)

[height,width,~] = size(image);
image = double(image);
N = zeros(2^L,2^L,2^L);

for i = 1:height
    for j = 1:width
        RGB = image(i,j,:);
        % category of RGB
        category = floor(RGB/2^(8-L)) + 1;
        N(category(3),category(2),category(1)) = N(category(3),category(2),category(1)) + 1;
    end
end
u = reshape(N,[],1)/height/width;

end

