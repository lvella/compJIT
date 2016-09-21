#include <iostream>
#include <streambuf>
#include <sstream>
#include <string>
#include <random>

#include <unistd.h>
#include <dlfcn.h>

/**
* @param fPath eh o caminho para o arquivo em C que será executado
* @param len eho tanho do nome do arquivo
* @param fName é o nome da fuco que se executada
* @param numDouble.. gama parametros da funcao
* @param &argV end argV
* @param "/usr/local" llvm dir
*/

static std::string gen_rand_name()
{
	const std::string alphabet("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789");
	std::uniform_int_distribution<> d(0, alphabet.size()-1);
	std::mt19937 g(std::random_device{}());

	std::string name("/tmp/");
	for(unsigned i = 0; i < 30; ++i) {
		name.push_back(alphabet[d(g)]);
	}

	return name + ".so";
}

extern "C"{
extern void cfunc(char *fPath, int *len, char *fName, double *numDouble, double *a, double *C, double *h, double *y, double *v5, double *v6, double *v7, double *v8, double *v9, int *gama);
}

void cfunc(char *fPath, int *len, char *fName, double *numDouble, double *a, double *C, double *h, double *y, double *v5, double *v6, double *v7, double *v8, double *v9, int *gama)
	{
	static double(*f)(double a, double C, double h,  double y, double v5, double v6, double v7, double v8, double v9, int gama) = nullptr;

        if(!f){
		std::string path(fPath, *len);
		std::string libname = gen_rand_name();

		// Call g++ on the file...
		{
			std::stringstream cmd;
			cmd << "g++ -shared -o " << libname
				<< " -O3 -fPIC -flto -march=native -mtune=native " << path;
			int ret = system(cmd.str().c_str());

			if(ret != 0) {
				std::cerr << "Compilation error!" << std::endl;
				return;
			}
		}

		// Open the just compiled file
		void* libhandle = dlopen(libname.c_str(), RTLD_LAZY);

		// Delete it, for it is no longer needed
		unlink(libname.c_str());

		f = (double (*)(double a, double C, double h, double y, double v5, double v6, double v7, double v8, double v9, int gama)) dlsym(libhandle, fName);
		if(f) {
			std::cout << "Function \"" << fName << "\" correctly loaded from file \"" << path << "\"." << std::endl;
		} else {
			std::cerr << "Error: Function \"" << fName << "\" not found in file \""
				<< path << "\"." << std::endl;
			return;
		}
	}

	*numDouble = f(*a,*C,*h,*y,*v5,*v6,*v7,*v8,*v9,*gama);
	std::cout<<" Valor de y: "<< *y <<" ";
}
