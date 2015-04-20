function features = voicerecognition(x, fs)
    % Get a 25ms frame length
    framelength = floor(.025*fs);
    
    % Zero-pad signal with ones if size does not divide evenly
    sizediff = mod(numel(x),framelength);
    if sizediff ~= 0
        for n = 1:sizediff
            x(end+1) = 0;
        end
    end
    
    % Take the 512-point DFT
    S = fft(x, 512);
    % Keep only the first 257 elements
    S = S(1:257);
    P = zeros(1,257);
    for n = 1:257
        P(n) = S(n)*S(n)./512;
    end
    
    % Get filterbank of frequencies 300-8000 Hz
    filterbank = get_filterbank(300, 8000, S, fs);
    coefficients = zeros(1,26);
    
    for i = 1:26
        mult = filterbank(i).*P;
        coefficients(i) = sum(mult);
    end
    
    coefficients = log10(coefficients);
    features = dct(coefficients);
    features = features(1:13);
end

% Mel transform
function m = f2mel(freq)
    m = 1125*log(1+freq/700);
end

% Inverse Mel transform
function f = mel2f(m)
    f=700*(exp(m/1125)-1);
end

% Get filter bank
function filterbank = get_filterbank(lower, upper, fft, fs)
    % Upper and lower bounds in the Mel domain
    lower_mel = f2mel(lower);
    upper_mel = f2mel(upper);
    
    % Want to generate 26 additional points between upper and lower bounds
    m_vector = linspace(lower_mel, upper_mel, 28);
    h_vector = zeros(1,numel(m_vector));
    
    for k = 1:28
        h_vector(k) = mel2f(m_vector(k));
    end
    
    f_bins = zeros(1,28);
    
    % Sort frequencies into bins
    for k = 1:28
        f_bins(k) = floor((fft+1)*h_vector(k)/fs);
    end
    filterbank = zeros(N,N);
    
    for k = 1:28
        which_bin = f_bins(k);
        filterbank(k, which_bin) = triang(numel(which_bin));
    end
    % Use a sparse matrix to reduce memory usage
    filterbank = sparse(filterbank);
end    