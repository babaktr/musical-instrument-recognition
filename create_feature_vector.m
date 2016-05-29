% [feature_vector] = create_feature_vector( frequency_array, n_chunks )
% 
% Authors:  Babak Toghiani-Rizi & Marcus Windmark
% Date:    2016
% 
% Function Description: 
%
%   Creates a feature vector from an array with a given amount of elements.
% 
% Input Parameters: 
%
%         frequency_vector: (array) The array of frequencies from the
%                           frequency spectrum.
%         n_chunks: (integer) The number of chunks/elements to take the
%                   average over and construct the feature vector with.
% 
% Returned Value: 
%
%         feature_vector: (array) The feature vector.
%

function [feature_vector] = create_feature_vector( frequency_array, n_chunks )

feature_vector = zeros(1,n_chunks);
chunk_size = floor(length(frequency_array)/n_chunks);

for n = 0:n_chunks-1
    chunk = frequency_array(1+n*chunk_size:(n+1)*chunk_size);
%    average value of each chunk
     chunk_average = sum(chunk)/chunk_size;
     feature_vector(n+1) = chunk_average;
end % for loop

end % function
