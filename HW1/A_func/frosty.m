function [outImg] = frosty(inImg, n, m)

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

        % Compute averages for each color and assign accordingly.
        outImg(i,j,:) = inImg(random_row_index, random_col_index, :);
    end
end

end
