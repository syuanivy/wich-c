#include <stdio.h>
#include "wich.h"

Vector * x;

void bar(Vector * x);

void bar(Vector * x)
{
	REF(x);
	COPY_ON_WRITE(x);
	x->data[1-1] = 100;
	print_vector(x);
	DEREF(x);
}

int main(int argc, char *argv[])
{
	x = Vector_new((double []){1,2,3}, 3);
    REF(x);
	bar(x);
	COPY_ON_WRITE(x);
	x->data[1-1] = 99;
	print_vector(x);
	DEREF(x);
	return 0;
}