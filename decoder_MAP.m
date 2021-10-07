function [L] = decoder_MAP( x, g, snr )
Lc = 10^(snr/10);
d = delta(x, g, snr);
a = forward(d,[1 0 0 0]');
b = backward(d,[1 0 0 0]');
L = LLR( d,a,b );
end

