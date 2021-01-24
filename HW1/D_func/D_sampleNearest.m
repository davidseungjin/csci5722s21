function [o_x o_y] = D_sampleNearest(x, y, o_row, o_col, x_scale, y_scale)
% I itired to implemented for scaling x, y direction to prepare any future
% use
% How long is the width and height of the original img.
% How long will the scaled width and height of new img.
% find the relation using these two.
% It needs round operation because indexes should be an integer.
% o_x, o_y: referring index(nearest neightbor) according to params
% x, y: indexes in new image
% o_row, o_col: size of the original img.
% x_scale, y_scale: as is
% For a calculation convenience, convert to 0 based index.
% (o_y - 1) / (o_col-1) = (y-1) / (o_col * y_scale - 1)
% Same for o_x. For Task 11, no need to find o_y becuase scale_factor
% doesn't handle with o_x
% From calculation
% o_x = x

o_x = x;
o_y = round((y-1)*(o_col-1) / (o_col * y_scale - 1) + 1);
