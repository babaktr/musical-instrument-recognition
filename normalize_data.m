% [normalized_data] = normalize_data( input_data )
%
% Authors:  Babak Toghiani-Rizi & Marcus Windmark
% Date:    2016
% 
% Function Description: 
%
%   Normalizes the input using feature scaling.
% 
% Input Parameters: 
%
%         input_data: (array) The array to perform normalizing on.
% 
% Returned Value: 
%
%         normalized_data: (array) Normalized array.
%

function [normalized_data] = normalize_data( input_data )

max_value = max(input_data(:));
min_value = min(input_data(:));
normalized_data = zeros(1, length(input_data));

for n = 1:length(input_data)
     normalized_data(n) = ((input_data(n)-min_value)/(max_value - min_value));
end % for loop

end % function 

