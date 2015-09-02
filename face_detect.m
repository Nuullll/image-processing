function marked_image = face_detect(image,L,v,a,e1,e2)
% image: input rgb image
% L: number of colors equals 2^(3*L)
% v: standard characteristic vector
% a: size of small blocks
% e1: higher threshold
% e2: lower threshold

image = double(image);
[height,width,~] = size(image);
take_block = @(A,i,j,h,w)(A(i:i+h-1,j:j+w-1,:));

%% detect roughly in small a-by-a blocks
I = []; J = []; H = []; W = [];
% extend image properly
image(height+1:a*ceil(height/a),:,:) = repmat(image(height,:,:),a*ceil(height/a)-height,1);
image(:,width+1:a*ceil(width/a),:) = repmat(image(:,width,:),1,a*ceil(width/a)-width);
% detect faces @e1
for i = 1:a:a*ceil(height/a)
    for j = 1:a:a*ceil(width/a)
        block = take_block(image,i,j,a,a);
        u = imchar(block,L);
        if distance(u,v) < e1
            % merge adjacent blocks
            ismerged = 0;
            for n = 1:length(I)
                if i >= I(n)-a && i <= I(n)+H(n) && ...
                        j >= J(n)-a && j <= J(n)+W(n)
                    ismerged = 1;
                    H(n) = max(I(n)+H(n),i+a) - min(i,I(n));
                    W(n) = max(J(n)+W(n),j+a) - min(j,J(n));
                    I(n) = min(i,I(n));
                    J(n) = min(j,J(n));
                    break
                end
            end
            if ~ismerged
                I = [I,i]; J = [J,j]; W = [W,a]; H = [H,a];
            end
        end
    end
end


%% expand block size
for n = 1:length(I)
    i = I(n); j = J(n); h = H(n); w = W(n);
    block = take_block(image,i,j,h,w);
    d = distance(imchar(block,L),v);
    % expand left
    while 1
        j = j-a;
        w = w+a;
        if j < 1
            w = w-a;
            j = j+a;
            break
        end
        new_block = take_block(image,i,j,h,w);
        new_d = distance(imchar(new_block,L),v);
        if new_d > d
            w = w-a;
            j = j+a;
            break
        end
        d = new_d;
    end
    % expand down
    while 1
        h = h+a;
        if i+h-1 > height
            h = h-a;
            break
        end
        new_block = take_block(image,i,j,h,w);
        new_d = distance(imchar(new_block,L),v);
        if new_d > d
            h = h-a;
            break
        end
        d = new_d;
    end
    % expand right
    while 1
        w = w+a;
        if j+w-1 > width
            w = w-a;
            break
        end
        new_block = take_block(image,i,j,h,w);
        new_d = distance(imchar(new_block,L),v);
        if new_d > d
            w = w-a;
            break
        end
        d = new_d;
    end
    % expand up
    while 1
        i = i-a;
        h = h+a;
        if i < 1
            h = h-a;
            i = i+a;
            break
        end
        new_block = take_block(image,i,j,h,w);
        new_d = distance(imchar(new_block,L),v);
        if new_d > d
            h = h-a;
            i = i+a;
            break
        end
        d = new_d;
    end
    if d < e2
        image = draw_rectangle(image,i,j,h,w);
    end
end

marked_image = uint8(image(1:height,1:width,:));

end

function marked_image = draw_rectangle(image,i,j,h,w)

[height,width,~] = size(image);
image = double(image);

area = boolean(zeros(height,width));
area(i:i+h-1,j:j+2) = ones(h,3);
area(i:i+h-1,j+w-3:j+w-1) = ones(h,3);
area(i:i+2,j:j+w-1) = ones(3,w);
area(i+h-3:i+h-1,j:j+w-1) = ones(3,w);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
R(area) = 255;
G(area) = 0;
B(area) = 0;
marked_image(:,:,1) = R;
marked_image(:,:,2) = G;
marked_image(:,:,3) = B;

end