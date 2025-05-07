# Makefile for MEXsort Project
# 
# Project: MEXsort (https://github.com/cyber-g/MEXsort)
# Author: Germain PHAM
# Date: 7th May 2025
# 
# This Makefile is used to compile MATLAB MEX functions for the MEXsort project.
#
# Description:
# - Compiles all source files matching the pattern `swenson_*.c` into MEX files.
# - Includes the `sort.h` library for sorting algorithm implementations.
# - Enables sort_extra.h via the `SET_SORT_EXTRA` macro.
#
# Usage:
# - Run `make` to build all MEX files.
# - Run `make clean` to remove all compiled MEX files.
#
# License:
# GNU General Public License v3.0

mexfunctions = $(wildcard swenson_*.c)
mexobjects = $(patsubst %.c,%.mexa64,$(mexfunctions))

MEX:= /usr/local/bin/mex
SORT_LIB_PATH:= $(realpath ./sort/)
SORT_LIB_HEADERS:= $(wildcard $(SORT_LIB_PATH)/*.h)

EXTRA = -DSET_SORT_EXTRA

all: $(mexobjects)

%.mexa64: %.c $(SORT_LIB_HEADERS)
	$(MEX) $(EXTRA) -largeArrayDims -I$(SORT_LIB_PATH) $<

clean:
	rm -f $(mexobjects)