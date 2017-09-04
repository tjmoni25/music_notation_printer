function [x_out] = get_power_envelope(x)

N = length(x);
w = (tukeywin(N, 0.25))';
m_lower_lim = floor(-N/30);
m_upper_lim = floor(N/30-1);
E0 = zeros(1, N);
%%for i = 1:2
for n = 1:N
    sumTerms = 0;
    for m = m_lower_lim:m_upper_lim
        if m <=0
            continue;
        else
            win_value = w(m);
        end
        if n+m <= 0 || n+m > N
            continue;
        else
            x_value = x(n+m);
        end
        sumTerms = sumTerms + abs(x_value)^2 * win_value;
    end
    E0(n) = sumTerms;
end
%for i = 1:2
for n = 1:N
    sumTerms = 0;
    for m = m_lower_lim:m_upper_lim
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
%%end
% E0 will have be left-shifted with m_upper_lim, need to compensate by
% applying m_upper_lim for getting the dips of position in no of samples.
E0 = 1/N .* E0;

i_pos = 1;
while E0(i_pos) == 0
    E0(i_pos) = rand(1)*10^-12;
    i_pos = i_pos + 1;
end

i_pos = length(E0);
while E0(i_pos) == 0
    E0(i_pos) = rand(1)*10^-12;
    i_pos = i_pos - 1;
end

figure(321)%%%%%+==========================================================> added 1/09
plot(E0)
title('E0')
x_out = [zeros(1,-floor(2*m_lower_lim*0.75)), diff(E0)];
figure(322)
plot(x_out)
title('x_out')
% envelope(E0,60,'peaks');
% [u,l]=envelope(E0,60,'peaks');%envelope(E0,170,'peaks'); %=================>added
% figure(160)
% plot(l)
% title('lower env')
% figure(111)
% plot(u)
% title('upper env')
% %%%[u,l]=envelope(l,1,'peaks')
% figure(119)
% plot(diff(l),'.')
% title('diff of lower env')

% figure(150)
% [diff_u, diff_l] = envelope(diff(l), 200, 'peaks');
% envelope(diff(l), 200, 'peaks')
% plot(diff_u, '.')
% title('upper env of diff of lower env')

% figure(134)
% x_out = [zeros(1,-floor(m_lower_lim*0.75)), diff(E0)];
% plot(x_out, '.')
% title('Get power envelope output')
end