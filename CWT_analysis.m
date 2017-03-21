%% READ AUDIO FILE
[audio, Fs] = audioread('/Users/CarlosArchila/Documents/University/UoY/Year4/MPAS/AudioFiles/Cscale_piano_60bpm.wav');

%Convert stereo to mono
[noRows, noColumns] = size(audio);
if noRows>1 && noColumns>1
    audio = (audio(:,1)+audio(:,2))/2;
    disp('Input downsampled from Stereo to Mono')
end

%% CWT

[wt,freq] = cwt(audio,Fs);

%% SIGNAL PLOTS
%Time axis, sample / Fs to convert samples->seconds
n = (1:length(audio))./Fs;
close all;

% Input data plot
figure
% subplot(3,1,1);
plot(n,audio);
xlabel('Time (secs)');
ylabel('Amplitude');

% Spectrogram
figure
% subplot(3,1,2)
spectrogram(audio,256,128,256,Fs,'yaxis');
colormap jet

%% CWT PLOTS
% Scalogram
figure
% subplot(3,1,3);
colormap jet
wscalogram('image',wt);

% Coefficient magnitude plot
figure
plot(abs(wt(1,:)));
hold on;
plot(abs(wt(41,:)));
plot(abs(wt(43,:)));
title('Scale 1 Coefficients Magnitude Plot');