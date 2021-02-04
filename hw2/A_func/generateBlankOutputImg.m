% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = generateBlankOutputImg(img1, img2, H)

[numRows, numColumns, ~] = size(img2);

img2TopLeftCornerPos = H * [1; 1; 1];
img2TopLeftCornerPos = img2TopLeftCornerPos / img2TopLeftCornerPos(3);

img2TopRightCornerPos = H * [numColumns; 1; 1];
img2TopRightCornerPos = img2TopRightCornerPos / img2TopRightCornerPos(3);

img2BottomLeftCornerPos = H * [1; numRows; 1];
img2BottomLeftCornerPos = img2BottomLeftCornerPos / img2BottomLeftCornerPos(3);

img2BottomRightCornerPos = H * [numColumns; numRows; 1];
img2BottomRightCornerPos = img2BottomRightCornerPos / img2BottomRightCornerPos(3);

[img1NumRows, img1NumColumns, ~] = size(img1);

extremitiesX = [img2TopLeftCornerPos(1) img2TopRightCornerPos(1) img2BottomLeftCornerPos(1) img2BottomRightCornerPos(1) img1NumColumns 1];
maxX = round(max(extremitiesX));
minX = round(min(extremitiesX));

extremitiesY = [img2TopLeftCornerPos(2) img2TopRightCornerPos(2) img2BottomLeftCornerPos(2) img2BottomRightCornerPos(2) img1NumRows 1];
minY = round(min(extremitiesY));
maxY = round(max(extremitiesY));

outputNumRows = maxY - minY;
outputNumColumns = maxX - minX;

outImg = zeros(outputNumRows, outputNumColumns, 3, class(img1));

% We will need those values above to transform the pixels after warping
% them to ensure they end up in the correct position on the outImg!
% Also need to figure out where to position img1

for i = 1:img1NumRows
    for j = 1:img1NumColumns
        outImg(i-minY+1, j-minX+1, :) = img1(i, j, :);
    end
end

% Set outImg with values from img2
% We actually need to do it in the opposite direction. Use the inverse and
% then grab the corresponding values from img2

%H_inv = inv(H);
for i = 1:outputNumRows
    for j = 1:outputNumColumns
        img2Pos = H \ [j; i; 1];
        img2Pos = img2Pos / img2Pos(3);
        img2RowIndex = round(img2Pos(2));
        img2ColumnIndex = round(img2Pos(1));
        if 1 <= img2RowIndex && img2RowIndex <= numRows && ...
           1 <= img2ColumnIndex && img2ColumnIndex <= numColumns
            outImg(i-minY+1,j-minX+1,:) = sampleBilinear(img2, 1, img2RowIndex, img2ColumnIndex);
        end
    end
end

figure
imagesc(outImg)

end

