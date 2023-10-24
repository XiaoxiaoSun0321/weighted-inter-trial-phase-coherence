function trial_weights = trial_weight_power(eeg_data,srate,target_band,total_band,elec_used)
%function trial_weight_power calculates the weights of each trial based on
% its power of interested frequency band. It takes the average of all
% electrodes within the ROIs. 

%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eeg_data: eeg data used to calculate inter-trial phase coherence (itpc).%
%           structure of eeg_data matrix should be channels*time*trials   %
% srate: sample rate needed for power spetrum estimation                  %
% target_band: targed frequency band range. e.g., [8,14] indicates alpha  %
%              frequency band                                             %
% target_band: targed frequency band range. e.g., [1,30] indicates across %
%              beta,theta,alpha,some gamma frequency band                 %
% elec_used: eeg electrodes used for calculation. e.g., [1,2,3] indicates %
%           used electrode location 1,2,3 in matrix will be used.         %
%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% trial_weights: trial weights calculated based on power,                 %
%                the sum of trial_weights should be 1.                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if all variables are given
if nargin < 4
    disp('Important variables are missing, please read the input instructions.')
    return;
end

% Check if ROI electrode is provided
if nargin == 4
    % Use a default value to calculate across all electrodes if not provided
    elec_used = linspace(1,channel_num,channel_num);  % Replace with your default value if needed
    disp('No ROI specified, so all electrodes will be used.')
end

trial_num = size(eeg_data,3);

% Target frequency range
target_low = target_band(1); 
target_high = target_band(2);

% Total frequency range
total_low = total_band(1);
total_high = total_band(2);

relative_power = nan(trial_num,1);
for ix_trial = 1:trial_num 
    % Use pwelch function to do power spectral density (PSD) estimate
    [data_pw,data_freq] = pwelch(eeg_data(:,:,ix_trial).',[],[],[],srate); %default parameters are used, update if needed.
    
    [~,f_lower] = min(abs(data_freq-target_low));
    [~,f_upper] = min(abs(data_freq-target_high));

    [~,f_lower_total] = min(abs(data_freq-total_low));
    [~,f_upper_total] = min(abs(data_freq-total_high));
    
    % Power of chosed ROIs
    power_used = mean(data_pw(:,elec_used),2);
    power_used_band = trapz(data_freq(f_lower:f_upper),power_used(f_lower:f_upper));
    power_used_band_total = trapz(data_freq(f_lower_total:f_upper_total),power_used(f_lower_total:f_upper_total));
    % Calculate the relative power of the target band over the total frequency band
    relative_power(ix_trial) = power_used_band/power_used_band_total;
end

% Check if all trials are properly calculated
if sum(isnan(relative_power))>0 
    disp('Not all trials are calculated, please check for errors.')
    return;
end

trial_weights = relative_power./sum(relative_power);

end