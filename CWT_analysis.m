%% READ AUDIO FILE
[audio, Fs] = audioread('/Users/CarlosArchila/Documents/University/UoY/Year4/MEng_Project/Samples/SopSax.nonvib.ff.stereo/SopSax.nonvib.ff.A4.stereo.aif');

%Convert stereo to mono 

audio = (audio(:,1)+audio(:,2))/2;