function [input_data, mapped_label_data] = process_training_data(directory, n_chunks, cut_attack_conf)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

file_data = process_file_names(directory); %[instrument, tone, filename]

training_data = cell(length(file_data),2);
%training_data = zeros(length(file_data(:,1)),2);

onset_length_ms = 100;


for n = 1:length(file_data)
    fprintf('%d of %d\n', n, length(file_data));
    filename = file_data(n,3);
    filename = filename{1};
    
    [y,Fs] = audioread(filename);
    
    if not(isempty(cut_attack_conf))
       [only_attack, without_attack] = cut_attack(filename, onset_length_ms);
       %disp('Cutting')
       
       if strcmp(cut_attack_conf, 'only_attack')
            y = only_attack;
            %disp('Only attack')
       else
           if strcmp(cut_attack_conf, 'without_attack')
                y = without_attack;
                %disp('Without attack')
           end
       end
    end   
    
    Nsamps = length(y);
    
    % Do Fourier Transform
    y_fft = abs(fft(y));           %Retain Magnitude
    y_fft = y_fft(1:round(Nsamps/2));      %Discard Half of Points
    f = Fs*(0:Nsamps-1)/Nsamps;   %Prepare freq data for plot
    f = f(1:round(1000*Nsamps/Fs));
    
    % Shift frequency
    tone =  file_data(n,2);
    frequency_diff = frequency_difference(tone{1});
    shifted_fft = shift_frequency(y_fft, frequency_diff, Fs, Nsamps);
    
    % Limit shifted_fft
    shifted_fft = shifted_fft(1:round(1000*Nsamps/Fs));
    
    % Extract feature vector
    feature_vector = create_feature_vector(shifted_fft,n_chunks);
    
    feature_vector = normalize_data(feature_vector);
    
    training_data(n, 1) = file_data(n,1);
    training_data(n, 2) = {feature_vector};
    
end

% % Konvertera fr?n cell till matris med cell2mat?
input_data = transpose(cell2mat(training_data(:, 2)));
label_data = training_data(:, 1);

instrument_set = unique(label_data);
instrument_value = (1:length(instrument_set));
instrumentLabelMap = containers.Map(instrument_set, instrument_value);

mapped_label_data = zeros(length(unique(label_data)),length(label_data));

for N = 1:length(label_data)
    instrument = label_data(N);
    mapped_label_data(instrumentLabelMap(instrument{1}), N) = 1;
end

end