%% READ AUDIO FILE
[audio, Fs] = audioread('/Users/CarlosArchila/Documents/University/UoY/Year4/MEng_Project/Samples/SopSax.nonvib.ff.stereo/SopSax.nonvib.ff.A5.stereo.aif');

%Convert stereo to mono
[noRows, noColumns] = size(audio);
if noRows>1 && noColumns>1
    disp('Input downsampled from Stereo to Mono')
    audio = (audio(:,1)+audio(:,2))/2;
end

%% CWT 
n = (1:length(audio))./Fs;

close all;
figure
% subplot(3,1,1);
plot(n,audio);
xlabel('Time (secs)');
ylabel('Amplitude');


figure
% subplot(3,1,2)
spectrogram(audio,128,64,128,Fs,'yaxis');
colormap jet

figure
% subplot(3,1,3);
cwt(audio,Fs);
colormap jet
