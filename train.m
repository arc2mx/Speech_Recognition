function feature_bank = train(wavfiles)
    % trains the feature bank with a vector of wavfiles
    feature_bank = zeros(numel(wavfiles), 26);
    for i = 1:numel(wavfiles)
        [x, Fs] = audioread(wavfile(i));
        features = mfcc(x, Fs);
        feature_bank(i) = features;
    end
end