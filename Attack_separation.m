filepath = '/Users/CarlosArchila/Documents/University/UoY/Year4/MEng_Project/Samples/SopSax.nonvib.ff.stereo/SopSax.nonvib.ff.A5.stereo.aif';
[audio,Fs] = readAudioFile(filepath);

%Time-varying RMS amplitude
rmsFrame =1024;
rmsAudio = zeros(1,floor(length(audio)/rmsFrame));
for n=0:floor(length(audio)/rmsFrame)-2
    currentRMS = rms(audio((n+1)*rmsFrame:(n+2)*rmsFrame));
    rmsAudio(n+1) = currentRMS;
end
plot(rmsAudio);

%Time-varying Spectral Centroid (time domain)
scFrame = 1024;
scAudio = zeros(1,floor(length(audio)/scFrame));
for i=0:floor(length(audio)/scFrame)-2
    audioBlock = audio((i+1)*scFrame:(i+2)*scFrame);
    currentSC = zeros(1,scFrame);
    for j=1:scFrame
        currentSC(j) = ((j-1)*audioBlock(j));
    end
    scAudio(i+1) = sum(currentSC)/sum(audioBlock);
end
figure;
plot(scAudio);