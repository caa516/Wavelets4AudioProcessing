%% READ AUDIO FILE
[audio, Fs] = audioread('/Users/CarlosArchila/Documents/University/UoY/Year4/MEng_Project/Samples/SopSax.nonvib.ff.stereo/SopSax.nonvib.ff.A5.stereo.aif');

%Convert stereo to mono
[noRows, noColumns] = size(audio);
if noRows>1 && noColumns>1
    audio = (audio(:,1)+audio(:,2))/2;
    disp('Input downsampled from Stereo to Mono')
end

%% DWT
[cA,cD] = dwt(audio,'haar');
close all;
subplot(1,3,1);
plot(audio);
subplot(1,3,2);
plot(1:length(cA),abs(cA).^2);
title('Approximation Coefficients');
subplot(1,3,3);
plot(1:length(cD),abs(cD).^2);
title('Detail Coefficients');

%% MULTI-LEVEL DWT
[C,L] = wavedec(audio,5,'db1');
figure;
plot(abs(C));