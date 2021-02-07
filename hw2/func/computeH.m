% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [homographyMatrix] = computeH(points)

EPOCHS = 20;

% Initialize minimum error and the H to return
minimumError = 10000000000;
currentH = zeros(3, 3);

for i = 1:EPOCHS
    % Grab four random points
    randomPoints = datasample(points, 4);
    
    % Set up the A matrix
    A = zeros(8, 9);
    for j = 1:4
        x_1 = randomPoints(j,1);
        y_1 = randomPoints(j,2);
        x_2 = randomPoints(j,3);
        y_2 = randomPoints(j,4);
        
        % Sets up the 2 rows in the A matrix for the corresponding point
        A(2*(j-1)+1,:) = [-x_2; -y_2; -1; 0; 0; 0; x_1*x_2; x_1*y_2; x_1];
        A(2*(j-1)+2,:) = [0; 0; 0; -x_2; -y_2; -1; y_1*x_2; y_1*y_2; y_1];
    end
    
    % Computes Singular Value Decomposition matrix
    [~,S,V] = svd(A);
    
    % Grabs the last vector since that corresponds to the lowest singular
    % value
    h = V(:,9);
    
    % Reshapes the last vector into a homography matrix
    H = transpose(reshape(h, [3, 3]));
    
    % Computes the total error in transforming the 10 points passed in with
    % the homography matrix
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
    
    % When the total error is less than the minimum error we currently are
    % aware of, then we update the minimum error to reflect that and
    % maintain the new homography matrix.
    if totalError < minimumError
        minimumError = totalError;
        currentH = H;
    end
end

% Find the average error just for debugging if needed
averageError = minimumError / 10;

% Return the homography matrix
homographyMatrix = currentH;

end

