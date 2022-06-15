function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points

n = size(x1, 2);


matrix = zeros(2 * n, 9);

% % p_1 = ([x1; ones(1, n)])';
% % p_2 = ([x2; ones(1, n)])';
% 
p_1 = x1;
p_2 = x2;
% 
for i = 1:size(p_1,1)
   matrix(2 * i - 1, :) = [-p_2(i,1), -p_2(i,2), -1, 0, 0, 0, p_1(i,1) * p_2(i,1),p_1(i,1) * p_2(i,2), p_1(i,1)];
   matrix(2 * i, :) = [0, 0, 0, -p_2(i,1), -p_2(i,2), -1, p_1(i,2) * p_2(i,1),p_1(i,2) * p_2(i,2), p_1(i,2)];
end

% p1 = x1;
% p2 = x2;
% for i=1:size(p1,1)
%     matrix(2*i-1,:)=[-p1(i,1) -p1(i,2) -1 0 0 0 p1(i,1)*p2(i,1) p1(i,2)*p2(i,1) p2(i,1)] ;
%     matrix(2*i,:)=[0 0 0 -p1(i,1) -p1(i,2) -1 p1(i,1)*p2(i,2) p1(i,2)*p2(i,2) p2(i,2)];
% end

[vector, ~] = eig(matrix' * matrix);
H2to1 = reshape(vector(:,1), 3, 3);
H2to1 = H2to1';

end
