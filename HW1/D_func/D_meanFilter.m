function [outImg] = D_meanFilter(inImg, kernel_size)
% Kernel_size should be odd.

% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);

% General direction.
% I. Preprocess the original imate
% 1. Find padding size from kernel_size to handle corner, edge case.
% 2. Using padding size and size of inImg, create new image having additional
% 3. row/column in the 4 direction. (top/bottom/left/right)
% 4. Number of padding is floor(kernet_size/2)
% 5. So, new created image size to handle is (row + 2 padding size) *
% (column + 2 padding size)
% 6. create new_inImg because it should show inImg at the end.

% II. Create 2D array: mean filter. <-- skip it by using double type and
% NaN
% 1. ones(kernel_size, kernel_size) / (kernel_size ^ 2)

% III. create outImg and process
% 1. outImg size should be the same as inImg
% 2. plan is to use new_inImg(1+pad:new_row-pad, 1+pad:new_col-pad
% 3. After implementing these using NaN, looping, element wise
% multiplication, mean by 'all', and 'omitnan'

% I
pad_size = floor(kernel_size / 2);
corner_add = NaN(pad_size, pad_size, mychannel);
row_add = NaN(pad_size, mycol, mychannel);
column_add = NaN(myrow, pad_size, mychannel);

% Array concatenate in the direction of column.
% convert myinput2 data type from uint8 to double to use NaN operation.
% Is there anything better?

myinput2 = im2double(myinput);

new_myinput = [column_add myinput2 column_add];
row_addition = [corner_add row_add corner_add];
new_myinput = [row_addition; new_myinput; row_addition];

% II. Create 2D array: mean filter.
% WAIT: Do I need mean filter array? Think the way to implement wo this.
mymean = ones(kernel_size, kernel_size, mychannel) / (kernel_size ^ 2);

% III.
outImg = zeros(myrow, mycol, mychannel, class(myinput));

for i = 1:myrow
    for j = 1:mycol
        meanvalue = mean(new_myinput(i:i+2*pad_size, j:j+2*pad_size, :), [1 2], 'omitnan');
        outImg(i, j,:) = uint8(255 * meanvalue);
    end
end

[filepath, name, ext] = fileparts(inImg);
newfilepathname = strcat(filepath, name,'_meanFilter',ext);

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 9');