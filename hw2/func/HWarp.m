% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = HWarp(points, img1, img2)
% img2 into img1.

currentH = zeros(3, 3);
    
A = zeros(8, 9);
for j = 1:4
    x_1 = points(j,1);
    y_1 = points(j,2);
    x_2 = points(j,3);
    y_2 = points(j,4);

    A(2*(j-1)+1,:) = [-x_2; -y_2; -1; 0; 0; 0; x_1*x_2; x_1*y_2; x_1];
    A(2*(j-1)+2,:) = [0; 0; 0; -x_2; -y_2; -1; y_1*x_2; y_1*y_2; y_1];
end
[~,S,V] = svd(A);
h = V(:,9);
H = transpose(reshape(h, [3, 3]));


[img1NumRows, img1NumColumns, ~] = size(img1);
[img2numRows, img2numColumns, ~] = size(img2);

outImg = img1;


% Used 
for i = 1:img1NumRows
    for j = 1:img1NumColumns
        % convert j, i to appropriate type for inverted homography.
        img2Pos = H \ [j; i; 1];
        img2Pos = img2Pos / img2Pos(3);
        
        % changed to floor instead of round to fill more indices.
        img2RowIndex = floor(img2Pos(2));
        img2ColumnIndex = floor(img2Pos(1));
        if 1 <= img2RowIndex && img2RowIndex <= img2numRows && ...
           1 <= img2ColumnIndex && img2ColumnIndex <= img2numColumns    
            outImg(i,j,:) = sampleBilinear(img2, 1, img2RowIndex, img2ColumnIndex);
        end
    end
end

end

