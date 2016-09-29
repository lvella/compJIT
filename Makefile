# Define compiler
CC := gcc
CF90 := gfortran

# Files to compile
SOURCE_FILES := \
	intermed.f90 \
	fmain.f90 \
	executaInput.c

OBJECT_FILES := $(addsuffix .o, $(basename $(SOURCE_FILES)))

EXE := exec

FLAGS := -g

$(EXE): $(OBJECT_FILES)
	$(CF90) $(OBJECT_FILES) -o $(EXE) $(FLAGS) -ldl

%.o: %.cpp
	$(CC) -std=c11 $(FLAGS) -c $<

%.o: %.f90
	$(CF90) $(FLAGS) -c $<

.PHONY: clean

clean:
	rm -f *.o *.mod $(EXE)
