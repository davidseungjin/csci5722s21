function [outImg] = D_frosty(inImg, n, m)
% n is row, m is column
% set window for both direction.
% Plan is to find 
row_window = floor(n/2);
col_window = floor(m/2);

% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);
outImg = zeros(myrow, mycol, mychannel, class(myinput));


for i = 1:myrow
    for j = 1:mycol
        row_target = 0;
        col_target = 0;
        while row_target < 1 || row_target > myrow
            row_target = i + randi([-row_window, row_window]);
        end
        while col_target < 1 || col_target > mycol
            col_target = j + randi([-col_window, col_window]);
        end
        outImg(i, j,:) = myinput(row_target, col_target, :);
    end
end

[filepath, name, ext] = fileparts(inImg);
newfilepathname = strcat(filepath, name,'_frosty',ext);

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 10');