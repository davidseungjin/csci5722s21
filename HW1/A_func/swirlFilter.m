% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = swirlFilter(inImg, factor, ox, oy)

[numRows, numColumns, numColorChannels] = size(inImg);
outImg = inImg;

% Finds the maximum feasible radius capable for the image.
radius = min([ox-1, oy-1, numRows-ox+1, numColumns-oy+1]);

% Calculates the maximum angle achievable by the factor.
maxAngle = 2*pi*factor;

for i = 1:numRows
    for j = 1:numColumns
        % Calculate the distance from the current pixel to the origin.
        distance = sqrt((i-ox)^2 + (j-oy)^2);

        % Determine if we are in the bounds of the radius around the
        % specified origin.
        if distance <= radius
            % Calculate our new coordinates to sample from in the original image.
            angle = maxAngle * distance / radius;
            x = (i-ox)*cos(angle) - (j-oy)*sin(angle) + ox;
            y = (i-ox)*sin(angle) + (j-oy)*cos(angle) + oy;

            % Sample for the pixel we wish to update the current one with.
            outImg(i,j,:) = sampleBilinear(inImg, factor, y, x);
        end
    end
end

end

