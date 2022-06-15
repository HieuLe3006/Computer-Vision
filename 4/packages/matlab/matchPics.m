function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
I1gray = im2gray(I1);
I2gray = im2gray(I2);

%% Detect features in both images
locsC1 = detectFASTFeatures(I1gray)
locsC2 = detectFASTFeatures(I2gray)

%% Obtain descriptors for the computed feature locations
[desc1, locs1] = computeBrief(I1gray, locsC1.Location)	
[desc2, locs2] = computeBrief(I2gray, locsC2.Location)

%% Match features using the descriptors
threshold = 10;
disp(threshold);
matches = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'MaxRatio', 0.75)

locs1 = locs1(matches(:, 1), :);
locs2 = locs2(matches(:, 2), :);

showMatchedFeatures(I1, I2, locs1, locs2, 'montage'); 

end

