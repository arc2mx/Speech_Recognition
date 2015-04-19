function features = MFCC(x, fs)
    % Get a 25ms frame length
    framelength = floor(.025*fs);
    
    % Zero-pad signal with ones if size does not divide evenly
    sizediff = mod(length(x),framelength);
    if sizediff ~= 0
        for n = 1:sizediff
            x(end+1) = 0;
        end
    end
    
    % Take the 512-point DFT
    S = fft(x, 512);
    % Keep only the first 257 elements
    S = S(1:257);
    P = zeros(257);
    for n = 1:257
        P(n) = S(n)*S(n)./512;
    end
    
    filterbank - get_filterbank(300, 8000, P, fs);
end

function m = f2mel(freq)
    m = 1125*ln(1+freq/700);
end

function f = mel2f(m)
    f=700*(exp(m/1125)-1);
end

function filterbank = get_filterbank(lower, upper, P, fs)
    % Upper and lower bounds in the Mel domain
    lower_mel = f2mel(lower);
    upper_mel = f2mel(upper);
    
    % Want to generate 26 additional points between upper and lower bounds
    m_vector = linspace(lower_mel, upper_mel, 28);
    h_vector = zeros(length(m_vector));
    
    for k = 1:length(m_vector)
        h_vector(k) = mel2f(m_vector(k));
    end
    
    f_bins = zeros(length(h_vector));
    
    % Sort frequencies into bins
    for k = 1:length(h_vector)
        f_bins(k) = floor((P+1)*h_vector(k)/fs);
    end
    filterbank = zeros(length(f_bins));
    
    
    
end    