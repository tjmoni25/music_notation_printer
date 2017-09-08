function result = writing_music_score(notes_number, piano_notes, notes_weighting, tempo, time_signature , newOrOld)

result = false;

[success,message,MESSAGEID] = mkdir('output_files');
if ~success
    error(message);
    return;
end
if strcmp(newOrOld, 'new')
    fid = fopen('output_files/music_score_new_output.ly', 'w');
else
    fid = fopen('output_files/music_score_output.ly', 'w');
end

if fid == -1
    error('Cannot create music_score!\n');
    return;
end

bass = {};
treble = {};

for i = 1:length(notes_number)
    if notes_number(i) < 40
        % Go to bass
        n = 3-str2double(piano_notes{i}(2));
        comma = '';
        for j = 1:n
            comma = strcat(comma, ',');
        end
        sharp = '';
        if length(piano_notes{i}) == 3
            if piano_notes{i}(3) == '#'
                sharp = 'is';
            end
        end
        bass{i} = strcat(lower(piano_notes{i}(1)), sharp, comma, int2str(notes_weighting(i)));
        % Add rest to treble
        treble{i} = strcat('R', int2str(notes_weighting(i)));
    else
        % Go to treble
        n = str2double(piano_notes{i}(2))-3;
        quote = '';
        for j = 1:n
            quote = strcat(quote, '''');
        end
        sharp = '';
        if length(piano_notes{i}) == 3
            if piano_notes{i}(3) == '#'
                sharp = 'is';
            end
        end
        treble{i} = strcat(lower(piano_notes{i}(1)), sharp, quote, int2str(notes_weighting(i)));
        % Add rest to bass
        bass{i} = strcat('R', int2str(notes_weighting(i)));
    end
end

% Printing treble
fprintf(fid, 'trebleNotes = {\n');
fprintf(fid, '\t\\tempo 4 = %d\n', tempo);
fprintf(fid, '\t\\time %s\n', time_signature);
fprintf(fid, '\t\\clef treble\n\t');
for i = 1:length(treble)
    fprintf(fid, '%s ', treble{i});
end
fprintf(fid, '\n}\n');
fprintf(fid, 'bassNotes = {\n');
fprintf(fid, '\t\\clef bass\n\t');
for i = 1:length(bass)
    fprintf(fid, '%s ', bass{i});
end

fprintf(fid, '\n}\n');
fprintf(fid, '<<\n\t\\new Staff \\trebleNotes\n\t\\new Staff \\bassNotes\n>>');

if fclose(fid) == -1
    error('Cannot create music_score!\n');
    return;
end
result = true;

end

