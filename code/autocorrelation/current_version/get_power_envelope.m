function [first_E0, E0_shift, x_out] = get_power_envelope(x,smoothing_window_size)

x_temp = x;
% Find the leading zero elements
i_pos = 1;
while x_temp(i_pos) == 0
    i_pos = i_pos + 1;
end
E0_shift = i_pos;
% Removing zero elements
x_temp(1:(i_pos-1)) = [];
x_temp = [zeros(1,smoothing_window_size/2), x_temp];
% Length of audio
N = length(x_temp);
% Limits
% m_lower_lim = floor(-N/30);
% m_upper_lim = floor(N/30-1);
%w = (tukeywin(N, 0.25))';
%w = rectwin(m_upper_lim-m_lower_lim);
w = rectwin(smoothing_window_size);
%x_temp = [zeros(1,-floor(m_lower_lim)), x_temp];
E0 = zeros(1, N);

for n = 1:N
    sumTerms = 0;
    %for m = m_lower_lim:m_upper_lim
    for m = 1:smoothing_window_size
        if m <=0
            continue;
        else
            win_value = w(m);
        end
        if n+m <= 0 || n+m > N
            continue;
        else
            x_value = x_temp(n+m);
        end
        sumTerms = sumTerms + abs(x_value)^2 * win_value;
    end
    E0(n) = sumTerms;
end

E0 = 1/N .* E0;

figure(123456)
plot(E0);
title('first E0');

figure(123457)
plot(E0);
title('first E0 normalized');
plot(E0/max(E0));

first_E0 = E0/max(E0);

i_pos2 = 1;
while E0(i_pos2) == 0
    i_pos2 = i_pos2 + 1;
end
% Removing zero elements
E0(1:(i_pos2-1)) = [];
E0 = [zeros(1,smoothing_window_size/2), E0];
%E0 = [zeros(1,-floor(m_lower_lim)), E0];
N = length(E0);
%w = (tukeywin(N, 0.25))';
w = rectwin(smoothing_window_size);
%m_lower_lim = floor(-N/30);
%m_upper_lim = floor(N/30-1);
for n = 1:N
    sumTerms = 0;
    %for m = m_lower_lim:m_upper_lim
    for m = 1:smoothing_window_size
        if m <=0
            continue;
        else
            win_value = w(m);
        end
        if n+m <= 0 || n+m > N
            continue;
        else
            x_value = E0(n+m);
        end
        sumTerms = sumTerms + abs(x_value)^2 * win_value;
    end
    E0(n) = sumTerms;
end

E0 = 1/N .* E0;

figure(321)%%%%%+==========================================================> added 1/09
plot(E0)
title('E0')
%x_out = diff(E0);
x_out = [zeros(1, i_pos+i_pos2), diff(E0)];
%x_out = [zeros(1,-floor(m_lower_lim*0.75)), diff(E0)];
figure(322)
plot(x_out)
title('x out')

end