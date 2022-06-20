% Q3.3.1

panda = loadVid("../data/ar_source.mov");
book = loadVid("../data/book.mov");
vid = VideoWriter('vid.mp4', 'MPEG-4');

cv_cover = imread('../data/cv_cover.jpg');

open(vid);

% f1 = book(1).cdata;
% 
% I1gray = double(im2gray(f1));
% locsC1 = detectSURFFeatures(I1gray);
% [desc1, locs1] = extractFeatures(I1gray, locsC1.Location, 'Method', 'SURF');
% figure;
% imshow(im2gray(cv_cover))
% 
threshold = 10;

for i = 1:size(panda,2)
    disp(i)
    f1 = book(i).cdata;
    f2 = panda(i).cdata;
     
    cover_gray = im2gray(cv_cover);
%     locsC1 = detectSURFFeatures(cover_gray);

    I1gray = im2gray(f1);
%     locsC2 = detectSURFFeatures(I1gray);

%     figure;
% %     imshow(cv_cover)
% %     plot(locsC1);
% 
%     [desc1, locs1] = extractFeatures(cover_gray, locsC1.Location, "Method", "SURF");
%     [desc2, locs2] = extractFeatures(I1gray, locsC2.Location,  "Method", "SURF");
% 
%     matches = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'Unique',true);
% 
%     locs1 = locs1(matches(:,1),:);
%     locs2 = locs2(matches(:,2),:);
%     
%     disp(size(locsC1.Location));
%     disp(size(locsC2.Location))
%     showMatchedFeatures(cover_gray, I1gray, locs1, locs2, 'montage');

    [locs1, locs2] = matchPics(cover_gray, I1gray);

    disp(size(locs1))
    disp(size(locs2))

    [bestH2to1, inliers] = computeH_ransac(locs1, locs2);
    
    f2= imcrop(f2, [0 45 size(f2, 2) size(f2, 1)-90]);
    
    scaled_hp_img = imresize(f2, [size(cv_cover,1) size(cv_cover,2)]);
%     
% %     imshow(compositeH(inv(bestH2to1), scaled_hp_img, f1));
%     
    writeVideo(vid, compositeH(inv(bestH2to1), scaled_hp_img, f1));
%     if i == 1
%         break;
%     end
%     disp(i)
end

close(vid);