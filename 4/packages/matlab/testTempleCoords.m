% A test script using templeCoords.mat
%
% Write your code here
%

im1 = imread('../data/im1.png');
im2 = imread('../data/im1.png');

load('../data/someCorresp.mat');
F = eightpoint(pts1, pts2, M);

load('../data/templeCoords.mat');
pts2 = epipolarCorrespondence(im1, im2, F, pts1);

load('../data/intrinsics.mat');
E = essentialMatrix(F, K1, K2);

p1 = [eye(3) zeros(3,1)];
p2 = camera2(E);

for i = 1:size(p2,2)
    points = triangulate(K1*p1, pts1, K2*p2(:,:,i), pts2);
    if all(points(:,3) > 0)
        updatedP2 = p2(:,:,i);
        points3d = points;
    end
end

R1=p1(:,1:3);
t1=p1(:,4);
R2=updatedP2(:,1:3);
t2=updatedP2(:,4);

% figure;
% plot3(points3d(:,1),points3d(:,2),points3d(:,3),'.');
% axis equal

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

%% Test eightpoints
% displayEpipolarF(im1, im2, F);

%% Test epipolar correspondences
% epipolarMatchGUI(im1, im2, F);

%% Test triangulation
% load('../data/someCorresp.mat');
% p1 = [eye(3) zeros(3,1)];
% p2 = camera2(E);
% triangulate_test = triangulate(K1*p1, pts1, K2*p2(:,:,1), pts2);


