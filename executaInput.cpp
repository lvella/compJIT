#include "cling/Interpreter/Interpreter.h"
#include <iostream>
#include <fstream>
#include <streambuf>
#include <sstream>
#include <string>
/** 
* @param fPath eh o caminho para o arquivo em C que será executado
* @param len eho tanho do nome do arquivo
* @param fName é o nome da fuco que se executada
* @param numDouble.. gama parametros da funcao 
* @param &argV end argV
* @param "/usr/local" llvm dir
*/

extern "C"{
extern void cfunc(char *fPath, int *len, char *fName, double *numDouble, double *a, double *C, double *h, double *y, double *v5, double *v6, double *v7, double *v8, double *v9, int *gama)
	{
	static double(*f)(double a, double C, double h,  double y, double v5, double v6, double v7, double v8, double v9, int gama) = nullptr;

//	std::cout<<"Valor do fPath = "<<fPath<<'\n';
	/* tratamento para final de String Fortran para C */	
	std::string path;
	int i;
	for (i = 0; i< *len; i++)
		path.push_back(fPath[i]);

	/* atribuo o codigo do aruivo para a string code */
	std::ifstream t(path); //arquivo de leitura
	std::stringstream buffer;
	buffer << t.rdbuf();
	std::string code = buffer.str();

	const char* const argV = "cling";
//	cling::Interpreter* gCling = new cling::Interpreter(1,&argV,"/home/julia/clonedr/inst");
	/* instancia interpretador Cling */
	cling::Interpreter* gCling = new cling::Interpreter(1,&argV,"/usr/local");
        if(f==nullptr){
		std::cout << "Primeira vez da execução: \n";
		f = (double (*)(double a, double C, double h, double y, double v5, double v6, double v7, double v8, double v9, int gama))  gCling->compileFunction(fName, code);
	}
	
	*numDouble=f(*a,*C,*h,*y,*v5,*v6,*v7,*v8,*v9,*gama);
	std::cout<<" Valor de y: "<<*y<<" ";
	}
}
