#include <stdio.h>
#include "wich.h"
#include "refcounting.h"

void bar(PVector_ptr x);

void bar(PVector_ptr x)
{
    ENTER();
    REF((void *)x.vector);
    set_ith(x, 1-1, 100);
    print_vector(x);

    EXIT();
}


int main(int ____c, char *____v[])
{
	setup_error_handlers();
    ENTER();

    VECTOR(x);
    x = Vector_new((double[]) {1, 2, 3}, 3);
    REF((void *)x.vector);
    bar(PVector_copy(x));
    set_ith(x, 2 - 1, 99);
    print_vector(x);
    EXIT();
	return 0;
}

