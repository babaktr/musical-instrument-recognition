% [ file_data ] = process_file_names( directory )
% 
% Authors:  Babak Toghiani-Rizi & Marcus Windmark
% Date:    2016
% 
% Function Description: 
%
%   Extracts all file names in a directory, assuming the format
%   "instrument_tone".
% 
% Input Parameters: 
%
%         directory: (string) Path to a directory.
% 
% Returned Value: 
%
%         file_data: (cell) The instrument information extracted
%                     from the given directory.
%
%


function [ file_data ] = process_file_names( directory )
    file_names = dir(directory); 

    for k = length(file_names):-1:1
        if file_names(k).isdir
            file_names(k) = [ ];
            continue
        end

        fname = file_names(k).name;
        if fname(1) == '.'
            file_names(k) = [ ];
        end
    end
    
    file_data = cell(length(file_names), 3);
    
    for k = length(file_names):-1:1
        name = file_names(k).name;
        exploded_file_name = strsplit(name, '_');
        instrument = exploded_file_name(1);
        tone = exploded_file_name(2);
        file_data(k, 1) = instrument;
        file_data(k, 2) = tone;
        file_data(k, 3) = {strcat(directory, name)};
    end
end


