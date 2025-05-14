# MEXsort
Porting `sort.h` to MATLAB

## Description
This repository contains a MATLAB port of the `sort.h` library
(https://github.com/swenson/sort), which is a C library for sorting algorithms.
The library provides a variety of sorting algorithms, including quicksort,
heapsort, and mergesort, among others. The goal of this project is to provide a
MATLAB demonstration of these algorithms for use in MATLAB applications.

## Usage
To use this library, you just need to do the following:
* Clone this repository with recursive option to get the submodules:
```bash
git clone --recurse-submodules https://github.com/cyber-g/MEXsort
```
* Compile the MEX files:
```bash
cd MEXsort
make
```
* Add the `MEXsort` directory to your MATLAB path:
```matlab
addpath('/path/to/MEXsort');
```
* Use the sorting functions in your MATLAB code. For example:
```matlab
A = [3, 1, 4, 1, 5, 9];
B = swenson_quick_sort(A(:)); % Only works for 1D column vectors
disp(B);
```
## Speed of routines
On my machine, I get the following timings for the `demo.m` script. 
Please note that the timings may vary depending on your machine. 
They are provided here as examples of the performance of the sorting algorithms.

### Random data (300k elements)

| Sorting Algorithm        | Time (seconds) |
|--------------------------|----------------|
| Built-in Sort            | 0.0047         |
| Binary Insertion Sort    | 7.4055         |
| Heap Sort                | 0.0310         |
| Merge Sort               | 0.0254         |
| Quick Sort               | 0.0182         |
| Selection Sort           | 106.3767       |
| Shell Sort               | 0.0299         |
| Tim Sort                 | 0.0233         |

The `built-in` sort function is the fastest which could be explained by a
possible multi-threaded implementation. The `quick sort` algorithm is the second
fastest. 

### Telecom data (~490k elements)

| Sorting Algorithm        | Time (seconds) |
|--------------------------|----------------|
| Built-in Sort            | 0.0121         |
| Binary Insertion Sort    | 21.2819        |
| Heap Sort                | 0.0512         |
| Merge Sort               | 0.0376         |
| Quick Sort               | 0.0279         |
| Selection Sort           | 134.5842       |
| Shell Sort               | 0.0478         |
| Tim Sort                 | 0.0377         |

Same comment as above. 

## Note
Please note that this demonstration configures the `sort.h` library to use
`double` type data. If you want to use other types, you will need to modify the
preprocessor directive in the C source files:
```c
#define SORT_TYPE double
```
This will require recompiling the MEX files.

## License
This project is licensed under the GNU General Public License v3.0. 

