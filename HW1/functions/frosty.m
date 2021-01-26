% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = frosty(inImg, n, m)
% Applies a frosty filter by randomly selecting a neighboring pixel (or
% itself) within an (n,m) window around each pixel.

[numRows, numColumns, numColorChannels] = size(inImg);

outImg = inImg;

for i = 1:numRows
    for j = 1:numColumns
        % Compute bounds for neighbors.
        left_index = round(i-m/2);
        right_index = round(i+m/2);
        top_index = round(j-n/2);
        bottom_index = round(j+n/2);
        
        % Avoid out of bounds by setting to min/max index if the index goes
        % outside of the image.
        if left_index < 1
            left_index = 1;
        end
        if right_index > numRows
            right_index = numRows;
        end
        if top_index < 1
            top_index = 1;
        end
        if bottom_index > numColumns
            bottom_index = numColumns;
        end
        
        % Choose random neighbor by getting their indices.
        random_row_index = randi([left_index right_index], 1);
        random_col_index = randi([top_index bottom_index], 1);

        % Assigns the RGB values of the random neighboring pixel selected.
        outImg(i,j,:) = inImg(random_row_index, random_col_index, :);
    end
end

end

