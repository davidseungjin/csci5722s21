function [outImg] = D_ScaleNearest(inImg, factor)

% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);
out_row = round(myrow * factor)
out_col = round(mycol * factor)

outImg = zeros(out_row, out_col, mychannel, class(myinput));


% It's loop solution. Maybe it is possible to implement No Loop.
% Vectorization. Need to think if time available.

for i = 1:out_row
    for j = 1:out_col
        [ori_x ori_y] = D_sampleNearest(i, j, myrow, mycol, factor, factor);
        outImg(i,j,:) = myinput(ori_x, ori_y, :);
    end
end

[filepath, name, ext] = fileparts(inImg);
newfilepathname = strcat(filepath, name,'_ScaleNearest',ext);

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 11');
