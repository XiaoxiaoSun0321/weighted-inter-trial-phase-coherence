function [witpc_time,witpc_phase] = witpc(trial_weights,eeg_data,elec_used)
% function witpc calculates the trail-weighted inter-trial phase coherence 
% for a given data.

%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% trail_weight: trial weights for each trial based on its power, it should%
%              have the same length as trial number                       %
% eeg_data: eeg data used to calculate inter-trial phase coherence (itpc).%
%           structure of eeg_data matrix should be channels*time*trials   %
% elec_used: eeg electrodes used for calculation. e.g., [1,2,3] indicates %
%           used electrode location 1,2,3 in matrix will be used.         %
%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% witpc_time: witpc value where the length is time, value in [0,1].       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

channel_num = size(eeg_data,1);

% Check if ROI electrode is provided
    if nargin < 3
        % Use a default value to calculate across all electrodes if not provided
        elec_used = linspace(1,channel_num,channel_num);  % Replace with your default value if needed
        disp('No ROI specified, so all electrodes will be used.')
    end

clear eeg_angles euler_complex temp_phase
for ix_elec = 1:length(elec_used)
    % Obtain hilbert transform of the ROI
    eeg_angles(ix_elec,:,:) = angle(hilbert(eeg_data(ix_elec,:,:)));
    % Apply Euler's formula
    euler_complex(ix_elec,:,:) = exp(1i*eeg_angles(ix_elec,:,:));
end


if size(trial_weights,2)==1
    % Average across electrodes 
    %avg_roi_complex = mean(euler_complex,1);
    % Trial-weighted average across trials, trial_weights is region average
    %witpc_time = abs(squeeze(avg_roi_complex)*trial_weights);
    %witpc_phase = angle(squeeze(avg_roi_complex)*trial_weights);
    
    %calculate wITPC for each electrode, then calculate the wITPC average
    witpc_time = mean(abs(temp_phase),1);
    witpc_phase = circ_mean(angle(temp_phase));
    %disp('The given trial weights are region-level average(or include only 1 electrodes).');
end


if size(trial_weights,2)~=1
    % Trial-weighted average across trials, trial_weights is
    % electrode-based.
    elec_complex_trial = nan(size(euler_complex,2),size(euler_complex,1));
    for ix_chan = 1:length(elec_used)
        elec_complex_trial(:,ix_chan) = squeeze(euler_complex(ix_chan,:,:))*trial_weights(:,ix_chan);
    end
    witpc_time = abs(mean(elec_complex_trial,2));
    disp('The given trial weights are electrode-level.');
end


end
