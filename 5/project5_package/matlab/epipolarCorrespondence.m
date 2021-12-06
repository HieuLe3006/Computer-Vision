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

pts2 = zeros(size(pts1,1) , 2);

x1 = pts1(:,1);
y1 = pts1(:,2);

% epipolar line
p1 = [x1; y1; 1];
eline = F*p1;

% define window
w_size = 5;

least_dist = 10000;

% candidate points
x2=0;
y2=0;

for i = 1:size(pts1,1)
    x1 = pts1(i,1);
    y1 = pts1(i,2);
    x_temp = round(-(eline(1)*i + eline(3))/eline(2)); 
    if y1-w_size>0 && y1+w_size<=size(im1,1)
        img1_window =  double(im1(y1 - w_size:y1+w_size, x1-w_size:x1+w_size));
        for j = i + w_size: size(im2,2) - w_size
            if j-w_size>0 && j+w_size<=size(im2,1)
                  img2_window = double(im2(j-w_size:j+w_size, x_temp-w_size:x_temp+w_size));
                  dist = norm(sqrt((img1_window-img2_window).^2));
                  if dist<least_dist
                      least_dist = dist;
                      x2 = x_temp;
                      y2 = j;
                  end
            end
        end
     end
   
end


pts2(1,1) = x2;
pts2(1,2) = y2;

end