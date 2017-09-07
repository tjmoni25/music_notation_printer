clc
clear
close all

% Load Audio
[y0,fs] = audioread('../../../audio/twinkle synthetic 120.wav');%C3-C4 %c scale fast

% Tempo of the piece (in quarter note)
TEMPO = 120;

% Number of lags defined
NUM_LAGS = 1700;

% Theshold value
THRES_VALUE_ACF = 0.4;
THRES_VALUE_ONSET = 0.08;
THRES_VALUE_OFFSET = 0.025;
% The time in sec that people can play
THRES_VALUE_TIME = 1/11;
% Window size
SIZE_SMOOTHING_WINDOW = 2000; %in no. of samples samples

fprintf('Programme is running, please be patient...\n')

% Select one channel of stereo signal
y0 = (y0(:,1))';
% Normalizing input signal
y0 = y0 * 1/max(y0); %========================================================================================>added 1/9

%% Onset detection
[first_E0, E0_shift, power_envelope] = get_power_envelope(y0, SIZE_SMOOTHING_WINDOW);
% Normalization
power_envelope = power_envelope/max(power_envelope);
figure(101)
plot(power_envelope)
title('Power Envelope')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test = power_envelope;
% figure(105)
% plot(test)
% title('test======================')
% qwe = envelope(test,310,'peaks');
% figure(106)
% plot(qwe)
% title('qwe======================')
% power_envelope = qwe;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
power_envelope = thresholding(power_envelope, THRES_VALUE_ONSET);
figure(102)
plot(power_envelope)
title('peaks')
peaks = onset_peak_picking(power_envelope, THRES_VALUE_ONSET, THRES_VALUE_TIME, fs);

% Initialize the result
piano_note = cell(1,length(peaks));

% Throw errors if peaks cannot be found
if (isempty(peaks))
    error('No notes are found!')
end
note_number = zeros(1, length(peaks));

%% Pitch detection of individual note 
for p = 1:length(peaks)
    sampleStart = peaks(p)+ 1;
    if p == length(peaks)
        sampleEnd = offset_detection(first_E0, E0_shift, sampleStart, length(y0), THRES_VALUE_OFFSET);
        offset_pos = sampleEnd;
    else
        sampleEnd = peaks(p+1);
    end
    % Select the signal according to the stop time definied
    y = y0(sampleStart:sampleEnd);

    % Applying window
    window_funct = 1;
    figure(p)
    % Autocorrelation
    ac = std_acf(window_funct.*y, NUM_LAGS);
    % Thresholding
    filtered_ac = thresholding(ac, THRES_VALUE_ACF);
    % Peak picking
    [p1, p2] = peak_picking(filtered_ac);
    % Finding the frequency of the input signal
    freq = fs /abs(p1 - p2);
    [piano_note{p}, note_number(p)] = find_piano_note(freq);
    if (p == 1)
        fprintf('Piano note detected:\n');
    end
    % Display results from ACF
    fprintf('%s, at %.2f Hz\n', piano_note{p}, freq);
    % Plot results
    subplot(2,2,1)
    plot(window_funct.*y);
    title(sprintf('signal %s with window applied', piano_note{p}));
    subplot(2,2,2)
    plot(y);
    title(sprintf('Input Audio Signal %s Data', piano_note{p}));
    subplot(2,2,3)
    plot(ac);
    title('Result of ACF')
    subplot(2,2,4)
    plot(filtered_ac);
    title('Result of filtered ACF');
end

%% Duration detection
duration_notes = duration_detection(peaks, offset_pos, length(y0));
notes_weighting = find_notes_weighting(TEMPO, duration_notes/fs, THRES_VALUE_TIME);

% Display results for Onset and notes weighting
figure(p+1)
plot(power_envelope)
title('Onset Peaks')

figure(p+2)
plot(y0)
title('Raw Audio')

fprintf('Notes detected in sequence:\n');
disp(piano_note);

fprintf('Notes weighting:\n')
disp(notes_weighting)

%% Writing into music score
fprintf('Writing into music score\n');
if (writing_music_score(note_number, piano_note, notes_weighting, TEMPO))
    fprintf('Successful.\n');
else
    fprintf('Error: Cannot write into music score file\n');
end

fprintf('Program terminated.\n')

