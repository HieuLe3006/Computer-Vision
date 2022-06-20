clear all ;
 % Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');

maxDisp = 20; 
windowSize = 3;
dispM = get_disparity(im1, im2, maxDisp, windowSize);

% --------------------  get depth map

depthM = get_depth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);


% --------------------  Display

figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;

%------- After 
maxDisp = 20; 
windowSize = 3;

% save rectification
testRectify;

[rectIL, rectIR, bbL, bbR] = warp_stereo(im1, im2, M1, M2);

% figure;
% imshow(rectIL);
% figure;
% imshow(rectIR);

rectIL = rectIL(1:end, 400:end);
rectIR = rectIR(1:end, 1:end-400);

rectIL = imresize(rectIL, [640, 480]);
rectIR = imresize(rectIR, [640, 480]);

% Disparity
dispM_rectified = get_disparity(rectIL, rectIR, 20, 3);

% Depth Map
depthM_rectified = get_depth(dispM_rectified, K1n, K2n, R1n, R2n, t1n, t2n);

figure; imagesc(dispM_rectified.*(rectIL>40)); colormap(gray); axis image;
figure; imagesc(depthM_rectified.*(rectIL>40)); colormap(gray); axis image;