function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

% Normalize points
pts1 = pts1/M;
pts2 = pts2/M;

x1 = pts1(:,1);
y1 = pts1(:,2);
x2 = pts2(:,1);
y2 = pts2(:,2);

% Nx9 matrix A
N = size(pts1, 1);
A = [x2.*x1 x2.*y1 x2 y2.*x1 y2.*y1 y2 x1 y1 ones(N,1)];

% Get F
[~,~,V] = svd(A);
F = reshape(V(:,end),3,3);

% Enforce rank 2 contraint
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';

% Unnormalize F
T = diag([1/M 1/M 1]);
F = T'*F*T; 

% Refine solution
F = refineF(F,pts1,pts2);

end


