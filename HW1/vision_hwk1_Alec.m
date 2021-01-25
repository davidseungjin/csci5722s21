% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Alec Bell
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

% Declare lambda for the menu so we don't have to define these menu options
% multiple times.
main_menu = @() menu(...
    'Choose an option', ...
    'Exit Program', ...
    'Load Image', ...
    'Display Image', ...
    'Brighten_L', ...
    'Brighten_NL', ...
    'Invert_L', ...
    'Invert_NL', ...
    'AddRandomNoise_L', ...
    'Luminance_L', ...
    'RedFilter', ...
    'BinaryMask', ...
    'MeanFilter', ...
    'Frosty', ...
    'ScaleNearest', ...
    'ScaleBilinear' ...
);

% Display a menu and get a choice
choice = main_menu();
 
% Choice 1 is to exit the program
while choice ~= 1
    switch choice
        case 0
            disp('Error - please choose one of the options.')
            choice = main_menu();
        case 2
            % Load an image
            image_choice = menu('Choose an image', 'lena1', 'mandrill1', 'sully', 'yoda', 'shrek', 'wrench');
            switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandrill1.jpg';
               case 3
                   filename = 'sully.bmp';
               case 4
                   filename = 'yoda.bmp';
               case 5
                   filename = 'shrek.bmp';
               case 6
                   filename = 'wrench1.jpg';
            end
            current_img = imread(filename);
        case 3
            % Display image
            figure
            imshow(current_img);
            if size(current_img,3) == 1
               colormap gray
            end
       case 4
            % Brighten (with loops)
            % Get user input
            answer = inputdlg('Enter an amount between (-255,+255) to adjust the brightness:', ...
               'Brightness Adjustment', 1, {'0'});
           
            % Convert input to number, generate new image
            brightness = str2num(answer{1});
            newImage = makeBright_L(current_img, brightness);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
        case 5
            % Brighten (without loops)
            % Get user input
            answer = inputdlg('Enter an amount between (-255,+255) to adjust the brightness:', ...
               'Brightness Adjustment', 1, {'0'});
           
            % Convert input to number, generate new image
            brightness = str2num(answer{1});
            newImage = makeBright_NL(current_img, brightness);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 6
            % Invert (with loops)
            newImage = invert_L(current_img);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 7
            % Invert (without loops)
            newImage = invert_NL(current_img);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 8
            % Add Random Noise (without loops)
            newImage = addRandomNoise_L(current_img);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 9
            % Luminance (without loops)
            newImage = luminance_L(current_img);
            
            % Compare two images
            % Have to use different image plot function to avoid "imagesc"
            % applying a colormap.
            displaySideBySide(current_img, newImage, @(img) imshow(img));
            
            % Save the new image
            saveImage(newImage)
        case 10
            % Red Filter (without loops)
            % Get user input
            answer = inputdlg('Enter an amount between (0,1) to adjust the red-ness:', ...
               'Red Filter', 1, {'0.5'});
           
            % Convert input to number, generate new image
            redVal = str2double(answer{1});
            newImage = redFilter(current_img, redVal);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 11
            % Binary Mask
            newImage = binaryMask(current_img);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 12
            % Mean Filter
            % Get user input
            answer = inputdlg('Enter an kernel_size (int > 2):', ...
               'Mean Filter', 1, {'3'});
           
            % Convert input to number, generate new image
            kernel_size = str2num(answer{1});
            newImage = meanFilter(current_img, kernel_size);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 13
            % Frosty Filter
            % Get user input
            answer = inputdlg({'n:','m;'}, ...
               'Frosty Filter Dimensions', 2, {'4','4'});
           
            % Convert input to number, generate new image
            n = str2num(answer{1});
            m = str2num(answer{2});
            newImage = frosty(current_img, n, m);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 14
            % Scale Nearest
            % Get user input
            answer = inputdlg('Enter scaling factor:', ...
               'Scale Nearest', 1, {'1'});
           
            % Convert input to number, generate new image
            factor = str2num(answer{1});
            newImage = scaleNearest(current_img, factor);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
        case 15
            % Scale Bilinear
            % Get user input
            answer = inputdlg('Enter scaling factor:', ...
               'Scale Bilinear', 1, {'1'});
           
            % Convert input to number, generate new image
            factor = str2num(answer{1});
            newImage = scaleBilinear(current_img, factor);
            
            % Compare two images
            displaySideBySide(current_img, newImage);
            
            % Save the new image
            saveImage(newImage)
            
    end
    
    choice = main_menu();
end
