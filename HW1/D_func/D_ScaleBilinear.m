function [outImg] = D_ScaleBilinear(inImg, factor)

% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);
out_row = round(myrow * factor);
out_col = round(mycol * factor);

outImg = zeros(out_row, out_col, mychannel, class(myinput));


% It's loop solution. Maybe it is possible to implement No Loop.
% Vectorization. Need to think if time available.


for i = 1:out_row
    for j = 1:out_col
        [TL_x, TL_y, TR_x, TR_y, BL_x, BL_y, BR_x, BR_y, col_ratio, row_ratio] = D_sampleBilinear(i, j, myrow, mycol, factor, factor);
        outImg(i,j,:) = round(row_ratio * (col_ratio * myinput(TL_x, TL_y, :) + (1-col_ratio) * myinput(TR_x, TR_y, :)) + (1-row_ratio) * (col_ratio * myinput(BL_x, BL_y, :) + (1-col_ratio) * myinput(BR_x, BR_y, :)));
    end
end

[filepath, name, ext] = fileparts(inImg);
newfilepathname = strcat(filepath, name,'_ScaleBilinear',ext);

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 13');