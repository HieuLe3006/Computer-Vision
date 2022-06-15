function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3 

n=size(locs1,1);

inliers = zeros(n, 1);

% disp(size(locs2))
% disp(size(ones(n,1)))
homocoor = horzcat(locs2, ones(n, 1));
for i = 1:1000
    % 4 point-pairs (corresponding)
%     disp(size(locs1,1));
%     disp(size(locs1,2));
%     disp(i);
%     if size(locs1,1) < 4
%        random = randperm(size(locs1,1), size(locs1,1));
%     else
%        random = randperm(size(locs1,1),4);
%     end
    random = randperm(n,4);

    locs1_random = locs1(random,:);
    locs2_random = locs2(random,:);

    result_H = computeH(locs1_random,locs2_random);

    temp = (result_H * homocoor')';
    
    locs2to1 = temp(:, 1:2) ./ temp(:, 3);
    
    det = vecnorm(locs2to1 - locs1, 2, 2);   

    new_inliers = det < 10;
    if sum(new_inliers) > sum(inliers)
        inliers = new_inliers;
    end
end

indices = find(inliers~=0);

inliers1 = locs1(indices,:);
inliers2 = locs2(indices,:);

bestH2to1 = computeH_norm(inliers1, inliers2);

end

