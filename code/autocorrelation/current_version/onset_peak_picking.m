function peaks = onset_peak_picking(x, peak_threshold, time_threshold, fs)
%ONSET_PEAK_PICKING Summary of this function goes here
%   Detailed explanation goes here
peaks = [];

% Zero-crossing filtering
i = 1;
j = 1;
onsets_array = {};
finish = false;
while 1
    while x(i) == 0
        i = i+1;
        if ~(i <= length(x))
            finish = true;
            break;
        end
    end
    if finish
        break;
    end
    begin_onset = i;
    while x(i) ~= 0
        i = i+1;
        if ~(i <= length(x))
            finish = true;
            break;
        end
    end
    if finish
        break;
    end
    end_onset = i-1;
    onsets_array{j} = [begin_onset, end_onset];
    j = j+1;
end

%Using max amplitude for peak picking
for j = 1:length(onsets_array)
    x_sigment = x(onsets_array{j}(1):onsets_array{j}(2));
    [~, max_pos] = max(x_sigment);
    peaks = [peaks, (max_pos+onsets_array{j}(1))-1];
end

%Using onset edge for peak picking
% for j = 1:length(onsets_array)    
%     peaks = [peaks, onsets_array{j}(1)];
% end

% Time thresholding
j = 1;
while j ~= length(peaks)
    
    % Peaks are not too close together
    if (peaks(j+1) - peaks(j)) >= (time_threshold * fs)
        j=j+1;
        continue;
    % Peaks are too close together
    else
        if (x(peaks(j+1)) > x(peaks(j)))
            peaks(j) = [];
            onsets_array(j) = [];
            
        else           
            peaks(j+1) = [];
            onsets_array(j+1) = [];
        end
    end
    
end

% Onset offset seperation thresolding
j = 1;
while j ~= length(peaks)
    
    % Peaks are not too close together
    if (peaks(j+1) - onsets_array{j}(2)) >= (time_threshold * fs)
        j=j+1;
        continue;
    % Peaks are too close together
    else
        if x(peaks(j+1)) > x(peaks(j))
            peaks(j) = [];
            onsets_array(j) = [];
            
        else           
            peaks(j+1) = [];
            onsets_array(j+1) = [];
        end
    end
    
end

end
