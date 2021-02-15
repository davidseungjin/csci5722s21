% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = generateOutputImage(img1, img2, H)

% Map each of the corners of img2 into img1's coordinate space.
[img2NumRows, img2NumColumns, ~] = size(img2);

img2TopLeftCornerPos = H * [1; 1; 1];
img2TopLeftCornerPos = img2TopLeftCornerPos / img2TopLeftCornerPos(3);

img2TopRightCornerPos = H * [img2NumColumns; 1; 1];
img2TopRightCornerPos = img2TopRightCornerPos / img2TopRightCornerPos(3);

img2BottomLeftCornerPos = H * [1; img2NumRows; 1];
img2BottomLeftCornerPos = img2BottomLeftCornerPos / img2BottomLeftCornerPos(3);

img2BottomRightCornerPos = H * [img2NumColumns; img2NumRows; 1];
img2BottomRightCornerPos = img2BottomRightCornerPos / img2BottomRightCornerPos(3);

% Grab the dimensions of img1
[img1NumRows, img1NumColumns, ~] = size(img1);

% Find the minimum and maximum X coordinates in img1's coordinate space with
% both img1 and img2, so we know what to set the dimensions in the output
% image.
extremitiesX = [img2TopLeftCornerPos(1) img2TopRightCornerPos(1) img2BottomLeftCornerPos(1) img2BottomRightCornerPos(1) img1NumColumns 1];
minX = floor(min(extremitiesX));
maxX = ceil(max(extremitiesX));

% Same as above, but for the Y coordinates.
extremitiesY = [img2TopLeftCornerPos(2) img2TopRightCornerPos(2) img2BottomLeftCornerPos(2) img2BottomRightCornerPos(2) img1NumRows 1];
minY = floor(min(extremitiesY));
maxY = ceil(max(extremitiesY));

% add 1 for width. Matlab.
outputNumRows = maxY - minY + 1;
outputNumColumns = maxX - minX + 1;

% use double datatype to use NaN. (to avoid zero values in pixels of img1)
outImg = NaN(outputNumRows, outputNumColumns, 3, 'double');


% We will need those values above to transform the pixels after warping
% them to ensure they end up in the correct position on the outImg!
% Also need to figure out where to position img1

outImg(2-minY:img1NumRows-minY+1, 2-minX:img1NumColumns-minX+1,:) = double(img1)/double(intmax(class(img1)));



% Set outImg with values from img2
% We actually need to do it in the opposite direction. Use the inverse and
% then grab the corresponding values from img2

%H_inv = inv(H);

% Used 
for i = 1:outputNumRows
    for j = 1:outputNumColumns
        % indices already filled with value, not process
        if ~isnan(outImg(i,j))
            continue
        end
        
        % convert j, i to appropriate type for inverted homography.
        img2Pos = H \ [j+minX-1; i+minY-1; 1];
        img2Pos = img2Pos / img2Pos(3);
        
        % changed to floor instead of round to fill more indices.
        img2RowIndex = floor(img2Pos(2));
        img2ColumnIndex = floor(img2Pos(1));
        if 1 <= img2RowIndex && img2RowIndex <= img2NumRows && ...
           1 <= img2ColumnIndex && img2ColumnIndex <= img2NumColumns
            
            outImg(i,j,:) = double(sampleBilinear(img2, 1, img2RowIndex, img2ColumnIndex))/double(intmax(class(img2)));
        else
            outImg(i,j,:) = 0;
        end
    end
end

outImg = uint8(outImg * double(intmax('uint8')));

end