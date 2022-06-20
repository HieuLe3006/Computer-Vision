%Q2.2.4
clear all;
close all;


cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
hp_img = imread('../data/hp_cover.jpg');

if (size(cv_img,3)==3)
    cv_img=rgb2gray(cv_img);
end

if (size(desk_img,3)==3)
    desk_img=rgb2gray(desk_img);
end

if (size(hp_img,3)==3)
    hp_img=rgb2gray(hp_img);
end

cv_img = im2double(cv_img);
hp_img = im2double(hp_img);
desk_img = im2double(desk_img);

%% Extract features and match
[locs1, locs2] = matchPics(cv_img, desk_img);

%% Compute homography using RANSAC
[bestH2to1, ~] = computeH_ransac(locs1, locs2);

%% Scale harry potter image to template size
% Why is this is important?
scaled_hp_img = imresize(hp_img, [size(cv_img,1) size(cv_img,2)]);

%% Display warped image.
figure;
subplot(2,2,1), imshow(warpH(scaled_hp_img, inv(bestH2to1), size(desk_img)));

%% Display composite image
subplot(2,2,2), imshow(compositeH(inv(bestH2to1), scaled_hp_img, desk_img));
% compositeH(inv(bestH2to1), scaled_hp_img, desk_img)
