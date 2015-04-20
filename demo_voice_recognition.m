% Read in reference samples
[one,Fs] = audioread('one.wav'); % Read in sound for "one" and sampling freq
one = one(:,1); % Get first channel
two = audioread('two.wav'); % Sound file for "two"
two = two(:,1);
three = audioread('three.wav');
three = three(:,1);
four = audioread('four.wav');
four = four(:,1);
five = audioread('five.wav');
five = five(:,1);
six = audioread('six.wav');
six = six(:,1);
seven = audioread('seven.wav');
seven = seven(:,1);
eight = audioread('eight.wav');
eight = eight(:,1);
nine = audioread('nine.wav');
nine = nine(:,1);
zero = audioread('zero.wav');
zero = zero(:,1);

lower = 300; % Set lower bound of frequency to 300 Hz
% Use 8000 Hz as cutoff frequency since bandwidth of human hearing is about
% 3500 Hz
upper = 8000; % Set upper bound of frequency to 8000 Hz

% Get feature vectors for every word
one_features = mfcc(one, lower, upper, Fs);
two_features = mfcc(two, lower, upper, Fs);
three_features = mfcc(three, lower, upper, Fs);
four_features = mfcc(four, lower, upper, Fs);
five_features = mfcc(five, lower, upper, Fs);
six_features = mfcc(six, lower, upper, Fs);
seven_features = mfcc(seven, lower, upper, Fs);
eight_features = mfcc(eight, lower, upper, Fs);
nine_features = mfcc(nine, lower, upper, Fs);
zero_features = mfcc(zero, lower, upper, Fs);

all_features = [one_features two_features three_features four_features 
    five_features six_features seven_features eight_features
    nine_features zero_features];

% Read in input
input = audioread('input.wav');
input = input(:,1);

input_features = mfcc(input, lower, upper, Fs);

closest_match = 1;
min_ssd = inf;
for i=1:10
    ssd = sum(input_features-all_features(i))^2;
    if ssd < min_ssd
        min_ssd = ssd;
        closest_match = mod(i,10);
    end
end

disp('The input has been matched to:');
disp(closest_match);