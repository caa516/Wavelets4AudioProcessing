function [audio,Fs] = readAudioFile( filepath )
%Read an audio file and downmix to mono
%   This function reads an audio file, checks whether it is stereo or mono
%   and if it is stereo it outputs a mono downmix along with the sampling
%   frequency

%Read audio file from filepath
[audio, Fs] = audioread(filepath);

%Convert stereo to mono
[noRows, noColumns] = size(audio);
if noRows>1 && noColumns>1
    audio = (audio(:,1)+audio(:,2))/2;
    disp('Input downsampled from Stereo to Mono')
end
end

