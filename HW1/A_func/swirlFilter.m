function [outImg] = swirlFilter(inImg, factor, ox, oy)

[numRows, numColumns, numColorChannels] = size(inImg);
outImg = inImg;

radius = min([ox-1, oy-1, numRows-ox+1, numColumns-oy+1]);
maxAngle = 2*pi*factor;

for i = 1:numRows
    for j = 1:numColumns
        if ox-radius <= i && i <= ox+radius && oy-radius <= j && j <= oy+radius
            distance = sqrt((i-ox)^2 + (j-oy)^2);
            if distance <= radius
                angle = maxAngle * distance / radius;
                
                x = (i-ox)*cos(angle) - (j-oy)*sin(angle) + ox;
                y = (i-ox)*sin(angle) + (j-oy)*cos(angle) + oy;
                
                outImg(i,j,:) = sampleBilinear(inImg, factor, y, x);
            end
        end
    end
end

end

