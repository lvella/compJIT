# Define compiler
CXX := clang++
CF90 := gfortran

# Files to compile
CPPFILE := executaInput.cpp
FFILE := intermed.f90
MFILE := fmain.f90

# Exec
EXE := exec

# Objs 
CPPOBJ := $(patsubst %.cpp, %.o, $(CPPFILE))
FOBJ := $(patsubst %.f90, %.o, $(FFILE))

# Interoperability Fortran C++
FFLAGS := -lgfortran

# LLVM FLAGS
CXXFLAGS :=  $(shell llvm-config --cxxflags) 
CXXFLAGS :=  $(patsubst -O3,-O0, $(CXXFLAGS))

LLVMLIBS := $(shell llvm-config --libs)
#LLVMLIBFILES := $(shell llvm-config --libfiles)

CLANGLIBS := -lclangFrontend -lclangSerialization -lclangDriver -lclangCodeGen -lclangParse -lclangSema -lclangStaticAnalyzerFrontend -lclangStaticAnalyzerCheckers -lclangStaticAnalyzerCore -lclangAnalysis -lclangRewriteFrontend -lclangEdit -lclangAST -lclangLex -lclangBasic -lclangFrontend -lclangCodeGen -lclangParse -lclangBasic -lclangSerialization -lclangDriver -lclangEdit -lclangLex -lclangTooling -lclangAnalysis -lclangAST 

CLINGLIBS := -lclingMetaProcessor -lclingInterpreter -lclingUtils

LD_FLAGS := $(shell llvm-config --ldflags)

#OTHERLIBS := -lrt -ldl -ltinfo -latomic -lz -lm -lpthread
OTHERLIBS := $(shell llvm-config --system-libs) 


all:
	$(CF90) -c $(FFILE)
	$(CF90) -c $(MFILE)
	$(CXX) $(CXXFLAGS) -o $(EXE) $(MFILE) $(CPPFILE) $(LFLAGS) $(CLINGLIBS)	$(CLANGLIBS) $(LLVMLIBS) $(LD_FLAGS) $(OTHERLIBS) $(LLVMLIBFILES) $(FFLAGS)

clean:
	rm -f *.o *.mod $(EXE)

run:
	./$(EXE)
