function offset_peak = offset_detection(power_envelope, E0_shift, last_onset_peak, length_audio, threshold)
figure(444)
x = power_envelope((last_onset_peak - E0_shift):length(power_envelope));
plot(x)
[~, max_pos] = max(x);
i = max_pos;
while x(i) >= threshold 
    i = i + 1;
end
offset_peak = i + (last_onset_peak ) - 1;
if offset_peak > length_audio
    offset_peak = length_audio;
end

end

