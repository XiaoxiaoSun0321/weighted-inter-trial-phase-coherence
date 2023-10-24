function itpc_time = itpc(eeg_data,elec_used)
%function itpc calculates the inter-trial phase coherence for a given data.

%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eeg_data: eeg data used to calculate inter-trial phase coherence (itpc).%
%           structure of eeg_data matrix should be channels*time*trials   %
% elec_used: eeg electrodes used for calculation. e.g., [1,2,3] indicates %
%           used electrode location 1,2,3 in matrix will be used.         %
%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% itpc_time: itpc value where the length is time, value in [0,1].         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

channel_num = size(eeg_data,1);

% Check if ROI electrode is provided
if nargin < 2
    % Use a default value to calculate across all electrodes if not provided
    elec_used = linspace(1,channel_num,channel_num);  % Replace with your default value if needed
    disp('No ROI specified, so all electrodes will be used.')
end

% Obtain hilbert transform of the ROI
eeg_angles = angle(hilbert(eeg_data(elec_used,:,:)));

% Apply Euler's formula
euler_complex = exp(1i*eeg_angles);

% Average across electrodes 
avg_roi_complex = mean(euler_complex,1);

% Average across trials, no trial-weighted
itpc_time = abs(mean(avg_roi_complex,3));

end