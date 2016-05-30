% [ only_attack, without_attack ] = cut_attack( audio_file, attack_length_ms )
% 
% Authors:  Babak Toghiani-Rizi & Marcus Windmark
% Date:    2016
% 
% Function Description: 
%
%   Separates the signal into one with only attack and one without.
% 
% Input Parameters: 
%
%         audio_file: (string) Path to an audio file of which to 
%                      cut the attack. 
%                           
%         attack_length:ms: (integer) The attack length in milliseconds.
% 
% Returned Value: 
%
%         only_attack: (array) The signal with the attack separated.
%
%         without_attack: (array) The signal without the attack.
%


function [ only_attack, without_attack ] = cut_attack( audio_file, attack_length_ms )

    [y,Fs] = audioread(audio_file);

    frame_ms = 10;
    frame_width = (Fs / 1000) * frame_ms;                          
    num_samples = length(y);                    
    num_frames = floor(num_samples / frame_width); 
    energy = zeros(1, num_frames);               
    start_sample = zeros(1, num_frames);         
    end_sample = zeros(1, num_frames);           

    for frame = 1:num_frames                     
      start_sample(frame) = (frame - 1) * frame_width + 1;
      end_sample(frame) = frame * frame_width;            
      frame_index = start_sample(frame):end_sample(frame);
      energy(frame) = sum(y(frame_index).^ 2);            
    end

    signal_energy = root_mean_square(y);

    onset_db_threshold = 10;
    onset_start_index = find(energy > signal_energy * db2mag(onset_db_threshold), 1);
    onset_start_seconds = onset_start_index * (frame_ms / 1000);

    t = linspace(0,length(y) / Fs, length(y));
    only_attack = y(t > onset_start_seconds & t < onset_start_seconds + attack_length_ms / 1000);

    without_onset_shift_s = 0.2;
    without_attack = y(t > onset_start_seconds + attack_length_ms / 1000 + without_onset_shift_s & t < (length(y) / Fs));

end

