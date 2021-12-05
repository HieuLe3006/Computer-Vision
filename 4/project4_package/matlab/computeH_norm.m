function [H2to1] = computeH_norm(x1, x2)

n = size(x1, 1);

%% Compute centroids of the points
centroid1 = double(sum(x1) / n);
centroid2 = double(sum(x2) / n);

%% Shift the origin of the points to the centroid
T1 = [1 0 centroid1(1); 0 1 centroid1(2); 0 0 1];
T2 = [1 0 centroid2(1); 0 1 centroid2(2); 0 0 1];
% T1 = [1, 0, centroid1(1);0,1,centroid1(2);0,0,1];
% T2 = [1, 0, centroid2(1);0,1,centroid2(2);0,0,1];

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
mean1 = mean( sqrt(x1.^2));
mean2 = mean( sqrt(x2.^2));

scale1 = [sqrt(2)/mean1(1) sqrt(2)/mean1(2)];
scale2 = [sqrt(2)/mean2(1) sqrt(2)/mean2(2)];

scale1 = [scale1(1) 0 0; 0 scale1(2) 0; 0 0 1];
scale2 = [scale2(1) 0 0; 0 scale2(2) 0; 0 0 1];

%% similarity transform 1
T1 = scale1 * T1;
% disp(size(x1))
% disp(size(ones(1, n_1)'))
% disp(size(T1))
% disp(size(p1))

%% similarity transform 2
T2 = scale2 * T2; 

%% Compute Homography
% Norm1 = (T1 * p1.').';
% Norm2 = (T2 * p2.').';
fill = ones(size(x2,1), 1);
p1 = ([x1 fill].');
p2 = ([x2 fill].');
Norm1 = [T1*p1].';
Norm2 = [T2*p2].';
NormH2to1 = computeH(Norm1(:,1:2), Norm2(:,1:2));

%% Denormalization
H2to1 = inv(T1)*NormH2to1*T2 % The document only says to call computeH(x1, x2) and where coordinates in x1, and x2 are normalized. 

end
