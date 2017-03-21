% UX-centr0id.m
% feature-centroid1 and 2 are centroids
% calculate by two different methods
clear; clf
close all;
filepath = '/Users/CarlosArchila/Documents/University/UoY/Year4/MEng_Project/Samples/Trumpet.novib.ff.stereo/Trumpet.novib.ff.A4.stereo.aif';
[DAFx_in, FS] = readAudioFile(filepath);
hop = 128; %hop size between two FFTs
WLen = 512; % length of the windows
w = hanning(WLen);
%----- some initializations -----
WLen2 = WLen/2;
tx = (1 :WLen2+1)';
normW = norm(w,2);
coef = (WLen/(2*pi));
pft = 1;
lf = floor((length(DAFx_in) - WLen)/hop);
feature_rms = zeros(lf,1);
feature_centroid = zeros(lf,1);
feature_centroid2 = zeros(lf,1);
tic
%-------------------------------------------
pin = 0;
pend = length(DAFx_in) - WLen;
while pin<pend
grain = DAFx_in(pin+1:pin+WLen).* w;
feature_rms(pft) = norm(grain,2) / normW;
f = fft(grain)/WLen2;
fx = abs(f(tx));
feature_centroid(pft) = sum(fx.*(tx-1)) / sum(fx);
fx2 = fx.*fx;
feature_centroid2(pft) = sum(fx2.*(tx-1)) / sum(fx2);
grain2 = diff(DAFx_in(pin+1:pin+WLen+1)).* w;
feature_deriv(pft) = coef * norm(grain2,2) / norm(grain,2);
pin = pin + hop;
pft = pft + 1;
end

%==================================================

subplot (4,1,1); plot (feature_rms) ; xlabel ('RMS')
subplot (4,1,2); plot (feature_centroid) ; xlabel ('centroid 1')
subplot(4,1,3); plot(feature_centroid2); xlabel('centroid 2')
subplot(4,1,4); plot(feature_deriv) ; xlabel('centroid 3')

%==================================================

[min,loc] = min(feature_deriv(1:150));
attackPortion = DAFx_in(1:loc*hop);
toc
figure; plot(DAFx_in);
figure; plot(attackPortion);
figure; cwt(attackPortion,FS);
figure; spectrogram(attackPortion,256,128,256,FS,'yaxis');