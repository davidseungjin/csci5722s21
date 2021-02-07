% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [homographyMatrix] = computeH(points)

EPOCHS = 5;

minimumError = 10000000000;
currentH = zeros(3, 3);

for i = 1:EPOCHS
    randomPoints = datasample(points, 4);
    
    A = zeros(8, 9);
    for j = 1:4
        x_1 = randomPoints(j,1);
        y_1 = randomPoints(j,2);
        x_2 = randomPoints(j,3);
        y_2 = randomPoints(j,4);
        
        A(2*(j-1)+1,:) = [-x_2; -y_2; -1; 0; 0; 0; x_1*x_2; x_1*y_2; x_1];
        A(2*(j-1)+2,:) = [0; 0; 0; -x_2; -y_2; -1; y_1*x_2; y_1*y_2; y_1];
    end
    [~,S,V] = svd(A);
    h = V(:,9);
    H = transpose(reshape(h, [3, 3]));
    
    totalError = 0;
    for j = 1:10
        x_1 = points(j,1);
        y_1 = points(j,2);
        x_2 = points(j,3);
        y_2 = points(j,4);
        
        actual = H * [x_2; y_2; 1];
        actual = actual / actual(3);
        
        distance = (x_1-actual(1))^2 + (y_1-actual(2))^2;
        
        totalError = totalError + distance;
    end
    
    if totalError < minimumError
        minimumError = totalError;
        currentH = H;
    end
end

averageError = minimumError / 10;
homographyMatrix = currentH;

%NOTE FOR LATER: we only need to look at the 8 corners to determine the
%dimensions of the final image

end

