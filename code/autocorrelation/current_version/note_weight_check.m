function [new_note_weighting, weighting_fixed] = note_weight_check(note_weighting, time_signature, least_note_weighting)
%NOTE_WEIGHT_CHECK Summary of this function goes here
%   Detailed explanation goes here
weighting_fixed = 0;
note_weight_sum = 0;
num_notes_in_bar = 0;
new_note_weighting = note_weighting;
for i = 1:length(new_note_weighting)
    note_weight_sum = note_weight_sum + 1/new_note_weighting(i);
    num_notes_in_bar = num_notes_in_bar + 1;
    if note_weight_sum == time_signature{1}/time_signature{2}
        % Correct, reset variables
        note_weight_sum = 0;
        num_notes_in_bar = 0;
    elseif note_weight_sum > time_signature{1}/time_signature{2} || (note_weight_sum < time_signature{1}/time_signature{2} && i == length(new_note_weighting))
        % Something wrong
        % Going back for each note
        fprintf('Wrong note weighting detected!\n');
        weighting_fixed = -1;
        fixed_error = false;
        for j = 1:(log(least_note_weighting)/log(2))
            for k = i:-1:(i-num_notes_in_bar+1)
                new_note_weighting(k) = least_note_weighting/(2^(j-1));                
                num_notes_in_bar2 = 0;
                note_weight_sum2 = 0;
                for l = i:-1:(i-num_notes_in_bar+1)
                    note_weight_sum2 = note_weight_sum2 + 1/new_note_weighting(l);                  
                    num_notes_in_bar2 = num_notes_in_bar2 + 1;
                end
                if note_weight_sum2 == time_signature{1}/time_signature{2}
                    % Correct, jump out the loops
                    fixed_error = true;
                    break;
                else
                    new_note_weighting = note_weighting;
                end

            end
            if fixed_error
                break;
            end

        end
        if ~fixed_error
            return;
        else
            fprintf('Wrong weighting fixed\n');
            weighting_fixed = 1;
        end
        % Keep going if having low note_weight_sum
    end
end


end

