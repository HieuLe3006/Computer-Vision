function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

mask = ones(windowSize, windowSize);

[row, col] = size(im1);

disp = zeros(row, col, maxDisp+1);

temp = zeros(row, col);

for i=0:maxDisp
    temp(1:(row*(col-i))) = (im1((1:(row * (col-i))) + row*i) - im2(1:(row * (col-i)))).^2;
    
    disp(:,:, i+1) = conv2(temp, mask, 'same');
end

[~, index] = min(disp, [], 3);
dispM = index-1;

end