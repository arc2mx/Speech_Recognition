clear all;
clc;

bandwidth = 3500; % Bandwidth of human speech is about 3400 Hz
Fs = 2*bandwidth; % Nyquist rate
window = Fs/100; % Sample window

input = analoginput('winsound'); % Set up sound card input
addchannel(ai, 1);

% Configure analog input
set(ai, 'SampleRate', Fs);
set(ai, 'SamplesPerTrigger', window);
set(ai, 'TriggerRepeat', inf);
set(ai, 'TriggerType', 'immediate');

start(ai); % Start recording

is_recording = 1;

while is_recording
    data = getdata(ai, ai, SamplesPerTrigger);
    seglength = window;
    overlap = seglength/2;
    stepsize = seglength - overlap;
    frames = length(data)/stepsize - 1;
    
    s1 = 1;
    s2 = seglength;
    
    for i = 1:frames
        currframe = data(s1:s2);
        s1 = s1 + stepsize;
        s2 = s2 + stepsize;
    end
        
end

stop(ai);
delete(ai);
clear ai;