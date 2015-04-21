function features = mfcc(x, fs)
    framelength = floor(.025*fs); % Get a 25ms frame length
    
    % Zero-pad signal with zeros if size does not divide evenly
    while mod(numel(x),framelength) ~= 0
        x(end+1) = 0;
    end
    % Number of iterations
    iterations = numel(x)/framelength;
    features = zeros(1,26);
    for i = 1:(iterations-1)
        start = i*framelength;
        stop = i*framelength+framelength;
        [P,f] = periodogram(x(start:stop), [], 512, fs);
        filterbank = get_filterbank(f);
        if sum(sum(isnan(filterbank))) ~= 0
            continue
        end
        energies = zeros(1,26);
        filterenergy = filterbank*P;
        for k = 1:26 % Sum the energy in each vector
            energies(k) = sum(filterenergy(k));
        end
        logfilterenergy = log(energies);
        energydct = dct(logfilterenergy,numel(logfilterenergy));
        if sum(sum(isnan(energydct))) ~= 0 % If the DCT has NaN elements, skip
            continue
        end
        features = features + energydct;
    end
    features = features / (iterations-1);
    %features = features/max(features); % Normalize feature vector
    features = features(2:13);
end

% Mel transform
function m = f2mel(freq)
    m = 1125*log(1+freq/700);
end

% Inverse Mel transform
function f = mel2f(m)
    f=700*(exp(m/1125)-1);
end

function filterbank = get_filterbank(frequencies)
    m_vector = f2mel(frequencies);
    binwidth = (max(m_vector)-min(m_vector))/27;
    minMel = min(m_vector);
    
    filterbank = zeros(26, numel(frequencies));
    for k = 1:26
        which_bin = find(m_vector>=((k-1)*binwidth+minMel) & m_vector<=((k+1)*binwidth+minMel));
        filterbank(k,which_bin) = triang(numel(which_bin));
    end
    filterbank = sparse(filterbank);
end    