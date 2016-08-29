#include <cmath>

extern "C"{

double f1(double a, double C, double h, double y, double v5, double v6, double v7, double v8, double v9, int gama){

	a = 2;
	return ((C)*(1 - pow( ((y) - ((a)/2 + (h)))/ ((a)/2), (gama)))) + 100;
	}

}
