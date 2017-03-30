function [ attack_out ] = attackSeparation( audio_in, windowLength, hop )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    tic
%     hop = 128; %hop size between two FFTs
%     windowLength = 512; % length of the windows
    w = hanning(windowLength);
    %----- some initializations -----
    WLen2 = windowLength/2;
%     tx = (1:WLen2+1)';
%     normW = norm(w,2);
    coef = (windowLength/(2*pi));
    pft = 1;
%     lf = floor((length(audio_in) - windowLength)/hop);
%     feature_rms = zeros(lf,1);
%     feature_centroid = zeros(lf,1);
%     feature_centroid2 = zeros(lf,1);
    %-------------------------------------------
    pin = 0;
    pend = length(audio_in) - windowLength;
    while pin<pend
    grain = audio_in(pin+1:pin+windowLength).* w;
%     feature_rms(pft) = norm(grain,2) / normW;
%     f = fft(grain)/WLen2;
%     fx = abs(f(tx));
%     feature_centroid(pft) = sum(fx.*(tx-1)) / sum(fx);
%     fx2 = fx.*fx;
%     feature_centroid2(pft) = sum(fx2.*(tx-1)) / sum(fx2);
    grain2 = diff(audio_in(pin+1:pin+windowLength+1)).* w;
    feature_deriv(pft) = coef * norm(grain2,2) / norm(grain,2);
    pin = pin + hop;
    pft = pft + 1;
    end
    [~,loc] = min(feature_deriv(1:150));
    attack_out = audio_in(1:loc*hop);
end

