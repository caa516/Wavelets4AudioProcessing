
%% Continuous and Discrete Wavelet Analysis of Frequency Break
% This example shows the difference between the discrete wavelet
% transform (*DWT*) and the continuous wavelet transform (*CWT*).

% Copyright 2006-2014 The MathWorks, Inc.

%% When is Continuous Analysis More Appropriate than Discrete Analysis? 
% To answer this, consider the related questions: Do you need to know all
% values of a continuous decomposition to reconstruct the signal exactly?
% Can you perform nonredundant analysis? When the energy of the signal is
% finite, not all values of a decomposition are needed to exactly
% reconstruct the original signal, provided that you are using a wavelet
% that satisfies some admissibility condition. Usual wavelets satisfy this
% condition. In this case, a continuous-time signal is characterized by
% the knowledge of the discrete transform. In such cases, discrete analysis
% is sufficient and continuous analysis is redundant. 
%
% Continuous analysis is often easier to interpret, since its redundancy
% tends to reinforce the traits and makes all information more visible.
% This is especially true of very subtle information. Thus, the analysis
% gains in "readability" and in ease of interpretation what it loses in
% terms of saving space. 


%% DWT and CWT of a Signal with a Frequency Break
% Show how analysis using wavelets can detect the exact instant when a
% signal changes. Use a discontinuous signal that consists of a slow sine 
% wave abruptly followed by a medium sine wave. 
% load freqbrk; 
% signal = freqbrk;

%% READ AUDIO FILE
[signal, Fs] = audioread('/Users/CarlosArchila/Documents/University/UoY/Year4/MEng_Project/Samples/SopSax.nonvib.ff.stereo/SopSax.nonvib.ff.A5.stereo.aif');

%Convert stereo to mono
[noRows, noColumns] = size(signal);
if noRows>1 && noColumns>1
    disp('Input downsampled from Stereo to Mono')
    signal = (signal(:,1)+signal(:,2))/2;
end
%% 
% Perform the discrete wavelet transform (DWT) at level 5 using the Haar
% wavelet.
lev   = 5;
wname = 'db1'; 
nbcol = 64; 
[c,l] = wavedec(signal,lev,wname);
%%
% Expand discrete wavelet coefficients for plot.
len = length(signal);
cfd = zeros(lev,len);
for k = 1:lev
    % Extract detail coefficients from c of lenght l at level k
    d = detcoef(c,l,k);
    % Replace existing d matrix with the conjugate transposition (') of all the
    % elements of d (d(:)) - inverts the sign of complex coefficients
    d = d(:)';
    % (DUE TO DECIMATION) Copies duplicates row 1 of d onto row 2 of d
    d = d(ones(1,2^k),:);
    % Conjugate-transposes the contents of d and fills row k of cfd with
    % them up to length len - results in consecutive duplicate coefficients
    cfd(k,:) = wkeep1(d(:)',len);
end
% Copies contents of cfd onto a single column, concatenating col1, col2,
% etc
cfd =  cfd(:);
% Not sure what these lines do
I = find(abs(cfd)<sqrt(eps));
cfd(I) = zeros(size(I));
% Reshapes cfd to a matrix of lev rows and len columns
cfd    = reshape(cfd,lev,len);
% Rescales contents of cfd to integers from 1:nbcol in the direction row
cfd = wcodemat(cfd,nbcol,'row');

h211 = subplot(2,1,1);
h211.XTick = [];
plot(signal,'r'); 
title('Analyzed signal.');
ax = gca;
ax.XLim = [1 length(signal)];
subplot(2,1,2);
colormap(jet(128));
image(cfd);
tics = 1:lev; 
labs = int2str(tics');
ax = gca;
ax.YTickLabelMode = 'manual';
ax.YDir = 'normal';
ax.Box = 'On';
ax.YTick = tics;
ax.YTickLabel = labs;
title('Discrete Transform, absolute coefficients.');
ylabel('Level');
%% 
% Perform the continuous wavelet transform (CWT) and visualize results
figure;
[cfs,f] = cwt(signal,1,'waveletparameters',[3 3.1]);
hp = pcolor(1:length(signal),f,abs(cfs)); hp.EdgeColor = 'none'; 
set(gca,'YScale','log');
xlabel('Sample'); ylabel('log10(f)');
%%
% If you just look at the finest scale CWT coefficients, you can localize
% the frequency change precisely.
plot(abs(cfs(1,:))); grid on;

%%
% This example shows an important advantage of wavelet analysis over Fourier.
% If the same signal had been analyzed by the Fourier transform, we would 
% not have been able to detect the instant when the signal's frequency 
% changed, whereas it is clearly observable here.