% A test script using templeCoords.mat
%
% Write your code here
%


im1 = imread('../data/im1.png');
im2 = imread('../data/im1.png');
load('../data/someCorresp.mat');
F = eightpoint(pts1, pts2, M);
load('../data/intrinsics.mat');
E = essentialMatrix(F, K1, K2);

% % Test eightpoints
% displayEpipolarF(im1, im2, F);

% % Test epipolar correspondences
epipolarMatchGUI(im1, im2, F);


% save extrinsic parameters for dense reconstruction
% save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
