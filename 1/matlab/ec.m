
layers = get_lenet();

load lenet.mat

path = '/home/hieu/Desktop/School/CMPT/412/Project/1/project1_package/matlab/images/';
images = ["image1.JPG", "image2.JPG", "image3.png", "image4.jpg"];

pad = [50, 30, 20, 3];

for i = 1:4
    img = imread(path+images(i));
    if numel(size(img))>2
        img = rgb2gray(img); 
    end
    img = 255 - img; 

    se = strel('disk', 15);
    background = imopen(img, se);
    img = img - background; 
    img = imbinarize(img);
    img = bwareaopen(img, 5); 
    
    if i == 4
        se = strel('line', 5, 30);
        connected_img = imdilate(img, se);
        
        connected_img = padarray(connected_img, [1 1], 0, 'both');
        img = padarray(img, [1 1], 0, 'both');
        L = bwlabel(connected_img); 
    else
        L = bwlabel(img); 
    end

    boxes = regionprops(L, 'boundingbox'); 
    layers{1}.batch_size = length(boxes); 
    xtest = zeros([28*28 length(boxes)]);

    figure('NumberTitle', 'off', 'Name', images(i))
    imshow(img);

    for b = 1 : length(boxes)
        box = boxes(b).BoundingBox;
        rect = rectangle('Position', box, 'EdgeColor', 'r');
        
        digit = img(floor(box(2):box(2)+box(4)), floor(box(1):box(1)+box(3)));
        
        [m, n] = size(digit);
        if m > n
            digit = padarray(digit, [0 round((m-n)/2)], 0, 'both');
        elseif m < n
            digit = padarray(digit, [round((n-m)/2) 0], 0, 'both');
        end
        
        digit = padarray(digit, [pad(i) pad(i)], 0, 'both');
        
        digit = imresize(digit, [28 28]); 
        digit = im2double(digit);
        digit = reshape(digit', [28*28 1]); 
        xtest(:, b) = digit;
    end
    
    if i < 3
        ytest = [1 2 3 4 5 6 7 8 9 0] + 1;
    elseif i == 3
        ytest = [6 0 6 2 4] + 1;
    else
        ytest = [7 0 9 3 1 6 7 2 6 1 ...
                 3 9 6 4 1 4 2 0 0 5 ...
                 4 4 7 3 1 0 2 5 5 1 ...
                 7 7 4 9 1 7 4 2 9 1 ...
                 5 3 4 0 2 9 4 4 1 1] + 1;       
    end

    [output, P] = convnet_forward(params, layers, xtest);
    [M, ypred] = max(P);
    
    count = 0;
    for b = 1 : length(boxes)
        if ytest(b) == ypred(b)
            count = count + 1;
        end
    end
    
    disp(images(i));
    if i == 4
        disp('Actual label:');
        disp(reshape(ytest, 5, 10));
        disp('Predicted label:');
        disp(reshape(ypred, 5, 10));
    else
        disp('Actual label:');
        disp(ytest);
        disp('Predicted label:');
        disp(ypred);
    end
    acc = count/length(boxes);
    disp('The total number of digits:');
    disp(length(boxes));
    disp('The number of correct predicted label:');
    disp(count);
    disp('The prediction accuracy for the current image:');
    disp(acc);
    if acc<1
        C = confusionmat(ytest, ypred,'order',[1,2,3,4,5,6,7,8,9,10]);
        figure
        confusionchart(C);
    end
end

