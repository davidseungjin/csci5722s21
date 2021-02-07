% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

% Declare lambda for the menu so we don't have to define these menu options
% multiple times.
main_menu = @() menu(...
    'Choose an option', ...
    'Exit Program', ...
    'Load Images', ...
    'Select Points', ...
    'Load Points', ...
    'Generate Mosaic', ...
    'Warp into Frame' ...
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
            % Load image pair
            image_choice = menu('Choose image pair', 'Square', 'House', 'Neighborhood');
            switch image_choice
               case 1
                   filename1 = 'Square0.jpg';
                   filename2 = 'Square1.jpg';
               case 2
                   filename1 = 's1_0.jpg';
                   filename2 = 's1_1.jpg';
               case 3
                   filename1 = 'neighborhood1.jpg';
                   filename2 = 'neighborhood2.jpg';
            end
            image1 = imread(filename1);
            image2 = imread(filename2);
        case 3
            % Select points and save
            points = getPoints(image1, image2);
            answer = inputdlg('Enter a file name to save the points to:', ...
                'Save Points', 1, {'data/points/points.mat'});
            save(answer{1}, 'points');
        case 4
            % Load points
            answer = inputdlg('Enter a file name to load the points from:', ...
                'Load Points', 1, {'data/points/square_points.mat'});
            load(answer{1}, 'points');
        case 5
            % Compute homography matrix
            H = computeH(points);
            
            % Generate output
            outputImg = generateOutputImage(image1, image2, H);
            saveImage(outputImg);
            
            displayAll(image1, image2, outputImg);
        case 6
            % Task 4 img2 in img1.
            % will choose corners of img2 automatically.
            % select four points of img1.
            % then make img.
            image_choice = menu('Choose image pair', 'House', 'House Compressed', 'Neighborhood');
            switch image_choice
               case 1
                   filename1 = 'task4_img1.jpg';
                   filename2 = 'task4_img2.jpg';
               case 2
                   filename1 = 'task4_compressed_img1.jpg';
                   filename2 = 'task4_img2.jpg';
               case 3
                   filename1 = 'neighborhood1.jpg';
                   filename2 = 'task4_img2.jpg';
            end
            image1 = imread(filename1);
            image2 = imread(filename2);
            
            points = setFrame(image1, image2);
            outputImg = HWarp(points, image1, image2);
            saveImage(outputImg);
            
            displayAll(image1, image2, outputImg);
    end
    
    choice = main_menu();
end
