#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <unistd.h>
#include <dlfcn.h>

static void gen_rand_name(char *ret, size_t size)
{
	static const char alphabet[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	// Seed random number generator
	{
		FILE *f = fopen("/dev/urandom", "r");
		unsigned seed;
		fread(&seed, sizeof(seed), 1, f);
		fclose(f);
		srand(seed);
	}

	for(unsigned i = 0; i < size; ++i) {
		unsigned idx = (rand() / (double)RAND_MAX) * sizeof(alphabet);
		ret[i] = alphabet[idx];
	}
}

void load_module(char* fPath, void** ctx)
{
	char libname[] = "/tmp/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.so";
	gen_rand_name(&libname[5], 30);

	// Call compiler on the file...
	char cmd[500];
	snprintf(cmd, sizeof(cmd),
		"gfortran -shared -o %s -O3 -fPIC -flto -march=native -mtune=native %s",
		libname, fPath);
	int ret = system(cmd);

	if(ret != 0) {
		fprintf(stderr, "Compilation error on file \"%s\"!", fPath);
		*ctx = NULL;
		return;
	}

	// Open the just compiled file
	*ctx = dlopen(libname, RTLD_LAZY);

	// Delete it, for it is no longer needed
	unlink(libname);
}

void load_func(void** ctx, char* fName, void** func)
{
	*func = dlsym(*ctx, fName);
}
