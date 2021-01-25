function [pixel] = sampleBilinear(img, factor, i, j)

[numRows, numColumns, numColorChannels] = size(img);

original_i = i/factor;
if original_i < 1
    original_i = 1;
elseif original_i > numRows
    original_i = numRows;
end

original_j = j/factor;
if original_j < 1
    original_j = 1;
elseif original_j > numColumns
    original_j = numColumns;
end

pixels = [ ...
    img(floor(original_i), floor(original_j), :), ...
    img(floor(original_i), ceil(original_j), :), ...
    img(ceil(original_i), floor(original_j), :), ...
    img(ceil(original_i), ceil(original_j), :) ...
];

pixel = [mean(pixels(:,:,1)), mean(pixels(:,:,2)), mean(pixels(:,:,3))];

end

