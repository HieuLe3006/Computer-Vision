function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
N = size(pts1,1);
pt1 = [pts1'; ones(1, N)];
pt2 = [pts2'; ones(1, N)];


for i = 1:N
    r1 = pt1(:, i);
    r2 = pt2(:, i);

    x1 = r1(1);
    y1 = r1(2);

    x2 = r2(1);
    y2 = r2(2);

%     x1 = pt1(i,1);
%     y1 = pt1(i,2);
% 
%     x2 = pt2(i,1);
%     y2 = pt2(i,2);

    A = [P1(3,:)*y1 - P1(2,:);
         -P1(1,:) + P1(3,:)*x1;
         P2(3,:)*y2 - P2(2,:);
         -P2(1,:) + P2(3,:)*x2];

    [~,S,V] = svd(A);

    [~,num] = min(diag(S));

    points = V(:, num);
    
    % Normalized
    pts3d(:,i) = points/points(4);  
end

re_proj1 = P1*pts3d;
re_proj2 = P2*pts3d;

pts3d = pts3d(1:3,:)';
display(pts3d);

% Reprojected points:
reproj_error1 = 0;
reproj_error2 = 0;

% Convert to Homogeneous 
for i = 1:size(re_proj1,2)
    re_proj1(:,i) = re_proj1(:,i)/re_proj1(3,i);
    re_proj2(:,i) = re_proj2(:,i)/re_proj2(3,i);

    error1 = sqrt((pt1(1,i)-re_proj1(1,i)).^2 + (pt1(2,i)-re_proj1(2,i)).^2)/size(re_proj1,2);
    error2 = sqrt((pt2(1,i)-re_proj2(1,i)).^2 + (pt2(2,i)-re_proj2(2,i)).^2)/size(re_proj2,2);

    % Reprojection error (Euclidiean error)
    reproj_error1 = reproj_error1 + error1;
    reproj_error2 = reproj_error2 + error2;
end

% reproj_error1 = mean(sum(sqrt((pt1-re_proj1).^2)));
% reproj_error2 = mean(sum(sqrt((pt2-re_proj2).^2)));
disp(reproj_error1);
disp(reproj_error2);
