%% Load images
load('resource/hall.mat');
imwrite(hall_color,'images/hall_color.png');    % save original image
hall_color = double(hall_color);

%% Draw red circle
[height,width,~] = size(hall_color);
center = [(1+height)/2,(1+width)/2];
radius = min(height,width)/2;
[J,I] = meshgrid(1:width,1:height);
% <height-by-width matrix> I: I(x,y) equals x
% <height-by-width matrix> J: J(x,y) equals y
area = ((I-center(1)).^2 + (J-center(2)).^2 <= radius^2);
% area equals 1 @ point inside circle

cell = mat2cell(hall_color,ones(1,height),ones(1,width),3);
cell(area) = {reshape([255,0,0],1,1,3)};
hall_color = cell2mat(cell);

%% Write image
hall_color = uint8(hall_color);
imwrite(hall_color,'images/hall_color_red_circle.png');

