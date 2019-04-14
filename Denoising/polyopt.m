function a_opt=polyopt(desired,signal,a_len)
desired=desired(:);
% a_opt=polyopt(desired,signal,a_len)

% desired = desired clean signal

% signal = noisy signal

% a_len = length of polynomial to use

% a_opt = optimal polynomial coefficients

[d,prep]=polyth(signal,5,ones(1,a_len));

a_opt=prep\desired;