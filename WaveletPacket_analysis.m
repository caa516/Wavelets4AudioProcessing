%% READ AUDIO FILE
[audio, Fs] = audioread('/Users/CarlosArchila/Documents/University/UoY/Year4/MEng_Project/Samples/SopSax.nonvib.ff.stereo/SopSax.nonvib.ff.A5.stereo.aif');

%Convert stereo to mono
[noRows, noColumns] = size(audio);
if noRows>1 && noColumns>1
    audio = (audio(:,1)+audio(:,2))/2;
    disp('Input downsampled from Stereo to Mono')
end

%% WAVELET PACKET DECOMPOSITION

lev = 3;
close all;
% Wavelet Packet Tree T
T = wpdec(audio,lev,'db1');
plot(T);

% Wavelet Packet Spectrum Plot
[SPEC,TIMES,FREQS] = wpspectrum(T,Fs,'plot');
plot(wpspectrum(T,Fs,'plot'));

% Obtain coefficients of decomposition node 3,0
X = wpcoef(T,[3 0]);
plot(X);
