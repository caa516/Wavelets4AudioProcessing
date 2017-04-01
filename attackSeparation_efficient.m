function [ attack_out ] = attackSeparation_efficient( audio_in, windowLength, hop )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    rmsFrame = 1024;
    rmsAudio = zeros(1,floor(length(audio_in)/rmsFrame));
    for n=1:floor(length(audio_in)/rmsFrame)-1
        rmsAudio(n) = rms(audio_in((n)*rmsFrame:(n+1)*rmsFrame));
    end
    RMSlength1 = length(rmsAudio);
    maxRMS = max(rmsAudio);
    rmsAudio(rmsAudio(1:length(rmsAudio/2)) < maxRMS*0.001) = [];
    RMSlength2 = length(rmsAudio);
    audio_in = audio_in((RMSlength1-RMSlength2-1)*rmsFrame:length(audio_in));
    w = hanning(windowLength);
    coef = (windowLength/(2*pi));
    pft = 1;
    pin = 0;
    pend = length(audio_in) - windowLength;
    while pin<pend
    grain = audio_in(pin+1:pin+windowLength).* w;
    grain2 = diff(audio_in(pin+1:pin+windowLength+1)).* w;
    feature_deriv(pft) = coef * norm(grain2,2) / norm(grain,2);
    pin = pin + hop;
    pft = pft + 1;
    end
    [~,loc] = min(feature_deriv(1:20));
    attack_out = audio_in(1:loc*hop);
end