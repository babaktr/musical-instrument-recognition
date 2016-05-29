function [ file_data ] = process_file_names( directory )
    file_names = dir(directory); 
%     file_names = {file_names(~[file_names.isdir && strcmpi(file_names.name(1), '.')]).name};

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


