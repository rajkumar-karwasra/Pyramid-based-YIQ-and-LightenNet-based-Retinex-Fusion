function y = vl_nnelu(x, dzdy)

alpha = 1;
x = max(x, -50);  % stability fix

if nargin <= 1 || isempty(dzdy)
    % Forward
    y = x .* (x > 0) + alpha * (exp(x) - 1) .* (x <= 0);
else
    % Backward
    y = dzdy .* ((x > 0) + (x <= 0) .* alpha .* exp(x));
end