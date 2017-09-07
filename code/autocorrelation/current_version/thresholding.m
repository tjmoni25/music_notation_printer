function [x_out] = thresholding(y, threshold)
%FILTER_ZC Summary of this function goes here
%   Detailed explanation goes here

length_y = length(y);
x_out = zeros(1, length_y);

for i = 1:length_y
    if y(i) > threshold
        x_out(i) = y(i);
    end
end

end

