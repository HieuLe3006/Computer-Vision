% Your solution to Q2.1.5 goes here!
function briefRotTest
%% Read the image and convert to grayscale, if necessary
im = imread('../data/cv_cover.jpg');

num = zeros(1,37);


% if size(im,3) == 3
%     im = rgb2gray(im);
% end
%  
% im = im2double(im);

I1gray = im;
threshold = 10
num = []

for i = 0:36
    %% Rotate image
    im_rot = imrotate(im,i*10);

%     if size(im_rot,3) == 3
%         im_rot = rgb2gray(im_rot);
%     end
% 
%     im_rot = im2double(im_rot);
    
    I2gray = im_rot;

    %% Detect features in both images
    locsC1 = detectFASTFeatures(I1gray)
    locsC2 = detectFASTFeatures(I2gray)
    
%     locsC1 = detectSURFFeatures(I1gray)
%     locsC2 = detectSURFFeatures(I2gray)

    %% Obtain descriptors for the computed feature locations
    [desc1, locs1] = computeBrief(I1gray, locsC1.Location)	
    [desc2, locs2] = computeBrief(I2gray, locsC2.Location)

%     [desc1, locs1] = extractFeatures(I1gray, locsC1, 'Method', 'SURF') 
%     [desc2, locs2] = extractFeatures(I2gray, locsC2, 'Method', 'SURF') 

    %% Match features
    matches = matchFeatures(desc1, desc2, 'MatchThreshold', 8, 'MaxRatio', 0.8)
    p_1 = locs1(matches(:,1),:)
    p_2 = locs2(matches(:,2),:)
    
    disp(size(p_1))
    disp(size(p_2))
      

    %% Update histogram
    num = [num, size(matches(:,1), 1)];
    
%     if i == 35
%         figure;
%         h = [];
%         h(1) = subplot(2,2,1);
%         h(2) = subplot(2,2,2);
%         h(3) = subplot(2,2,3);
%         h(4) = subplot(2,2,4);
%         result = computeH(p_1, p_2)
%         disp(result)
%         subplot(2,2,1), plot(result)
%         subplot(2,2,2), imshow(im)
%         subplot(2,2,3), imshow(im_rot)
%         subplot(2,2,4), imshow(result)
%     end
    
end

%% Test computeH
% im_rot = imrotate(im,20*10);
% locsC1 = detectFASTFeatures(im)
% locsC2 = detectFASTFeatures(im_rot)
% [desc1, locs1] = computeBrief(im, locsC1.Location)	
% [desc2, locs2] = computeBrief(im_rot, locsC2.Location)
% matches = matchFeatures(locs1, locs2, 'MatchThreshold', threshold)
% p_1 = locs1(matches(:,1),:)
% p_2 = locs2(matches(:,2),:)
% result = computeH(p_1, p_2);
% tf2 = projective2d(result');
% out2 = imwarp(im_rot, tf2);
% figure;
% subplot(2,2,1), imshow(im);
% subplot(2,2,2), imshow(im_rot);
% subplot(2,2,3), imshow(out2);

%% Test computeH_norm
% im_rot = imrotate(im,20*10);
% locsC1 = detectFASTFeatures(im)
% locsC2 = detectFASTFeatures(im_rot)
% [desc1, locs1] = computeBrief(im, locsC1.Location)	
% [desc2, locs2] = computeBrief(im_rot, locsC2.Location)
% matches = matchFeatures(locs1, locs2, 'MatchThreshold', threshold)
% p_1 = locs1(matches(:,1),:)
% p_2 = locs2(matches(:,2),:)
% result = computeH_norm(p_1, p_2);
% tf2 = projective2d(result');
% out2 = imwarp(im, tf2);
% figure;
% subplot(2,2,1), imshow(im);
% subplot(2,2,2), imshow(im_rot);
% subplot(2,2,3), imshow(out2);

%% Test computeH_ransac
% im_rot = imrotate(im,20*10);
% if (size(im_rot,3)==3)
%     im_rot=rgb2gray(im_rot);
% end
% 
% im_rot = im2double(im_rot);
% 
% if (size(im,3)==3)
%     im=rgb2gray(im);
% end
% 
% im = im2double(im);
% 
% locsC1 = detectFASTFeatures(im)
% locsC2 = detectFASTFeatures(im_rot)
% [desc1, locs1] = computeBrief(im, locsC1.Location)	
% [desc2, locs2] = computeBrief(im_rot, locsC2.Location)
% threshold = 10;
% matches = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'MaxRatio', 0.8)
% p_1 = locs1(matches(:,1),:)
% p_2 = locs2(matches(:,2),:)
% figure;
% showMatchedFeatures(im, im_rot, p_1, p_2, 'montage'); 
% result = computeH_ransac(p_1, p_2);
% % disp(size(result));
% % disp(result);
% tf2 = projective2d(result');
% out2 = imwarp(im, tf2); 
% % figure;
% subplot(2,2,1), imshow(im);
% subplot(2,2,2), imshow(im_rot);
% subplot(2,2,3), imshow(out2);

%% Display histogram

bar(0:10:360,num);
xlabel('Rotation Deg')
ylabel('Num of matches')
end