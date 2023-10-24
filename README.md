# Weighted-inter-trial-phase-coherence (wITPC)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Description

We adjusted the calculation of ITPC with a power-based weighted average method to correct the trial weight by phase estimation accuracy, [Faller et al. (2022)](https://www.sciencedirect.com/science/article/pii/S1935861X22000365#bib49) has described the details of the weighted ITPC (wITPC) calculation .

This approach of calculating ITPC was slightly modified from the standard approach introduced by [Diepen and Mazaheri (2018)](https://www.nature.com/articles/s41598-018-20423-z) to account for the power difference in phase estimation (usually, higher power makes more creditable phase prediction). This modification is very helpful in our study since we used a phase-locked system for TMS triggering, and it will be beneficial to other studies where the power difference or phase estimation matters (in many cases it does). 

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [License](#license)
- [Credits](#credits)
- [Contact](#contact)

## Installation

No further installation needed. Function files are directly runnable in Matlab. 

## Usage

- Provided function file 'itpc.m' and 'witpc.m' that calculates the inter-trial phase coherence (itpc) and trial-weighted phase coherence (witpc) from given EEG epoch. 
- Provided function file 'trial_weight_power.m' and 'trial_weight_power_elec.m' to calculate trial weights (see function for details).

## Features

- Feature 1: Two different trial weight calculation methods are provided. (one is on a region-level, the other is on an electrode-level.)
- Feature 2: Example is provided in [example_car_face.mlx](example_car_face.mlx). Example data is available in [example_data](example_data/) folder.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). Refer to the [LICENSE](LICENSE) file for more information.

## Credits

This constitutes a segment of our branch's efforts within the closed-loop neuromodulation project. For a more comprehensive background, I encourage you to review our series of publications.


simultaneous fMRI-EEG-TMS: https://www.sciencedirect.com/science/article/pii/S1935861X23017746


phase-locked closed-loop EEG-rTMS: https://www.sciencedirect.com/science/article/pii/S1935861X22000365


Clinic outcomes: https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4334289

## Contact

For any inquiries or questions, you can reach me at [xiaoxiao.sun@columbia.edu]. Connect with me on [LinkedIn](https://www.linkedin.com/in/xiaoxiao-sun-b66012274/) for more updates and projects.
