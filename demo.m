% DEMO - Demo file of the MEXsort project
% This script benchmarks various sorting algorithms provided by the Swenson's
% sort.h library and compares their performance with MATLAB's built-in `sort`
% function.
% 
% Compilation of the C source files must be done before running this script.
% Please run in a terminal to compile the MEX files: 
% ```bash
% make
% ```
% 
% Other m-files required: None
% Subfunctions: swenson_binary_insertion_sort, swenson_heap_sort, swenson_merge_sort,
%           swenson_quick_sort, swenson_selection_sort, swenson_shell_sort, swenson_tim_sort
% MAT-files required: None
% 
% See also: sort.h, demo.c (https://github.com/swenson/sort)
% 
% Thanks:
%    Denis Gilbert (2025). M-file Header Template
%    (https://www.mathworks.com/matlabcentral/fileexchange/4908-m-file-header-template),
%    MATLAB Central File Exchange. Accessed on April 26, 2025. 
% 
%    Swenson's sort.h library (2024). Sorting routine implementations in "template" C
%    (https://github.com/swenson/sort),
%    GitHub. Accessed on May 07, 2025.
% 
%    Analog Devices Inc. (2025). IIO Oscilloscope - waveforms
%    (https://github.com/analogdevicesinc/iio-oscilloscope/)
%    GitHub. Accessed on May 07, 2025.
% 
% License:
% GNU General Public License v3.0
% 
% Author: Germain PHAM
% email: cygerpham@free.fr
% May 2025; Last revision: 

% Enable the equality check
assert_equality = false;

% Type of data to be sorted
data_type = 'random'; % Please set to 'random' or 'telecom'

if strcmp(data_type, 'telecom')
    % Telecom data
    % check if ./data directory exists
    if ~exist('./data', 'dir')
        % Create the directory
        mkdir('./data');
        % Download the telecom data file
        url = 'https://github.com/analogdevicesinc/iio-oscilloscope/raw/refs/heads/main/waveforms/Tx_20MHz_245.76Msps_PeakScaling3.0dBFS_ETM1.1_PAR7.5dB_Offset0MHz.txt';
        unix(['wget -P ./data ' url]);
    end
    
    % Load telecom data from the provided file
    data_IQ =readmatrix('./data/Tx_20MHz_245.76Msps_PeakScaling3.0dBFS_ETM1.1_PAR7.5dB_Offset0MHz.txt','NumHeaderLines', 1);

    data = abs(complex(data_IQ(:, 1), data_IQ(:, 2)));
    % Normalize the data to 1 RMS
    data = data / sqrt(mean(data.^2));
else
    % Random data
    % Generate random data for testing
    data = randn(300e3, 1);
end

% Builtin MATLAB sort function
disp('MATLAB builtin sort');
disp('----------------------------------');
timeit(@() sort(data))
disp('----------------------------------');

% Sorting algorithms (from Swenson's sort.h) with timing
disp('Sorting algorithms with timing');
disp('----------------------------------');
disp('Binary Insertion Sort');
timeit(@() swenson_binary_insertion_sort(data))
disp('Heap Sort');
timeit(@() swenson_heap_sort(data))
disp('Merge Sort');
timeit(@() swenson_merge_sort(data))
disp('Quick Sort');
timeit(@() swenson_quick_sort(data))
disp('Selection Sort');
timeit(@() swenson_selection_sort(data))
disp('Shell Sort');
timeit(@() swenson_shell_sort(data))
disp('Tim Sort');
timeit(@() swenson_tim_sort(data))
disp('----------------------------------');


if assert_equality
    % Built-in MATLAB sort function
    builtin_sort = sort(data);
    % Compare the results of the sorting algorithms with MATLAB's builtin sort
    sw_binary_insertion_result = swenson_binary_insertion_sort(data);
    sw_heap_result             = swenson_heap_sort(data);
    sw_merge_result            = swenson_merge_sort(data);
    sw_quick_result            = swenson_quick_sort(data);
    sw_selection_result        = swenson_selection_sort(data);
    sw_shell_sort_result       = swenson_shell_sort(data);
    sw_tim_result              = swenson_tim_sort(data);

    % Check if the results are equal
    isequal(builtin_sort, sw_binary_insertion_result)
    isequal(builtin_sort, sw_heap_result)
    isequal(builtin_sort, sw_merge_result)
    isequal(builtin_sort, sw_quick_result)
    isequal(builtin_sort, sw_selection_result)
    isequal(builtin_sort, sw_shell_sort_result)
    isequal(builtin_sort, sw_tim_result)
end

%------------- END OF CODE --------------
