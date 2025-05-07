/*
 * File: swenson_shell_sort.c
 * Project: MEXsort (https://github.com/cyber-g/MEXsort)
 * Author: Germain PHAM
 * Date: 7th May 2025
 * 
 * Credits:
 * - Christopher Swenson, the maintainer of the `sort.h` library
 *   (https://github.com/swenson/sort), which implements a variety of sorting
 *   algorithms in C. 
 * 
 * Description:
 * This file provides a MATLAB MEX interface for the `shell_sort` function,
 * provided in the `sort.h` library. It demonstrate for MATLAB users how to
 * utilize the `shell_sort` function for sorting arrays of type `double`.
 * 
 * License: GNU General Public License v3.0
 */

#define SORT_NAME swenson
#define SORT_TYPE double
#define SORT_CMP(x, y) ((x) < (y) ? -1 : ((x) == (y) ? 0 : 1))

#include "sort.h"
#include "mex.h"

/*
   We now have the following functions defined
   * swenson_shell_sort
   * swenson_binary_insertion_sort
   * swenson_heap_sort
   * swenson_quick_sort
   * swenson_merge_sort
   * swenson_selection_sort
   * swenson_tim_sort

   Each takes two arguments: double *array, size_t size
*/

// Create Gateway Routine
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    // Declare Variables
    double *arr;
    size_t size;
    double *dst;

    // Verify MEX File Input and Output Parameters
    // Check for proper number of arguments
    if (nrhs != 1)
    {
        mexErrMsgIdAndTxt("MATLAB:swenson_shell_sort:invalidNumInputs", "One input required.");
    }
    if (nlhs != 1)
    {
        mexErrMsgIdAndTxt("MATLAB:swenson_shell_sort:maxlhs", "One output required.");
    }

    // Check if the input is a double column vector
    if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]))
    {
        mexErrMsgIdAndTxt("MATLAB:swenson_shell_sort:notDouble",
                          "Input matrix must be type double.");
    }
    if(mxGetN(prhs[0])!=1) {
        mexErrMsgIdAndTxt("MATLAB:swenson_shell_sort:notColVector","Input must be a column vector.");
    }

    // Get the pointer to the input matrix
    #if MX_HAS_INTERLEAVED_COMPLEX
    arr = mxGetDoubles(prhs[0]);
    #else
    arr = mxGetPr(prhs[0]);
    #endif
    // Get the size of the input matrix
    size = mxGetM(prhs[0]);

    // Create the output matrix
    plhs[0] = mxCreateDoubleMatrix(size, 1, mxREAL);

    // Get the pointer to the output matrix
    #if MX_HAS_INTERLEAVED_COMPLEX
    dst = mxGetDoubles(plhs[0]);
    #else
    dst = mxGetPr(plhs[0]);
    #endif

    // Copy the input matrix to the output matrix
    memcpy(dst, arr, sizeof(double) * size);

    // Call the sorting function (sort in place)
    swenson_shell_sort(dst, size);
}