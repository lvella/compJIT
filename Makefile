# Define compiler
CXX := g++
CF90 := gfortran

# Files to compile
SOURCE_FILES := \
	intermed.f90 \
	fmain.f90 \
	executaInput.cpp

OBJECT_FILES := $(addsuffix .o, $(basename $(SOURCE_FILES)))

EXE := exec

FLAGS := -g

$(EXE): $(OBJECT_FILES)
	g++ $(OBJECT_FILES) -o $(EXE) $(FLAGS) -lgfortran -ldl

%.o: %.cpp
	g++ -std=c++11 $(FLAGS) -c $<

%.o: %.f90
	gfortran $(FLAGS) -c $<

.PHONY: clean

clean:
	rm -f *.o *.mod $(EXE)
