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
    'Compute Homography', ...
    'Task4: warp img2 into img1' ...
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
            image_choice = menu('Choose image pair', 'Square');
            switch image_choice
               case 1
                   filename1 = 'Square0.jpg';
                   filename2 = 'Square1.jpg';
            end
            image1 = imread(filename1);
            image2 = imread(filename2);
        case 3
            % Select points and save
            points = getPoints(image1, image2);
            answer = inputdlg('Enter a file name to save the points to:', ...
                'Save Points', 1, {'points.mat'});
            save(answer{1}, 'points');
        case 4
            % Load points
            answer = inputdlg('Enter a file name to load the points from:', ...
                'Load Points', 1, {'points.mat'});
            load(answer{1}, 'points');
        case 5
            % Compute homography matrix
            H = computeH(points);
            generateBlankOutputImg(image1, image2, H);
        case 6
            % Task 4 img2 in img1.
            % will choose corners of img2 automatically.
            % select four points of img1.
            % then make img.
            image_choice = menu('Choose image pair', 'Task4');
            switch image_choice
               case 1
                   filename1 = 'task4_img1.jpg';
                   filename2 = 'task4_img2.jpg';
            end
            image1 = imread(filename1);
            image2 = imread(filename2);
            
            points = setFrame(image1, image2);
            HWarp(points, image1, image2);
            
    end
    
    choice = main_menu();
end
