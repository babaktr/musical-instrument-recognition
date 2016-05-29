% [shifted_fft] = shift_frequency( array, frequency, sampling_frequency, n_samples )
%
% Authors:  Babak Toghiani-Rizi & Marcus Windmark
% Date:    2016
% 
% Function Description: 
%
%   Shifts the frequency spectrum.
% 
% Input Parameters: 
%
%         array: (array) Array of the frequency spectrum.
%         frequency: (float) Number of frequencies to shift.
%         sampling_frequency: (integer) The sampling frequency used to 
%                             record the samples with.
%         n_samples: (integer) The number of samples in the array.
% 
% Returned Value: 
%
%         normalized_data: (array) Normalized array.
%

function [shifted_fft] = shift_frequency( array, frequency, sampling_frequency, n_samples )
shift_factor = n_samples/sampling_frequency;

array_size = length(array);

frequency_shift = round(shift_factor*frequency);
% %USED TO CUT FIRST 100Hz
% for N = 1:(shift_factor*100)
%     array(N) = 0;
% end

% % USED TO CUT OFF ANYTHING _BUT_ THE FIRST 100 HZ
% for x = round(shift_factor*100):(array_size-(shift_factor*100)-1)
%     array(x) = 0;
% end

shifted_fft = zeros(array_size, 1);

for n = 1:(array_size-abs(frequency_shift)-1)
    if (n+frequency_shift) > 0
        shifted_fft(n+frequency_shift,1) = array(n,1);
    end 
end

