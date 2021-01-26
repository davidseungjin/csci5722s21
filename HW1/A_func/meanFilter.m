function [outImg] = meanFilter(inImg, kernel_size)

[numRows, numColumns, numColorChannels] = size(inImg);

outImg = inImg;
indexSpread = floor(kernel_size/2);

for i = 1:numRows
    for j = 1:numColumns
        % Compute bounds for neighbors.
        left_index = i-indexSpread;
        right_index = i+indexSpread;
        top_index = j-indexSpread;
        bottom_index = j+indexSpread;
        
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

        % Get neighbors in the form of a sub-image.
        neighbors = inImg(left_index:right_index, top_index:bottom_index, :);

        % Compute averages for each color and assign accordingly.
        outImg(i,j,1) = mean(mean(neighbors(:,:,1)));
        outImg(i,j,2) = mean(mean(neighbors(:,:,2)));
        outImg(i,j,3) = mean(mean(neighbors(:,:,3)));
    end
end

end

