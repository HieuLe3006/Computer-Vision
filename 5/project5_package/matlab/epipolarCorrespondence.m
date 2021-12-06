function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
% 
pts2 = zeros(size(pts1,1),size(pts1,2));
if(ndims(im1) == 3)
    im1 = rgb2gray(im1);
end

if(ndims(im2) == 3)
    im2 = rgb2gray(im2);
end
%% Using size window
% % define window
% w_size = 5;
% least_dist = inf;
% 
% % candidate points
% x2=0;
% y2=0;
% 
% for i = 1:size(pts1,1)
%     % epipolar line
%     eline = F * [pts1(i,:), 1]';
%     x1 = pts1(i,1);
%     y1 = pts1(i,2);
%     if y1-w_size>0 && y1+w_size<=size(im1,1) 
%         img1_window =  double(im1(y1:y1+w_size, x1-w_size:x1+w_size));
%         for j = 1+w_size : size(im2,1)-w_size
%             temp = round(-(eline(1)*j + eline(3))/eline(2));
%             if temp-w_size>0 && temp+w_size<=size(im2,2)               
%                 img2_window = double(im2(j:j+w_size, temp-w_size:temp+w_size));
%                 dist = sqrt(sum((img1_window(:) - img2_window(:)).^2));
%                 if dist<least_dist
%                     least_dist = dist;
%                     x2 = temp;
%                     y2 = j;
%                 end
%             end
%         end
%      end
%    
% end
% 
% pts2(1,1) = x2;
% pts2(1,2) = y2;
%% Using match feature
p1 = [pts1(:,1) pts1(:,2) ones(size(pts1,1),1)];

% epipolar line
eline = zeros(size(pts1,1), 3);
for i=1:size(pts1,1)
   eline(i,:) = reshape(F*reshape(p1(i,:), [3 1]), [1 3]);
end

% candidate points
disp(size(pts1))
for i=1:size(eline(:,1),1)
    xs = zeros(size(im2,2),2);
    for j=1:size(im2,2)
        temp = round(-(eline(1)*j + eline(3))/eline(2));
        xs(j,:) = [j temp];
    end
    
    [desc1, ~] = extractFeatures(im1, pts1(i,:));
    [desc2, l2] = extractFeatures(im2, xs);
    
    indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', 100, 'MaxRatio', 0.99);
    matched_points = l2(indexPairs(:,2),:);
   
    if(size(matched_points,1)==0)
        pts2(i,:) = pts1(i,:);
    else
        pts2(i,:) = matched_points;
    end
end
