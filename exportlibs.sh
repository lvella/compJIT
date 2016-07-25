#!/bin/bash
#BASE=/opt/apps/llvm/3.9
BASE=/home/julia/clonedr/inst

export PATH=$BASE/bin:$PATH
export INCLUDE=$BASE/include:$INCLUDE
export C_INCLUDE_PATH=$BASE/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$BASE/include:$CPLUS_INCLUDE_PATH
export CPATH=$BASE/include:$CPATH
export LD_LIBRARY_PATH=$BASE/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$BASE/lib:$LD_LIBRARY_PATH
