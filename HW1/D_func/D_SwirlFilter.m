function [outImg] = D_SwirlFilter(inImg, factor, ox, oy)
% Lecture note of Polytechnic University, Brooklyn
% 
% Direction:
% 1. Using ox, oy and each x, y coordinates, predefined theta
% 
% 2. find the projected x, y as x1, y1
% inverse rotation transformation is the starting point 
% rotation = [cos(theta) sin(theta); -sin(theta) cos(theta)]
% inv_rotation = [cos(theta2) -sin(theta2); sin(theta2) cos(theta2)]
% where thata2 = theta * distance (distance from ox, oy)
% Distance between (x1, y1) and the origin is same as the dist between
% (x,y) and the origin, so the distance of (x1, y1) is compatible with
% using theta2
% distance = sqrt((x1 - ox)^2 + (y1 - oy)^2)
% x = (x1 - ox)cos(theta2) - (y1 - oy)sin(theta2) + ox
% y = (x1 - ox)sin(theta2) + (y1 - oy)cos(theta2) + oy
% 
% 3. After finding estimated (x, y), find the pixel value of (x, y)
% should be by bilinear interpolation.

% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);

outImg = zeros(myrow, mycol, mychannel, class(myinput));
scale_factor = 1;

for i = 1:myrow
    for j = 1:mycol
        distance = sqrt((i-ox)^2 + (j-oy)^2);
%         myangle = distance * factor;
        myangle = mod(factor * distance, 2 * pi);
        x = (i - ox)*cos(myangle) - (j - oy)*sin(myangle) + ox;
        y = (i - ox)*sin(myangle) + (j - oy)*cos(myangle) + oy;
        if x >= 1 && x <= myrow && y >= 1 && y <= mycol
            [TL_x, TL_y, TR_x, TR_y, BL_x, BL_y, BR_x, BR_y, col_ratio, row_ratio] = D_sampleBilinear(x, y, myrow, mycol, scale_factor, scale_factor);
            outImg(i,j,:) = round(row_ratio * (col_ratio * myinput(TL_x, TL_y, :) + (1-col_ratio) * myinput(TR_x, TR_y, :)) + (1-row_ratio) * (col_ratio * myinput(BL_x, BL_y, :) + (1-col_ratio) * myinput(BR_x, BR_y, :)));
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
