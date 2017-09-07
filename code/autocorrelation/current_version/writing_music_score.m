function result = writing_music_score(notes_number, piano_notes, notes_weighting, tempo)

result = false;

fid = fopen('music_score_output.ly', 'w');

if fid == 0
    return;
end

bass = {};
treble = {};

for i = 1:length(notes_number)
    if notes_number(i) < 48
        % Go to bass
        n = 3-str2double(piano_notes{i}(2));
        comma = '';
        for j = 1:n
            comma = strcat(comma, ',');
        end
        piano_notes{i} = strcat(lower(piano_notes{i}(1)), comma, int2str(notes_weighting(i)));
        bass{i} = piano_notes{i}(1);
        % Add rest to base
        treble{i} = strcat('R', int2str(notes_weighting(i)));
        % Add rest to treble
    else
        % Go to treble
        n = str2double(piano_notes{i}(2))-4;
        quote = '';
        for j = 1:n
            quote = strcat(quote, '''');
        end
        piano_notes{i} = strcat(lower(piano_notes{i}(1)), quote, int2str(notes_weighting(i)));
        treble{i} = piano_notes{i};
        % Add rest to base
        bass{i} = strcat('R', int2str(notes_weighting(i)));
    end
end

disp(treble)
disp(bass);
% Printing treble
fprintf(fid, '{\n\t\\time 4/4\n\t');
fprintf(fid, '\\clef treble\n\t');
for i = 1:length(treble)
    fprintf(fid, '%s ', treble{i});
end
fprintf(fid, '\n}\n');
fprintf(fid, '{\n\t\\clef bass\n\t');
for i = 1:length(bass)
    fprintf(fid, '%s ', bass{i});
end

fprintf(fid, '\n}\n');
fclose(fid);
result = true;

end

