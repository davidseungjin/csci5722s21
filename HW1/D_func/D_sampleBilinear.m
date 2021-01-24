function [TL_x, TL_y, TR_x, TR_y, BL_x, BL_y, BR_x, BR_y, col_ratio, row_ratio] = D_sampleBilinear(x, y, o_row, o_col, x_scale, y_scale)
% Starting point: https://www.mathworks.com/matlabcentral/fileexchange/43533-bilinear-interpolation-of-an-image-or-matrix
% Direction
% 1. Find the four index pairs nearby. top-left, top-right, bottom-left, bottom-right.
% (It is a modification version of D_sampleNearest.m)
% 
% 2. Calculate temporary values: 
%       temp_top: interpolated value between top-left and top-right
%       temp_bottom: interpolated value between bottom-left and bottom-right
% 
% 3. using temp_top, temp_bottom and each distance from (x, y) find the interpolated value.
% If x, y is the coordinates that was originally on the inImg, the four
%       neighbors will be the same.
% Regarding col_ratio, row_ratio, their baseline is Top_Left. 
% Ex, col_ratio = 0.3, row_ratio = 0.7, the index x, y is 0.3 far from TL, (1-0.3)=0.7 far from TR.
exact_x = (x-1)*(o_row-1) / (o_row * x_scale - 1) + 1;
exact_y = (y-1)*(o_col-1) / (o_col * y_scale - 1) + 1;

TL_x = floor(exact_x);
TL_y = floor(exact_y);

TR_x = floor(exact_x);
TR_y = ceil(exact_y);

BL_x = ceil(exact_x);
BL_y = floor(exact_y);

BR_x = ceil(exact_x);
BR_y = ceil(exact_y);

row_ratio = exact_x - TL_x;
col_ratio = exact_y - TL_y;

