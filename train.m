function feature_bank = train()
    % trains the feature bank with a vector of wavfiles
    feature_bank = zeros(10, 12);
    factor = 5; % Downsample by a factor of 5 (to 8820 Hz)
    fs = 8820;
    Wp = .2;
    Ws = .3;
    Rp = 3;
    Rs = 60;
    
    [n,Wn] = buttord(Wp,Ws,Rp,Rs); % Create a butterworth filter
    [b,a] = butter(n,Wn);
    
    one_ted = audioread('one.wav');
    one_ted = one_ted(:,1);
    one_ted = filter(b,a,one_ted);
    one_ted = downsample(one_ted, factor);
    one_ted = one_ted/max(one_ted);
    
    two_ted = audioread('two.wav');
    two_ted = two_ted(:,1);
    two_ted = filter(b,a,two_ted);
    two_ted = downsample(two_ted, factor);
    two_ted = two_ted/max(two_ted);
    
    three_ted = audioread('three.wav');
    three_ted = three_ted(:,1);
    three_ted = filter(b,a,three_ted);
    three_ted = downsample(three_ted, factor);
    three_ted = three_ted/max(three_ted);
    
    four_ted = audioread('four.wav');
    four_ted = four_ted(:,1);
    four_ted = filter(b,a,four_ted);
    four_ted = downsample(four_ted, factor);
    four_ted = four_ted/max(four_ted);
    
    five_ted = audioread('five.wav');
    five_ted = five_ted(:,1);
    five_ted = filter(b,a,five_ted);
    five_ted = downsample(five_ted, factor);
    five_ted = five_ted/max(five_ted);
    
    six_ted = audioread('six.wav');
    six_ted = six_ted(:,1);
    six_ted = filter(b,a,six_ted);
    six_ted = downsample(six_ted, factor);
    six_ted = six_ted/max(six_ted);
    
    seven_ted = audioread('seven.wav');
    seven_ted = seven_ted(:,1);
    seven_ted = filter(b,a,seven_ted);
    seven_ted = downsample(seven_ted, factor);
    seven_ted = seven_ted/max(seven_ted);
    
    eight_ted = audioread('eight.wav');
    eight_ted = eight_ted(:,1);
    eight_ted = filter(b,a,eight_ted);
    eight_ted = downsample(eight_ted, factor);
    eight_ted = eight_ted/max(eight_ted);
    
    nine_ted = audioread('nine.wav');
    nine_ted = nine_ted(:,1);
    nine_ted = filter(b,a,nine_ted);
    nine_ted = downsample(nine_ted, factor);
    nine_ted = nine_ted/max(nine_ted);
    
    zero_ted = audioread('zero.wav');
    zero_ted = zero_ted(:,1);
    zero_ted = filter(b,a,zero_ted);
    zero_ted = downsample(zero_ted, factor);
    zero_ted = zero_ted/max(zero_ted);
    
    one_andrew = audioread('one_andrew.wav');
    one_andrew = one_andrew(:,1);
    one_andrew = filter(b,a,one_andrew);
    one_andrew = downsample(one_andrew, factor);
    one_andrew = one_andrew/max(one_andrew);
    
    two_andrew = audioread('two_andrew.wav');
    two_andrew = two_andrew(:,1);
    two_andrew = filter(b,a,two_andrew);
    two_andrew = downsample(two_andrew, factor);
    two_andrew = two_andrew/max(two_andrew);
    
    three_andrew = audioread('three_andrew.wav');
    three_andrew = three_andrew(:,1);
    three_andrew = filter(b,a,three_andrew);
    three_andrew = downsample(three_andrew, factor);
    three_andrew = three_andrew/max(three_andrew);
    
    four_andrew = audioread('four_andrew.wav');
    four_andrew = four_andrew(:,1);
    four_andrew = filter(b,a,four_andrew);
    four_andrew = downsample(four_andrew, factor);
    four_andrew = four_andrew/max(four_andrew);
    
    five_andrew = audioread('five_andrew.wav');
    five_andrew = five_andrew(:,1);
    five_andrew = filter(b,a,five_andrew);
    five_andrew = downsample(five_andrew, factor);
    five_andrew = five_andrew/max(five_andrew);
    
    six_andrew = audioread('six_andrew.wav');
    six_andrew = six_andrew(:,1);
    six_andrew = filter(b,a,six_andrew);
    six_andrew = downsample(six_andrew, factor);
    six_andrew = six_andrew/max(six_andrew);
    
    seven_andrew = audioread('seven_andrew.wav');
    seven_andrew = seven_andrew(:,1);
    seven_andrew = filter(b,a,seven_andrew);
    seven_andrew = downsample(seven_andrew, factor);
    seven_andrew = seven_andrew/max(seven_andrew);
    
    eight_andrew = audioread('eight_andrew.wav');
    eight_andrew = eight_andrew(:,1);
    eight_andrew = filter(b,a,eight_andrew);
    eight_andrew = downsample(eight_andrew, factor);
    eight_andrew = eight_andrew/max(eight_andrew);
    
    nine_andrew = audioread('nine_andrew.wav');
    nine_andrew = nine_andrew(:,1);
    nine_andrew = filter(b,a,nine_andrew);
    nine_andrew = downsample(nine_andrew, factor);
    nine_andrew = nine_andrew/max(nine_andrew);
    
    zero_andrew = audioread('zero_andrew.wav');
    zero_andrew = zero_andrew(:,1);
    zero_andrew = filter(b,a,zero_andrew);
    zero_andrew = downsample(zero_andrew, factor);
    zero_andrew = zero_andrew/max(zero_andrew);
    
    % Add MFCC coefficients to the feature bank
    feature_bank(1,1:12) = (mfcc(one_ted,fs) + mfcc(one_andrew, fs))/2;
    feature_bank(2,1:12) = (mfcc(two_ted,fs) + mfcc(two_andrew, fs))/2;
    feature_bank(3,1:12) = (mfcc(three_ted,fs) + mfcc(three_andrew, fs))/2;
    feature_bank(4,1:12) = (mfcc(four_ted,fs) + mfcc(four_andrew, fs))/2;
    feature_bank(5,1:12) = (mfcc(five_ted,fs) + mfcc(five_andrew, fs))/2;
    feature_bank(6,1:12) = (mfcc(six_ted,fs) + mfcc(six_andrew, fs))/2;
    feature_bank(7,1:12) = (mfcc(seven_ted,fs) + mfcc(seven_andrew, fs))/2;
    feature_bank(8,1:12) = (mfcc(eight_ted,fs) + mfcc(eight_andrew, fs))/2;
    feature_bank(9,1:12) = (mfcc(nine_ted,fs) + mfcc(nine_andrew, fs))/2;
    feature_bank(10,1:12) = (mfcc(zero_ted,fs) + mfcc(zero_andrew, fs))/2;
end