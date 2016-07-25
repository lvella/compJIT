#include "cling/Interpreter/Interpreter.h"
#include <iostream>
#include <fstream>
#include <streambuf>
#include <sstream>
#include <string>
/** 
*@param 1 nro de argumentos
*@param &argV end argV
*@param "/usr/local" llvm dir
*/

extern "C"{
extern void cfunc(char *fPath, int *len, char *fName, double *numDouble, double *a, double *C, double *h, double *y, double *v5, double *v6, double *v7, double *v8, double *v9, int *gama)
	{
	static double(*f)(double *a, double *C, double *h,  double *y, double *v5, double *v6, double *v7, double *v8, double *v9, int *gama) = nullptr;

//	std::cout<<"Valor do fPath = "<<fPath<<'\n';	
	std::string path;
	int i;
	for (i = 0; i< *len; i++)
		path.push_back(fPath[i]);
//	std::cout<<"Valor do path = "<<path<<"\n";
	std::ifstream t(path); //arquivo de leitura
	std::stringstream buffer;
	buffer << t.rdbuf();
	std::string code = buffer.str();

	const char* const argV = "cling";
	cling::Interpreter* gCling = new cling::Interpreter(1,&argV,"/usr/local");
//	cling::Interpreter* gCling = new cling::Interpreter(1,&argV,"/home/julia/clonedr/inst");
        if(f==nullptr){
		std::cout << "Primeira vez da execução: \n";
		f = (double (*)(double *a, double *C, double *h, double *y, double *v5, double *v6, double *v7, double *v8, double *v9, int *gama))  gCling->compileFunction(fName, code);
	}
	else
	std::cout<<" Valor de y: "<<*y<<" ";
	
	*numDouble=f(a,C,h,y,v5,v6,v7,v8,v9,gama);
	}
}
