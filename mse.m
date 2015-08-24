function [result] = mse(A,B)
% Mean Square Error

result = sum(sum((A-B).^2))/size(A,1)/size(A,2);

end

