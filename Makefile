# Define compiler
CXX := g++
CF90 := gfortran

# Files to compile
SOURCE_FILES := \
	executaInput.cpp \
	intermed.f90 \
	fmain.f90

OBJECT_FILES := $(addsuffix .o, $(basename $(SOURCE_FILES)))

EXE := exec

FFLAGS := -lgfortran

$(EXE): $(OBJECT_FILES)
	g++ $(OBJECT_FILES) -o $(EXE) -lgfortran -ldl

%.o: %.cpp
	g++ -std=c++11 -c $<

%.o: %.f90
	gfortran -c $<

.PHONY: clean

clean:
	rm -f *.o *.mod $(EXE)
