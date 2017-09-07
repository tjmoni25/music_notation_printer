function durations = duration_detection(peaks, offset_pos, length_signal_in_no_sample)
%DURATION_DETECTION Summary of this function goes here
%   Detailed explanation goes here

length_peaks = length(peaks);
durations = zeros(1, length_peaks);

for i = 1:length_peaks
    if i == length_peaks
        durations(i) = offset_pos - peaks(i);
    else
        durations(i) = peaks(i+1) - peaks(i);
    end
end

end

