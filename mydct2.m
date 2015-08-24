function C = mydct2(P)
% 2-dimension DCT

P = double(P);
N = size(P,1);  % Assuming that P is a square matrix

[J,I] = meshgrid(1:2:2*N-1, 0:N-1);

D = sqrt(2/N) * cos(I.*J*pi/2/N);
D(1,:) = ones(1,N)/sqrt(N);

C = D*P*D.';

end

