function [outImg] = D_SwirlFilter(inImg, factor, ox, oy)
% factor: [-1, 1]
% Resource: 
% 1. Lecture note of Polytechnic University, Brooklyn
% 2. Lecture 1 on wk 3.
% 
% Direction:
% 1. Using ox, oy, find min/max x, y index to compute
%       radius = min(x, y, row-x, col-y)
%       Only handle x, y having distance less than radius. Skip others.
% 2. find the projected x, y as x1, y1
% inverse rotation transformation is the starting point 
% rotation = [cos(theta) sin(theta); -sin(theta) cos(theta)]
% inv_rotation = [cos(theta2) -sin(theta2); sin(theta2) cos(theta2)]
% 
% 3. After finding estimated (x, y), find the pixel value of (x, y)
% should be by bilinear interpolation.

% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);
max_angle = 2 * pi * factor;

% outImg = zeros(myrow, mycol, mychannel, class(myinput));
outImg = myinput;
radius = min([ox-1, oy-1, myrow-ox+1, mycol-oy+1]);


for i = 1:myrow
    for j = 1:mycol
        if (ox-radius <= i <= ox+radius) & (oy-radius <= j <= oy+radius)
            distance = sqrt((i-ox)^2 + (j-oy)^2);
            if distance <= radius
                myangle = max_angle * distance / radius;
                x = (i - ox)*cos(myangle) - (j - oy)*sin(myangle) + ox;
                y = (i - ox)*sin(myangle) + (j - oy)*cos(myangle) + oy;
                [TL_x, TL_y, TR_x, TR_y, BL_x, BL_y, BR_x, BR_y, col_ratio, row_ratio] ...
                    = D_sampleBilinear(x, y, myrow, mycol, 1, 1);
                outImg(i,j,:) = round(row_ratio * (col_ratio * myinput(TL_x, TL_y, :) + ...
                    (1-col_ratio) * myinput(TR_x, TR_y, :)) + ...
                    (1-row_ratio) * (col_ratio * myinput(BL_x, BL_y, :) + ...
                    (1-col_ratio) * myinput(BR_x, BR_y, :)));
            end
        end
    end
end

[filepath, name, ext] = fileparts(inImg);
newfilepathname = strcat(filepath, name,'_swirlFilter',ext);

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 13');