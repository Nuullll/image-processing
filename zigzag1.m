function v = zigzag1(A)
% A is square

% define direction
E = 1;
SW = 2;
S = 3;
NE = 4;

v = [];
N = size(A,1);
i = 1; j = 1;
direction = NE;
while i <= N && j <= N
    v = [v,A(i,j)];
    
    if i+j < N+1
        if direction == NE && i == 1  % move East
            direction = E;
            j = j + 1;
        elseif direction == SW && j == 1     % move South
            direction = S;
            i = i + 1;
        elseif direction == E || direction == SW   % move SW
            direction = SW;
            i = i + 1;
            j = j - 1;
        else
            direction = NE;
            i = i - 1;
            j = j + 1;
        end
    elseif i+j == N+1
        if direction == SW && i == N
            direction = E;
            j = j + 1;
        elseif direction == NE && j == N
            direction = S;
            i = i + 1;
        elseif direction == E || direction == SW
            direction = SW;
            i = i + 1;
            j = j - 1;
        else
            direction = NE;
            i = i - 1;
            j = j + 1;
        end
    else
        if direction == SW && i == N  % move East
            direction = E;
            j = j + 1;
        elseif direction == NE && j == N     % move South
            direction = S;
            i = i + 1;
        elseif direction == S || direction == SW   % move SW
            direction = SW;
            i = i + 1;
            j = j - 1;
        else
            direction = NE;
            i = i - 1;
            j = j + 1;
        end
    end
end
    
end

