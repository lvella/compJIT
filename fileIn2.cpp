#include <cmath>

extern "C"{
	double f2(double* a, double* C, double* h, int* gama, double* y){

		return ((*C)*(1 - pow( ((*y+1) - ((*a)/2 + (*h)))/ ((*a)/2), (*gama))));
	}
}
