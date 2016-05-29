% [frequency_difference] = frequency_difference( tone )
% 
% Authors:  Babak Toghiani-Rizi & Marcus Windmark
% Date:    2016
% 
% Function Description: 
%
%   Calculates the difference in Hz between two tones.
% 
% Input Parameters: 
%
%         tone: (string) The tone to calculate the difference with A4 from.
% 
% Returned Value: 
%
%         frequency_difference: (float) The calculated difference.
%

function [frequency_difference] = frequency_difference( tone )

tone_set = {'A4', 'As4', 'B4', 'C4', 'Cs4', 'D4', 'Ds4', 'E4', 'F4', 'Fs4', 'G4', 'Gs4'};
tone_frequency = [440.0, 466.154, 493.883, 261.626, 277.183, 293.665, 311.127, ...
    329.628, 349.228, 369.994, 391.995, 415.305];
    
map_object = containers.Map(tone_set, tone_frequency);

frequency_difference = map_object('A4') - map_object(tone);

end % function

