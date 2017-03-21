function [ filepaths ] = readAudioDirectory( directoryPath )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    %Read all files from directory
    files = dir(directoryPath);
    folder = extractfield(files, 'folder')';
    name = extractfield(files, 'name')';
    filepaths = cell(length(files),1);
    for i=1:length(files)
        filepaths(i) = strcat(folder(i),{'/'},name(i));
    end

end

