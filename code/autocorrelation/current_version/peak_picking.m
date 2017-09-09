function [p1, p2, success] = peak_picking(x)
% Peak picking algorithm
success = false;
p2 = [];
sig = x;
% ACF always has the maximum at the first location
p1 = 1;
% Start from next sample data
i = 1;
% zeros all the value which is above 0 until reaching the next zero crossing
while sig(i) > 0
    sig(i) = 0;
    i = i + 1;
    if i > length(sig)
        disp('Error: Cannot find the second peak\n');
        return;
    end
end

while sig(i) == 0
    i = i + 1;
    if i > length(sig)
        return;
    end
end
temp_peaks = [];
while sig(i) > 0
    temp_peaks = [temp_peaks, i];
    i = i + 1;
    if i > length(sig)
        return;
    end
end

[~, temp_peaks_pos] = max(sig(temp_peaks));

p2 = temp_peaks(temp_peaks_pos);

if length(p2) ~= 1
    return;
end

success = true;

end