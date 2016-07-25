# Define compiler
CXX := g++
CF90 := gfortran

# Files to compile
CPPFILE := programaTeste.cpp
FFILE := fort2cppsub.f90
MFILE := fmain.f90

# Exec
EXE := exec

# Objs 
CPPOBJ := $(patsubst %.cpp, %.o, $(CPPFILE))
FOBJ := $(patsubst %.f90, %.o, $(FFILE))

# LLVM FLAGS
CXXFLAGS :=  $(shell llvm-config --cxxflags) -v
CXXFLAGS :=  $(patsubst -O3,-O0, $(CXXFLAGS))

# Interoperability Fortran C++
FFLAGS := -lgfortran

LLVMLIBS := $(shell llvm-config --libs)
#LLVMLIBFILES := $(shell llvm-config --libfiles)


CLANGLIBS := -lclangFrontend -lclangSerialization -lclangDriver -lclangCodeGen -lclangParse -lclangSema -lclangStaticAnalyzerFrontend -lclangStaticAnalyzerCheckers -lclangStaticAnalyzerCore -lclangAnalysis -lclangRewriteFrontend -lclangEdit -lclangAST -lclangLex -lclangBasic -lclangFrontend -lclangCodeGen -lclangParse -lclangBasic -lclangSerialization -lclangDriver -lclangEdit -lclangLex -lclangTooling -lclangAnalysis -lclangAST 

CLINGLIBS := -lclingMetaProcessor -lclingInterpreter -lclingUtils

# LLVMSYSFLAGS
#OTHERLIBS := -lrt -ldl -ltinfo -latomic -lz -lm -lpthread
OTHERLIBS := -ldl -ltinfo -lz -lm -lpthread


all:
	$(CF90) -c $(FFILE)
	$(CF90) -c $(MFILE)
	$(CXX) $(CXXFLAGS) -o $(EXE) $(MFILE) $(CPPFILE) $(LFLAGS) $(CLINGLIBS)	$(CLANGLIBS) $(LLVMLIBS) -L/usr/local/lib $(OTHERLIBS) $(LLVMLIBFILES) $(FFLAGS)

clean:
	rm -f *.o *.mod $(EXE)

run:
	./$(EXE)
